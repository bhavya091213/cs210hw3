from typing import Tuple, List, Set


# ---------- small helpers ----------

def _get_or_create_artist(mydb, cursor, name: str, cache: dict) -> int:
    """Return artist_id for given name, inserting if needed."""
    if name in cache:
        return cache[name]
    cursor.execute("SELECT artist_id FROM artists WHERE name = %s", (name,))
    row = cursor.fetchone()
    if row:
        artist_id = row[0]
    else:
        cursor.execute("INSERT INTO artists (name) VALUES (%s)", (name,))
        artist_id = cursor.lastrowid
    cache[name] = artist_id
    return artist_id


def _get_or_create_genre(mydb, cursor, name: str, cache: dict) -> int:
    """Return genre_id for given genre name, inserting if needed."""
    if name in cache:
        return cache[name]
    cursor.execute("SELECT genre_id FROM genres WHERE name = %s", (name,))
    row = cursor.fetchone()
    if row:
        genre_id = row[0]
    else:
        cursor.execute("INSERT INTO genres (name) VALUES (%s)", (name,))
        genre_id = cursor.lastrowid
    cache[name] = genre_id
    return genre_id


# ---------- required functions ----------

def clear_database(mydb):
    """
    Deletes all the rows from all the tables of the database.
    Child tables are deleted before parent tables to satisfy FKs.
    """
    cursor = mydb.cursor()
    # delete from children first
    tables = ["ratings", "song_genres", "songs", "albums", "users", "genres", "artists"]
    for t in tables:
        cursor.execute(f"DELETE FROM {t}")
    mydb.commit()
    cursor.close()


def load_single_songs(
    mydb, single_songs: List[Tuple[str, Tuple[str, ...], str, str]]
) -> Set[Tuple[str, str]]:
    """
    Add single songs to the database.

    single_songs: list of (song_title, genre_names_tuple, artist_name, release_date)
    """
    rejects: Set[Tuple[str, str]] = set()
    cursor = mydb.cursor()

    artist_cache = {}
    genre_cache = {}

    for title, genre_names, artist_name, release_date in single_songs:
        # get / create artist
        artist_id = _get_or_create_artist(mydb, cursor, artist_name, artist_cache)

        # check if (artist, title) already exists (single or album track)
        cursor.execute(
            """
            SELECT song_id FROM songs
            WHERE title = %s AND artist_id = %s
            """,
            (title, artist_id),
        )
        if cursor.fetchone():
            rejects.add((title, artist_name))
            continue

        # insert song as single (album_id NULL)
        cursor.execute(
            """
            INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
            VALUES (%s, %s, NULL, 1, %s)
            """,
            (title, artist_id, release_date),
        )
        song_id = cursor.lastrowid

        # at least one genre; add mapping rows
        for gname in genre_names:
            genre_id = _get_or_create_genre(mydb, cursor, gname, genre_cache)
            cursor.execute(
                """
                INSERT INTO song_genres (song_id, genre_id)
                VALUES (%s, %s)
                """,
                (song_id, genre_id),
            )

    mydb.commit()
    cursor.close()
    return rejects


def get_most_prolific_individual_artists(
    mydb, n: int, year_range: Tuple[int, int]
) -> List[Tuple[str, int]]:
    """
    Get the top n most prolific artists by number of singles released in a year range.
    """
    start_year, end_year = year_range
    cursor = mydb.cursor()
    cursor.execute(
        """
        SELECT a.name, COUNT(*) AS num_singles
        FROM songs s
        JOIN artists a ON s.artist_id = a.artist_id
        WHERE s.is_single = 1
          AND YEAR(s.release_date) BETWEEN %s AND %s
        GROUP BY a.artist_id, a.name
        ORDER BY num_singles DESC, a.name ASC
        LIMIT %s
        """,
        (start_year, end_year, n),
    )
    results = [(name, cnt) for (name, cnt) in cursor.fetchall()]
    cursor.close()
    return results


