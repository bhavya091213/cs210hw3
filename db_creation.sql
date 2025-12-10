SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS song_genres;
DROP TABLE IF EXISTS songs;
DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS artists;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE artists (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    name      VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    name     VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE albums (
    album_id     INT AUTO_INCREMENT PRIMARY KEY,
    title        VARCHAR(200) NOT NULL,
    artist_id    INT NOT NULL,
    release_date DATE NOT NULL,
    genre_id     INT NOT NULL,
    UNIQUE KEY unique_album (title, artist_id),
    CONSTRAINT fk_album_artist
        FOREIGN KEY (artist_id) REFERENCES artists(artist_id),
    CONSTRAINT fk_album_genre
        FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
) ENGINE=InnoDB;

CREATE TABLE songs (
    song_id      INT AUTO_INCREMENT PRIMARY KEY,
    title        VARCHAR(200) NOT NULL,
    artist_id    INT NOT NULL,
    album_id     INT NULL,
    is_single    TINYINT(1) NOT NULL,
    release_date DATE NOT NULL,
    UNIQUE KEY unique_song (title, artist_id),
    CONSTRAINT fk_song_artist
        FOREIGN KEY (artist_id) REFERENCES artists(artist_id),
    CONSTRAINT fk_song_album
        FOREIGN KEY (album_id) REFERENCES albums(album_id)
) ENGINE=InnoDB;

CREATE TABLE song_genres (
    song_id  INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (song_id, genre_id),
    CONSTRAINT fk_song_genres_song
        FOREIGN KEY (song_id) REFERENCES songs(song_id),
    CONSTRAINT fk_song_genres_genre
        FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
) ENGINE=InnoDB;

CREATE TABLE users (
    username VARCHAR(50) NOT NULL,
    PRIMARY KEY (username)
) ENGINE=InnoDB;

CREATE TABLE ratings (
    username    VARCHAR(50) NOT NULL,
    song_id     INT NOT NULL,
    rating      TINYINT NOT NULL,
    rating_date DATE NOT NULL,
    PRIMARY KEY (username, song_id),
    CONSTRAINT fk_ratings_user
        FOREIGN KEY (username) REFERENCES users(username),
    CONSTRAINT fk_ratings_song
        FOREIGN KEY (song_id) REFERENCES songs(song_id)
) ENGINE=InnoDB;
