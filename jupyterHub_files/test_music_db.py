# test_music_db.py
from mysql.connector import connect, Error

from music_db import (
    clear_database,
    load_users,
    load_single_songs,
    load_albums,
    load_song_ratings,
    get_most_prolific_individual_artists,
    get_artists_last_single_in_year,
    get_top_song_genres,
    get_album_and_single_artists,
    get_most_rated_songs,
    get_most_engaged_users,
)

# Adjust these if needed
DB_NAME = "bbp53_music_db"
SOCKET_PATH = "/run/mysqld/mysqld.sock"   # if in doubt, run: SHOW VARIABLES LIKE 'socket';


def get_connection():
    """
    Connect to MariaDB the same way as the course notebooks:
    via UNIX socket, using your Linux username as the DB user.
    """
    try:
        mydb = connect(
            unix_socket=SOCKET_PATH,
            database=DB_NAME,
        )
        return mydb
    except Error as e:
        print("Connection error:", e)
        raise


def main():
    mydb = get_connection()
    print(f"Connected to database '{DB_NAME}' via socket '{SOCKET_PATH}'")

    # WARNING: this wipes all data in your tables.
    print("\n=== clear_database ===")
    clear_database(mydb)
    print("Database cleared.\n")

    # ---------- load_users ----------
    print("=== load_users ===")
    users = ["u1", "u2", "u1", "u3", "u4"]
    rejected_users = load_users(mydb, users)
    print("Input users:   ", users)
    print("Rejected users:", rejected_users)

    # ---------- load_single_songs ----------
    print("\n=== load_single_songs ===")
    single_songs = [
        ("Single A1", ("Pop",), "Artist Alpha", "2015-01-01"),
        ("Single A2", ("Rock", "Pop"), "Artist Alpha", "2016-02-02"),
        ("Single B1", ("HipHop",), "Artist Beta", "2017-03-03"),
        # duplicate title for same artist (should be rejected)
        ("Single A1", ("Pop",), "Artist Alpha", "2020-03-03"),
        # no genres case (should be rejected by our code)
        ("NoGenreSong", tuple(), "Artist Gamma", "2018-01-01"),
    ]
    rejected_singles = load_single_songs(mydb, single_songs)
    print("Rejected singles (title, artist):", rejected_singles)

    # ---------- load_albums ----------
    print("\n=== load_albums ===")
    albums = [
        ("Alpha Album X", "Pop", "Artist Alpha", "2018-04-04",
         ["AX1", "AX2", "AX3"]),
        ("Beta Album Y", "HipHop", "Artist Beta", "2019-05-05",
         ["BY1", "BY2"]),
        # Duplicate album title for same artist (should be rejected)
        ("Alpha Album X", "Pop", "Artist Alpha", "2020-06-06",
         ["AX4"]),
        # Conflict: reuse an existing song title for same artist (e.g., Single A2)
        ("Conflict Album", "Rock", "Artist Alpha", "2021-07-07",
         ["Single A2", "New Track"]),
    ]
    rejected_albums = load_albums(mydb, albums)
    print("Rejected albums (title, artist):", rejected_albums)

    # ---------- load_song_ratings ----------
    print("\n=== load_song_ratings ===")
    song_ratings = [
        # valid rating
        ("u1", ("Artist Alpha", "Single A1"), 5, "2020-01-01"),
        # duplicate rating by same user for same song
        ("u1", ("Artist Alpha", "Single A1"), 3, "2020-02-02"),
        # valid rating another song
        ("u2", ("Artist Alpha", "Single A2"), 4, "2020-03-03"),
        # user does not exist
        ("baduser", ("Artist Alpha", "Single A2"), 4, "2020-04-04"),
        # song does not exist
        ("u2", ("NoSuchArtist", "NoSuchSong"), 5, "2020-05-05"),
        # invalid rating value
        ("u3", ("Artist Beta", "Single B1"), 7, "2020-06-06"),
    ]
    rejected_ratings = load_song_ratings(mydb, song_ratings)
    print("Rejected ratings (user, artist, song):", rejected_ratings)

    # ---------- query functions ----------
    print("\n=== QUERY FUNCTIONS ===")

    print("\nget_most_prolific_individual_artists(5, (2010, 2025))")
    print(get_most_prolific_individual_artists(mydb, 5, (2010, 2025)))

    print("\nget_artists_last_single_in_year(2015)")
    print(get_artists_last_single_in_year(mydb, 2015))

    print("\nget_top_song_genres(5)")
    print(get_top_song_genres(mydb, 5))

    print("\nget_album_and_single_artists()")
    print(get_album_and_single_artists(mydb))

    print("\nget_most_rated_songs((2010, 2025), 10)")
    print(get_most_rated_songs(mydb, (2010, 2025), 10))

    print("\nget_most_engaged_users((2010, 2025), 10)")
    print(get_most_engaged_users(mydb, (2010, 2025), 10))

    mydb.close()
    print("\nDone.")


if __name__ == "__main__":
    main()