def get_artists_last_single_in_year(mydb, year: int) -> Set[str]:
    """
    Get all artists who released their last single in the given year.
    """
    cursor = mydb.cursor()
    # For each artist, look at the max release_date among singles;
    # include artist if that max date's year == given year.
    cursor.execute(
        """
        SELECT a.name
        FROM artists a
        JOIN songs s ON a.artist_id = s.artist_id
        WHERE s.is_single = 1
        GROUP BY a.artist_id, a.name
        HAVING YEAR(MAX(s.release_date)) = %s
        """,
        (year,),
    )
    artists = {row[0] for row in cursor.fetchall()}
    cursor.close()
    return artists


def load_albums(
    mydb, albums: List[Tuple[str, str, str, str, List[str]]]
) -> Set[Tuple[str, str]]:
    """
    Add albums to the database.

    albums: list of (album_title, genre_name, artist_name, release_date, [song_titles])
    """
    rejects: Set[Tuple[str, str]] = set()
    cursor = mydb.cursor()

    artist_cache = {}
    genre_cache = {}

    for album_title, genre_name, artist_name, release_date, song_titles in albums:
        artist_id = _get_or_create_artist(mydb, cursor, artist_name, artist_cache)
        genre_id = _get_or_create_genre(mydb, cursor, genre_name, genre_cache)

        # check if artist already has album with this title
        cursor.execute(
            """
            SELECT album_id FROM albums
            WHERE title = %s AND artist_id = %s
            """,
            (album_title, artist_id),
        )
        row = cursor.fetchone()
        if row:
            rejects.add((album_title, artist_name))
            continue

        # insert album
        cursor.execute(
            """
            INSERT INTO albums (title, artist_id, release_date, genre_id)
            VALUES (%s, %s, %s, %s)
            """,
            (album_title, artist_id, release_date, genre_id),
        )
        album_id = cursor.lastrowid

        # insert songs belonging to this album
        for song_title in song_titles:
            # enforce "artist cannot record same title twice"
            cursor.execute(
                """
                SELECT song_id FROM songs
                WHERE title = %s AND artist_id = %s
                """,
                (song_title, artist_id),
            )
            if cursor.fetchone():
                # if such a conflict happens, just skip this song
                continue

            cursor.execute(
                """
                INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
                VALUES (%s, %s, %s, 0, %s)
                """,
                (song_title, artist_id, album_id, release_date),
            )
            song_id = cursor.lastrowid

            # every album track is in the album's genre
            cursor.execute(
                """
                INSERT INTO song_genres (song_id, genre_id)
                VALUES (%s, %s)
                """,
                (song_id, genre_id),
            )

    mydb.commit()
    cursor.close()
    return rejects


def get_top_song_genres(mydb, n: int) -> List[Tuple[str, int]]:
    """
    Get n genres that are most represented in terms of number of songs in that genre.
    Songs include singles as well as songs in albums.
    """
    cursor = mydb.cursor()
    cursor.execute(
        """
        SELECT g.name, COUNT(sg.song_id) AS num_songs
        FROM genres g
        JOIN song_genres sg ON g.genre_id = sg.genre_id
        JOIN songs s ON sg.song_id = s.song_id
        GROUP BY g.genre_id, g.name
        ORDER BY num_songs DESC, g.name ASC
        LIMIT %s
        """,
        (n,),
    )
    results = [(name, cnt) for (name, cnt) in cursor.fetchall()]
    cursor.close()
    return results


def get_album_and_single_artists(mydb) -> Set[str]:
    """
    Get artists who have released albums as well as singles.
    """
    cursor = mydb.cursor()
    cursor.execute(
        """
        SELECT DISTINCT a.name
        FROM artists a
        WHERE EXISTS (
            SELECT 1 FROM albums al
            WHERE al.artist_id = a.artist_id
        )
        AND EXISTS (
            SELECT 1 FROM songs s
            WHERE s.artist_id = a.artist_id AND s.is_single = 1
        )
        """
    )
    result = {row[0] for row in cursor.fetchall()}
    cursor.close()
    return result


