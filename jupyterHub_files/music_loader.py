"""
music_loader.py

Helper script to populate the <netid>_music_db database with sample data
for testing the functions in music_db.py.

Run it on the same machine where MySQL/MariaDB is running, e.g.:

    python3 music_loader.py

You can safely modify or extend the sample data if you want to test more cases.
"""

import mysql.connector
import music_db  # this is your hw3 implementation file


# ---------- CONFIG: EDIT THESE FOR YOUR ENVIRONMENT ----------

DB_NAME = "bbp53_music_db"   # e.g. "bbp53_music_db"
DB_USER = "bbp53"  # usually your NetID on the CS server
DB_PASS = ""                  # often empty on course servers; fill in if HW1 gave you a password
DB_HOST = "localhost"


# ---------- SAMPLE DATA LOADER ----------

def load_sample_data(mydb):
    """
    Clears the database and loads a small test dataset:
    - users (with a duplicate to test rejects)
    - single songs (including a duplicate (artist, title) case)
    - albums with tracks (including duplicate album title per artist)
    - ratings (valid + various invalid cases to exercise load_song_ratings)
    """

    print("Clearing database...")
    music_db.clear_database(mydb)

    # 1. Users (with a duplicate to test rejects)
    users = ["u1", "u2", "u3", "u4", "u1"]  # u1 appears twice

    print("\nLoading users...")
    reject_users = music_db.load_users(mydb, users)
    print("Rejected users:", reject_users)
    # Expect: {'u1'}

    # 2. Single songs
    single_songs = [
        # (song_title, (genres...), artist_name, release_date)
        ("Love Story", ("Pop",), "Taylor Swift", "2008-09-12"),
        ("Shake It Off", ("Pop",), "Taylor Swift", "2014-08-18"),
        ("God's Plan", ("HipHop", "Pop"), "Drake", "2018-01-19"),
        ("Hello", ("Pop", "R&B"), "Adele", "2015-10-23"),
        ("Levitating", ("Pop", "Disco"), "Dua Lipa", "2020-10-01"),
    ]

    print("\nLoading single songs...")
    reject_singles = music_db.load_single_songs(mydb, single_songs)
    print("Rejected singles:", reject_singles)
    # Expect: set()

    # Try adding a duplicate single title for same artist to test reject:
    more_singles = [
        ("Love Story", ("Pop",), "Taylor Swift", "2010-01-01"),  # duplicate (artist, title)
    ]
    print("\nLoading duplicate single to check rejection...")
    reject_singles2 = music_db.load_single_songs(mydb, more_singles)
    print("Rejected duplicate singles:", reject_singles2)
    # Expect: {("Love Story", "Taylor Swift")}

    # 3. Albums (with songs)
    albums = [
        # (album_title, genre, artist_name, release_date, [song_titles])
        ("1989", "Pop", "Taylor Swift", "2014-10-27",
         ["Blank Space", "Style"]),
        ("Scorpion", "HipHop", "Drake", "2018-06-29",
         ["Nonstop", "Mob Ties"]),
        ("25", "Pop", "Adele", "2015-11-20",
         ["When We Were Young", "Send My Love"]),
        ("Future Nostalgia", "Pop", "Dua Lipa", "2020-03-27",
         ["Don't Start Now", "Physical"]),
    ]

    print("\nLoading albums...")
    reject_albums = music_db.load_albums(mydb, albums)
    print("Rejected albums:", reject_albums)
    # Expect: set()

    # Try inserting a duplicate album title for same artist to test album reject:
    dup_album = [
        ("1989", "Pop", "Taylor Swift", "2015-01-01", ["New Song"])
    ]
    print("\nLoading duplicate album to check rejection...")
    reject_albums2 = music_db.load_albums(mydb, dup_album)
    print("Rejected duplicate albums:", reject_albums2)
    # Expect: {("1989", "Taylor Swift")}

    # 4. Ratings: mix of good + bad to test rejections
    ratings = [
        # valid ratings
        ("u1", ("Taylor Swift", "Love Story"), 5, "2019-01-01"),
        ("u2", ("Taylor Swift", "Love Story"), 4, "2019-02-01"),
        ("u1", ("Drake", "God's Plan"), 5, "2019-03-01"),
        ("u3", ("Adele", "Hello"), 3, "2020-05-10"),
        ("u4", ("Dua Lipa", "Levitating"), 5, "2021-07-07"),
        ("u1", ("Taylor Swift", "Blank Space"), 4, "2019-11-01"),
        ("u2", ("Taylor Swift", "Blank Space"), 5, "2020-01-01"),
        ("u3", ("Drake", "Nonstop"), 4, "2019-08-01"),

        # invalid: user not in DB
        ("ghost", ("Taylor Swift", "Love Story"), 5, "2019-01-01"),

        # invalid: song not in DB (wrong title)
        ("u1", ("Taylor Swift", "Nonexistent Song"), 5, "2019-01-01"),

        # invalid: duplicate rating (same user + song)
        ("u1", ("Taylor Swift", "Love Story"), 3, "2019-03-01"),

        # invalid: rating out of range
        ("u2", ("Adele", "Hello"), 6, "2020-01-01"),
    ]

    print("\nLoading song ratings...")
    reject_ratings = music_db.load_song_ratings(mydb, ratings)
    print("Rejected ratings:", reject_ratings)
    # Expect tuples for:
    # ("ghost", "Taylor Swift", "Love Story")
    # ("u1", "Taylor Swift", "Nonexistent Song")
    # ("u1", "Taylor Swift", "Love Story")  <-- duplicate
    # ("u2", "Adele", "Hello")              <-- rating 6

    print("\nSample data load complete.\n")


def run_sample_queries(mydb):
    """
    Calls all query functions on the sample data and prints the results.
    Use this to visually verify that your implementations behave as expected.
    """

    print("Most prolific individual artists (2008-2021):")
    print(music_db.get_most_prolific_individual_artists(mydb, 10, (2008, 2021)))
    print()

    print("Artists whose last single was released in 2015:")
    print(music_db.get_artists_last_single_in_year(mydb, 2015))
    print()

    print("Top song genres:")
    print(music_db.get_top_song_genres(mydb, 10))
    print()

    print("Artists with both albums and singles:")
    print(music_db.get_album_and_single_artists(mydb))
    print()

    print("Most rated songs (2019-2021):")
    print(music_db.get_most_rated_songs(mydb, (2019, 2021), 10))
    print()

    print("Most engaged users (2019-2021):")
    print(music_db.get_most_engaged_users(mydb, (2019, 2021), 10))
    print()


# ---------- MAIN ENTRY POINT ----------

def main():
    print(f"Connecting to database '{DB_NAME}' as '{DB_USER}'...")
    mydb = mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASS,
        database=DB_NAME,
    )
    print("Connected.\n")

    # Load sample data
    load_sample_data(mydb)

    # Run query functions and print their outputs
    run_sample_queries(mydb)

    mydb.close()
    print("\nConnection closed.")


if __name__ == "__main__":
    main()
