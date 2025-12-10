from typing import Tuple, List, Set


# ---------- Helper functions (internal only) ----------

def _get_artist_id(cursor, artist_name: str) -> int:
    """Return artist_id for name, creating the artist if needed."""
    cursor.execute(
        "SELECT artist_id FROM artists WHERE name = %s",
        (artist_name,)
    )
    row = cursor.fetchone()
    if row:
        return row[0]

    cursor.execute(
        "INSERT INTO artists (name) VALUES (%s)",
        (artist_name,)
    )
    return cursor.lastrowid


def _get_genre_id(cursor, genre_name: str) -> int:
    """Return genre_id for name, creating the genre if needed."""
    cursor.execute(
        "SELECT genre_id FROM genres WHERE name = %s",
        (genre_name,)
    )
    row = cursor.fetchone()
    if row:
        return row[0]

    cursor.execute(
        "INSERT INTO genres (name) VALUES (%s)",
        (genre_name,)
    )
    return cursor.lastrowid


# ---------- Required functions ----------

def clear_database(mydb):
    """
    Deletes all the rows from all the tables of the database.
    If a table has a foreign key to a parent table, it is deleted before 
    deleting the parent table, otherwise the database system will throw an error. 

    Args:
        mydb: database connection
    """
    cursor = mydb.cursor()
    # Safest way: temporarily disable FK checks, delete everything, then re-enable.
    cursor.execute("SET FOREIGN_KEY_CHECKS = 0")

    for table in ["ratings", "song_genres", "songs", "albums", "users", "genres", "artists"]:
        cursor.execute(f"DELETE FROM {table}")

    cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
    mydb.commit()
    cursor.close()


def load_single_songs(mydb, single_songs: List[Tuple[str, Tuple[str, ...], str, str]]) -> Set[Tuple[str, str]]:
    """
    Add single songs to the database. 

    Args:
        mydb: database connection
        
        single_songs: List of single songs to add. Each single song is a tuple of the form:
              (song title, genre names, artist name, release date)
        Genre names is a tuple since a song could belong to multiple genres
        Release date is of the form yyyy-mm-dd

    Returns:
        Set[Tuple[str,str]]: set of (song,artist) for combinations that already exist 
        in the database and were not added (rejected). 
        Set is empty if there are no rejects.
    """
    cursor = mydb.cursor()
    rejected: Set[Tuple[str, str]] = set()

    for title, genre_names, artist_name, release_date in single_songs:
        # Enforce "every song has at least one genre"
        if not genre_names:
            rejected.add((title, artist_name))
            continue

        artist_id = _get_artist_id(cursor, artist_name)

        # Check if this artist already has a song with the same title
        cursor.execute(
            "SELECT song_id FROM songs WHERE title = %s AND artist_id = %s",
            (title, artist_id)
        )
        if cursor.fetchone():
            rejected.add((title, artist_name))
            continue

        # Insert song as a single (album_id = NULL, is_single = 1)
        cursor.execute(
            """
            INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
            VALUES (%s, %s, NULL, 1, %s)
            """,
            (title, artist_id, release_date)
        )
        song_id = cursor.lastrowid

        # Insert genres
        for gname in genre_names:
            genre_id = _get_genre_id(cursor, gname)
            # Avoid duplicate (song_id, genre_id) pairs
            cursor.execute(
                """
                INSERT IGNORE INTO song_genres (song_id, genre_id)
                VALUES (%s, %s)
                """,
                (song_id, genre_id)
            )

    mydb.commit()
    cursor.close()
    return rejected