def load_users(mydb, users: List[str]) -> Set[str]:
    """
    Add users to the database.

    Returns set of usernames that were rejected as duplicates.
    """
    rejects: Set[str] = set()
    cursor = mydb.cursor()

    for username in users:
        # check if already exists
        cursor.execute(
            "SELECT username FROM users WHERE username = %s", (username,)
        )
        if cursor.fetchone():
            rejects.add(username)
            continue

        cursor.execute("INSERT INTO users (username) VALUES (%s)", (username,))

    mydb.commit()
    cursor.close()
    return rejects


def load_song_ratings(
    mydb, song_ratings: List[Tuple[str, Tuple[str, str], int, str]]
) -> Set[Tuple[str, str, str]]:
    """
    Load ratings for songs (either singles or album tracks).

    song_ratings: list of (username, (artist_name, song_title), rating, date)
    """
    rejects: Set[Tuple[str, str, str]] = set()
    cursor = mydb.cursor()

    for username, (artist_name, song_title), rating, rating_date in song_ratings:
        key = (username, artist_name, song_title)

        # (a) user must exist
        cursor.execute(
            "SELECT username FROM users WHERE username = %s", (username,)
        )
        user_row = cursor.fetchone()
        if not user_row:
            rejects.add(key)
            continue

        # (b) song (artist, title) must exist
        cursor.execute(
            """
            SELECT s.song_id
            FROM songs s
            JOIN artists a ON s.artist_id = a.artist_id
            WHERE a.name = %s AND s.title = %s
            """,
            (artist_name, song_title),
        )
        row = cursor.fetchone()
        if not row:
            rejects.add(key)
            continue

        song_id = row[0]

        # (c) user must not have rated this song already
        cursor.execute(
            """
            SELECT 1 FROM ratings
            WHERE username = %s AND song_id = %s
            """,
            (username, song_id),
        )
        if cursor.fetchone():
            rejects.add(key)
            continue

        # (d) rating must be in 1..5
        if not (1 <= rating <= 5):
            rejects.add(key)
            continue

        # insert rating
        cursor.execute(
            """
            INSERT INTO ratings (username, song_id, rating, rating_date)
            VALUES (%s, %s, %s, %s)
            """,
            (username, song_id, rating, rating_date),
        )

    mydb.commit()
    cursor.close()
    return rejects


def get_most_rated_songs(
    mydb, year_range: Tuple[int, int], n: int
) -> List[Tuple[str, str, int]]:
    """
    Get the top n most rated songs in the given year range (inclusive),
    ranked by number of ratings (desc), breaking ties by song title (asc).
    """
    start_year, end_year = year_range
    cursor = mydb.cursor()
    cursor.execute(
        """
        SELECT s.title, a.name, COUNT(*) AS num_ratings
        FROM ratings r
        JOIN songs s ON r.song_id = s.song_id
        JOIN artists a ON s.artist_id = a.artist_id
        WHERE YEAR(r.rating_date) BETWEEN %s AND %s
        GROUP BY s.song_id, s.title, a.name
        ORDER BY num_ratings DESC, s.title ASC
        LIMIT %s
        """,
        (start_year, end_year, n),
    )
    results = [(title, artist, cnt) for (title, artist, cnt) in cursor.fetchall()]
    cursor.close()
    return results


def get_most_engaged_users(
    mydb, year_range: Tuple[int, int], n: int
) -> List[Tuple[str, int]]:
    """
    Get the top n most engaged users, in terms of number of songs they have rated
    in the given year range. Break ties by username alphabetically.
    """
    start_year, end_year = year_range
    cursor = mydb.cursor()
    cursor.execute(
        """
        SELECT u.username, COUNT(*) AS num_rated
        FROM ratings r
        JOIN users u ON r.username = u.username
        WHERE YEAR(r.rating_date) BETWEEN %s AND %s
        GROUP BY u.username
        ORDER BY num_rated DESC, u.username ASC
        LIMIT %s
        """,
        (start_year, end_year, n),
    )
    results = [(username, cnt) for (username, cnt) in cursor.fetchall()]
    cursor.close()
    return results


def main():
    # Not used by Autolab; you can put your own local tests here if you want.
    pass


if __name__ == "__main__":
    main()