def get_most_prolific_individual_artists(
    mydb, n: int, year_range: Tuple[int, int]
) -> List[Tuple[str, int]]:
    """
    Get the top n most prolific individual artists by number of singles released in a year range. 
    Break ties by alphabetical order of artist name.

    Args:
        mydb: database connection
        n: how many to get
        year_range: tuple, e.g. (2015,2020)

    Returns:
        List[Tuple[str,int]]: list of (artist name, number of songs) tuples.
        If there are fewer than n artists, all of them are returned.
        If there are no artists, an empty list is returned.
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
        (start_year, end_year, n)
    )
    rows = cursor.fetchall()
    cursor.close()
    return [(name, num) for (name, num) in rows]


def get_artists_last_single_in_year(mydb, year: int) -> Set[str]:
    """
    Get all artists who released their last single in the given year.
    
    Args:
        mydb: database connection
        year: year of last release
        
    Returns:
        Set[str]: set of artist names
        If there is no artist with a single released in the given year, an empty set is returned.
    """
    cursor = mydb.cursor()
    # For each artist, compute the max(single release_date); keep artists whose
    # last single falls in the given year.
    cursor.execute(
        """
        SELECT a.name
        FROM songs s
        JOIN artists a ON s.artist_id = a.artist_id
        WHERE s.is_single = 1
        GROUP BY a.artist_id, a.name
        HAVING YEAR(MAX(s.release_date)) = %s
        """,
        (year,)
    )
    rows = cursor.fetchall()
    cursor.close()
    return {name for (name,) in rows}


def load_albums(
    mydb, albums: List[Tuple[str, str, str, str, List[str]]]
) -> Set[Tuple[str, str]]:
    """
    Add albums to the database. 
    
    Args:
        mydb: database connection
        
        albums: List of albums to add. Each album is a tuple of the form:
              (album title, genre, artist name, release date, list of song titles) 
        Release date is of the form yyyy-mm-dd

    Returns:
        Set[Tuple[str,str]: set of (album, artist) combinations that were not added (rejected) 
        because the artist already has an album of the same title OR because adding the
        album would violate the constraint that an artist cannot record the same song title
        more than once.
        Set is empty if there are no rejects.
    """
    cursor = mydb.cursor()
    rejected: Set[Tuple[str, str]] = set()

    for album_title, genre_name, artist_name, release_date, song_titles in albums:
        artist_id = _get_artist_id(cursor, artist_name)
        genre_id = _get_genre_id(cursor, genre_name)

        # Check duplicate album for this artist
        cursor.execute(
            "SELECT album_id FROM albums WHERE title = %s AND artist_id = %s",
            (album_title, artist_id)
        )
        if cursor.fetchone():
            rejected.add((album_title, artist_name))
            continue

        # Enforce that none of this artist's songs re-use an existing title
        conflict = False
        for song_title in song_titles:
            cursor.execute(
                "SELECT 1 FROM songs WHERE title = %s AND artist_id = %s",
                (song_title, artist_id)
            )
            if cursor.fetchone():
                conflict = True
                break

        if conflict:
            rejected.add((album_title, artist_name))
            continue

        # Insert album
        cursor.execute(
            """
            INSERT INTO albums (title, artist_id, release_date, genre_id)
            VALUES (%s, %s, %s, %s)
            """,
            (album_title, artist_id, release_date, genre_id)
        )
        album_id = cursor.lastrowid

        # Insert songs belonging to this album
        for song_title in song_titles:
            cursor.execute(
                """
                INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
                VALUES (%s, %s, %s, 0, %s)
                """,
                (song_title, artist_id, album_id, release_date)
            )
            song_id = cursor.lastrowid

            # Album's songs are all in the album's genre
            cursor.execute(
                "INSERT INTO song_genres (song_id, genre_id) VALUES (%s, %s)",
                (song_id, genre_id)
            )

    mydb.commit()
    cursor.close()
    return rejected


def get_top_song_genres(mydb, n: int) -> List[Tuple[str, int]]:
    """
    Get n genres that are most represented in terms of number of songs in that genre.
    Songs include singles as well as songs in albums. 
    
    Args:
        mydb: database connection
        n: number of genres

    Returns:
        List[Tuple[str,int]]: list of tuples (genre,number_of_songs), from most represented to
        least represented genre. If number of genres is less than n, returns all.
        Ties broken by alphabetical order of genre names.
    """
    cursor = mydb.cursor()
    cursor.execute(
        """
        SELECT g.name, COUNT(DISTINCT sg.song_id) AS num_songs
        FROM song_genres sg
        JOIN genres g ON sg.genre_id = g.genre_id
        GROUP BY g.genre_id, g.name
        ORDER BY num_songs DESC, g.name ASC
        LIMIT %s
        """,
        (n,)
    )
    rows = cursor.fetchall()
    cursor.close()
    return [(name, cnt) for (name, cnt) in rows]


def get_album_and_single_artists(mydb) -> Set[str]:
    """
    Get artists who have released albums as well as singles.

    Args:
        mydb; database connection

    Returns:
        Set[str]: set of artist names
    """
    cursor = mydb.cursor()
    # Artists with at least one single and at least one non-single song
    cursor.execute(
        """
        SELECT a.name
        FROM artists a
        WHERE EXISTS (
            SELECT 1 FROM songs s
            WHERE s.artist_id = a.artist_id AND s.is_single = 1
        )
        AND EXISTS (
            SELECT 1 FROM songs s
            WHERE s.artist_id = a.artist_id AND s.is_single = 0
        )
        """
    )
    rows = cursor.fetchall()
    cursor.close()
    return {name for (name,) in rows}


def load_users(mydb, users: List[str]) -> Set[str]:
    """
    Add users to the database. 

    Args:
        mydb: database connection
        users: list of usernames

    Returns:
        Set[str]: set of all usernames that were not added (rejected) because 
        they are duplicates of existing users OR duplicates within the input list.
        Set is empty if there are no rejects.
    """
    cursor = mydb.cursor()
    rejected: Set[str] = set()
    seen_this_call: Set[str] = set()

    for username in users:
        # Duplicate within the same call
        if username in seen_this_call:
            rejected.add(username)
            continue
        seen_this_call.add(username)

        # Duplicate in DB
        cursor.execute(
            "SELECT username FROM users WHERE username = %s",
            (username,)
        )
        if cursor.fetchone():
            rejected.add(username)
            continue

        cursor.execute(
            "INSERT INTO users (username) VALUES (%s)",
            (username,)
        )

    mydb.commit()
    cursor.close()
    return rejected


def load_song_ratings(
    mydb, song_ratings: List[Tuple[str, Tuple[str, str], int, str]]
) -> Set[Tuple[str, str, str]]:
    """
    Load ratings for songs, which are either singles or songs in albums. 

    Args:
        mydb: database connection
        song_ratings: list of rating tuples of the form:
            (rater, (artist, song), rating, date)
        
        The rater is a username, the (artist,song) tuple refers to the uniquely identifiable song to be rated.

    Returns:
        Set[Tuple[str,str,str]]: set of (username,artist,song) tuples that are rejected, for any of the following
        reasons:
        (a) username (rater) is not in the database, or
        (b) username is in database but (artist,song) combination is not in the database, or
        (c) username has already rated (artist,song) combination, or
        (d) everything else is legit, but rating is not in range 1..5
        
        An empty set is returned if there are no rejects.  
    """
    cursor = mydb.cursor()
    rejected: Set[Tuple[str, str, str]] = set()

    for username, (artist_name, song_title), rating, rating_date in song_ratings:
        key = (username, artist_name, song_title)

        # (a) user must exist
        cursor.execute(
            "SELECT username FROM users WHERE username = %s",
            (username,)
        )
        user_row = cursor.fetchone()
        if not user_row:
            rejected.add(key)
            continue

        # (b) (artist, song) must exist
        cursor.execute(
            """
            SELECT s.song_id
            FROM songs s
            JOIN artists a ON s.artist_id = a.artist_id
            WHERE a.name = %s AND s.title = %s
            """,
            (artist_name, song_title)
        )
        song_row = cursor.fetchone()
        if not song_row:
            rejected.add(key)
            continue

        song_id = song_row[0]

        # (d) rating must be 1..5
        if rating < 1 or rating > 5:
            rejected.add(key)
            continue

        # (c) user must not have already rated this song
        cursor.execute(
            "SELECT 1 FROM ratings WHERE username = %s AND song_id = %s",
            (username, song_id)
        )
        if cursor.fetchone():
            rejected.add(key)
            continue

        # Insert rating
        cursor.execute(
            """
            INSERT INTO ratings (username, song_id, rating, rating_date)
            VALUES (%s, %s, %s, %s)
            """,
            (username, song_id, rating, rating_date)
        )

    mydb.commit()
    cursor.close()
    return rejected


def get_most_rated_songs(
    mydb, year_range: Tuple[int, int], n: int
) -> List[Tuple[str, str, int]]:
    """
    Get the top n most rated songs in the given year range (both inclusive), 
    ranked from most rated to least rated. 
    "Most rated" refers to number of ratings, not actual rating scores. 
    Ties are broken in alphabetical order of song title. If the number of rated songs is less
    than n, all rated songs are returned.
    
    Args:
        mydb: database connection
        year_range: range of years, e.g. (2018-2021), during which ratings were given
        n: number of most rated songs

    Returns:
        List[Tuple[str,str,int]: list of (song title, artist name, number of ratings for song)   
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
        (start_year, end_year, n)
    )
    rows = cursor.fetchall()
    cursor.close()
    return [(title, artist, num) for (title, artist, num) in rows]


def get_most_engaged_users(
    mydb, year_range: Tuple[int, int], n: int
) -> List[Tuple[str, int]]:
    """
    Get the top n most engaged users, in terms of number of songs they have rated.
    Break ties by alphabetical order of usernames.

    Args:
        mydb: database connection
        year_range: range of years, e.g. (2018-2021), during which ratings were given
        n: number of users

    Returns:
        List[Tuple[str, int]]: list of (username,number_of_songs_rated) tuples
    """
    start_year, end_year = year_range
    cursor = mydb.cursor()
    cursor.execute(
        """
        SELECT r.username, COUNT(*) AS num_rated
        FROM ratings r
        WHERE YEAR(r.rating_date) BETWEEN %s AND %s
        GROUP BY r.username
        ORDER BY num_rated DESC, r.username ASC
        LIMIT %s
        """,
        (start_year, end_year, n)
    )
    rows = cursor.fetchall()
    cursor.close()
    return [(username, num) for (username, num) in rows]


def main():
    # Not used by the autograder; you can leave this empty or use it for your own local testing.
    pass


if __name__ == "__main__":
    main()
