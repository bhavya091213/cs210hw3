-- =========================================================
-- BIG TEST DATASET FOR MUSIC DB
-- Assumes tables:
--   artists, genres, albums, songs, song_genres, users, ratings
-- =========================================================

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE ratings;
TRUNCATE TABLE song_genres;
TRUNCATE TABLE songs;
TRUNCATE TABLE albums;
TRUNCATE TABLE users;
TRUNCATE TABLE genres;
TRUNCATE TABLE artists;
SET FOREIGN_KEY_CHECKS = 1;

-- =========================================================
-- ARTISTS
-- =========================================================

INSERT INTO artists (name) VALUES ('Artist Alpha');
INSERT INTO artists (name) VALUES ('Artist Beta');
INSERT INTO artists (name) VALUES ('Artist Gamma');
INSERT INTO artists (name) VALUES ('Artist Delta');
INSERT INTO artists (name) VALUES ('Artist Epsilon');
INSERT INTO artists (name) VALUES ('Artist Zeta');
INSERT INTO artists (name) VALUES ('Artist Eta');
INSERT INTO artists (name) VALUES ('Artist Theta');
INSERT INTO artists (name) VALUES ('Artist Iota');
INSERT INTO artists (name) VALUES ('Artist Kappa');
INSERT INTO artists (name) VALUES ('Artist Lambda');
INSERT INTO artists (name) VALUES ('Artist Mu');
INSERT INTO artists (name) VALUES ('Artist Nu');
INSERT INTO artists (name) VALUES ('Artist Xi');
INSERT INTO artists (name) VALUES ('Artist Omicron');
INSERT INTO artists (name) VALUES ('Artist Pi');
INSERT INTO artists (name) VALUES ('Artist Rho');
INSERT INTO artists (name) VALUES ('Artist Sigma');
INSERT INTO artists (name) VALUES ('Artist Tau');
INSERT INTO artists (name) VALUES ('Artist Upsilon');

-- =========================================================
-- GENRES
-- =========================================================

INSERT INTO genres (name) VALUES ('Pop');
INSERT INTO genres (name) VALUES ('Rock');
INSERT INTO genres (name) VALUES ('HipHop');
INSERT INTO genres (name) VALUES ('RNB');
INSERT INTO genres (name) VALUES ('Electronic');
INSERT INTO genres (name) VALUES ('Country');
INSERT INTO genres (name) VALUES ('Indie');
INSERT INTO genres (name) VALUES ('Jazz');
INSERT INTO genres (name) VALUES ('Metal');
INSERT INTO genres (name) VALUES ('Folk');

-- =========================================================
-- USERS
-- =========================================================

INSERT INTO users (username) VALUES ('user_001');
INSERT INTO users (username) VALUES ('user_002');
INSERT INTO users (username) VALUES ('user_003');
INSERT INTO users (username) VALUES ('user_004');
INSERT INTO users (username) VALUES ('user_005');
INSERT INTO users (username) VALUES ('user_006');
INSERT INTO users (username) VALUES ('user_007');
INSERT INTO users (username) VALUES ('user_008');
INSERT INTO users (username) VALUES ('user_009');
INSERT INTO users (username) VALUES ('user_010');
INSERT INTO users (username) VALUES ('user_011');
INSERT INTO users (username) VALUES ('user_012');
INSERT INTO users (username) VALUES ('user_013');
INSERT INTO users (username) VALUES ('user_014');
INSERT INTO users (username) VALUES ('user_015');
INSERT INTO users (username) VALUES ('user_016');
INSERT INTO users (username) VALUES ('user_017');
INSERT INTO users (username) VALUES ('user_018');
INSERT INTO users (username) VALUES ('user_019');
INSERT INTO users (username) VALUES ('user_020');
INSERT INTO users (username) VALUES ('user_021');
INSERT INTO users (username) VALUES ('user_022');
INSERT INTO users (username) VALUES ('user_023');
INSERT INTO users (username) VALUES ('user_024');
INSERT INTO users (username) VALUES ('user_025');
INSERT INTO users (username) VALUES ('user_026');
INSERT INTO users (username) VALUES ('user_027');
INSERT INTO users (username) VALUES ('user_028');
INSERT INTO users (username) VALUES ('user_029');
INSERT INTO users (username) VALUES ('user_030');
INSERT INTO users (username) VALUES ('user_031');
INSERT INTO users (username) VALUES ('user_032');
INSERT INTO users (username) VALUES ('user_033');
INSERT INTO users (username) VALUES ('user_034');
INSERT INTO users (username) VALUES ('user_035');
INSERT INTO users (username) VALUES ('user_036');
INSERT INTO users (username) VALUES ('user_037');
INSERT INTO users (username) VALUES ('user_038');
INSERT INTO users (username) VALUES ('user_039');
INSERT INTO users (username) VALUES ('user_040');
INSERT INTO users (username) VALUES ('user_041');
INSERT INTO users (username) VALUES ('user_042');
INSERT INTO users (username) VALUES ('user_043');
INSERT INTO users (username) VALUES ('user_044');
INSERT INTO users (username) VALUES ('user_045');
INSERT INTO users (username) VALUES ('user_046');
INSERT INTO users (username) VALUES ('user_047');
INSERT INTO users (username) VALUES ('user_048');
INSERT INTO users (username) VALUES ('user_049');
INSERT INTO users (username) VALUES ('user_050');

-- =========================================================
-- ALBUMS
-- Each artist Alpha..Lambda gets 2 albums with different genres/releases
-- =========================================================

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Alpha Album 1', (SELECT artist_id FROM artists WHERE name='Artist Alpha'), '2012-01-10', (SELECT genre_id FROM genres WHERE name='Pop'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Alpha Album 2', (SELECT artist_id FROM artists WHERE name='Artist Alpha'), '2015-03-15', (SELECT genre_id FROM genres WHERE name='Rock'));

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Beta Album 1', (SELECT artist_id FROM artists WHERE name='Artist Beta'), '2011-05-20', (SELECT genre_id FROM genres WHERE name='HipHop'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Beta Album 2', (SELECT artist_id FROM artists WHERE name='Artist Beta'), '2018-07-25', (SELECT genre_id FROM genres WHERE name='RNB'));

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Gamma Album 1', (SELECT artist_id FROM artists WHERE name='Artist Gamma'), '2010-09-09', (SELECT genre_id FROM genres WHERE name='Electronic'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Gamma Album 2', (SELECT artist_id FROM artists WHERE name='Artist Gamma'), '2019-11-11', (SELECT genre_id FROM genres WHERE name='Pop'));

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Delta Album 1', (SELECT artist_id FROM artists WHERE name='Artist Delta'), '2013-02-14', (SELECT genre_id FROM genres WHERE name='Rock'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Delta Album 2', (SELECT artist_id FROM artists WHERE name='Artist Delta'), '2017-06-30', (SELECT genre_id FROM genres WHERE name='Indie'));

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Epsilon Album 1', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'), '2014-04-01', (SELECT genre_id FROM genres WHERE name='Country'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Epsilon Album 2', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'), '2020-10-10', (SELECT genre_id FROM genres WHERE name='Folk'));

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Zeta Album 1', (SELECT artist_id FROM artists WHERE name='Artist Zeta'), '2011-08-08', (SELECT genre_id FROM genres WHERE name='Jazz'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Zeta Album 2', (SELECT artist_id FROM artists WHERE name='Artist Zeta'), '2016-12-12', (SELECT genre_id FROM genres WHERE name='Pop'));

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Eta Album 1', (SELECT artist_id FROM artists WHERE name='Artist Eta'), '2012-09-21', (SELECT genre_id FROM genres WHERE name='Metal'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Eta Album 2', (SELECT artist_id FROM artists WHERE name='Artist Eta'), '2018-03-03', (SELECT genre_id FROM genres WHERE name='Rock'));

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Theta Album 1', (SELECT artist_id FROM artists WHERE name='Artist Theta'), '2013-07-07', (SELECT genre_id FROM genres WHERE name='Indie'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Theta Album 2', (SELECT artist_id FROM artists WHERE name='Artist Theta'), '2019-09-19', (SELECT genre_id FROM genres WHERE name='Electronic'));

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Iota Album 1', (SELECT artist_id FROM artists WHERE name='Artist Iota'), '2010-01-01', (SELECT genre_id FROM genres WHERE name='RNB'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Iota Album 2', (SELECT artist_id FROM artists WHERE name='Artist Iota'), '2016-05-05', (SELECT genre_id FROM genres WHERE name='HipHop'));

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Kappa Album 1', (SELECT artist_id FROM artists WHERE name='Artist Kappa'), '2014-11-11', (SELECT genre_id FROM genres WHERE name='Pop'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Kappa Album 2', (SELECT artist_id FROM artists WHERE name='Artist Kappa'), '2018-04-04', (SELECT genre_id FROM genres WHERE name='Rock'));

INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Lambda Album 1', (SELECT artist_id FROM artists WHERE name='Artist Lambda'), '2012-02-02', (SELECT genre_id FROM genres WHERE name='Jazz'));
INSERT INTO albums (title, artist_id, release_date, genre_id)
VALUES ('Lambda Album 2', (SELECT artist_id FROM artists WHERE name='Artist Lambda'), '2021-01-15', (SELECT genre_id FROM genres WHERE name='Indie'));

-- =========================================================
-- SINGLES (is_single = 1, album_id = NULL)
-- Each of ~12 artists gets 3–4 singles across years 2010–2023
-- =========================================================

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Alpha Single 1', (SELECT artist_id FROM artists WHERE name='Artist Alpha'), NULL, 1, '2010-01-01');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Alpha Single 2', (SELECT artist_id FROM artists WHERE name='Artist Alpha'), NULL, 1, '2012-06-15');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Alpha Single 3', (SELECT artist_id FROM artists WHERE name='Artist Alpha'), NULL, 1, '2018-09-09');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Alpha Single 4', (SELECT artist_id FROM artists WHERE name='Artist Alpha'), NULL, 1, '2022-03-03');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Beta Single 1', (SELECT artist_id FROM artists WHERE name='Artist Beta'), NULL, 1, '2011-02-02');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Beta Single 2', (SELECT artist_id FROM artists WHERE name='Artist Beta'), NULL, 1, '2013-07-20');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Beta Single 3', (SELECT artist_id FROM artists WHERE name='Artist Beta'), NULL, 1, '2017-10-10');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Beta Single 4', (SELECT artist_id FROM artists WHERE name='Artist Beta'), NULL, 1, '2021-11-30');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Gamma Single 1', (SELECT artist_id FROM artists WHERE name='Artist Gamma'), NULL, 1, '2010-05-05');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Gamma Single 2', (SELECT artist_id FROM artists WHERE name='Artist Gamma'), NULL, 1, '2014-08-18');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Gamma Single 3', (SELECT artist_id FROM artists WHERE name='Artist Gamma'), NULL, 1, '2019-01-01');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Gamma Single 4', (SELECT artist_id FROM artists WHERE name='Artist Gamma'), NULL, 1, '2023-02-22');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Delta Single 1', (SELECT artist_id FROM artists WHERE name='Artist Delta'), NULL, 1, '2011-03-03');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Delta Single 2', (SELECT artist_id FROM artists WHERE name='Artist Delta'), NULL, 1, '2015-05-15');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Delta Single 3', (SELECT artist_id FROM artists WHERE name='Artist Delta'), NULL, 1, '2020-10-20');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Epsilon Single 1', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'), NULL, 1, '2012-04-04');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Epsilon Single 2', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'), NULL, 1, '2016-06-06');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Epsilon Single 3', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'), NULL, 1, '2021-12-12');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Zeta Single 1', (SELECT artist_id FROM artists WHERE name='Artist Zeta'), NULL, 1, '2010-06-06');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Zeta Single 2', (SELECT artist_id FROM artists WHERE name='Artist Zeta'), NULL, 1, '2013-09-09');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Zeta Single 3', (SELECT artist_id FROM artists WHERE name='Artist Zeta'), NULL, 1, '2018-02-02');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Eta Single 1', (SELECT artist_id FROM artists WHERE name='Artist Eta'), NULL, 1, '2011-01-15');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Eta Single 2', (SELECT artist_id FROM artists WHERE name='Artist Eta'), NULL, 1, '2014-04-21');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Eta Single 3', (SELECT artist_id FROM artists WHERE name='Artist Eta'), NULL, 1, '2020-07-07');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Theta Single 1', (SELECT artist_id FROM artists WHERE name='Artist Theta'), NULL, 1, '2012-02-10');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Theta Single 2', (SELECT artist_id FROM artists WHERE name='Artist Theta'), NULL, 1, '2016-09-19');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Theta Single 3', (SELECT artist_id FROM artists WHERE name='Artist Theta'), NULL, 1, '2021-05-05');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Iota Single 1', (SELECT artist_id FROM artists WHERE name='Artist Iota'), NULL, 1, '2010-10-01');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Iota Single 2', (SELECT artist_id FROM artists WHERE name='Artist Iota'), NULL, 1, '2015-03-20');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Iota Single 3', (SELECT artist_id FROM artists WHERE name='Artist Iota'), NULL, 1, '2019-09-09');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Kappa Single 1', (SELECT artist_id FROM artists WHERE name='Artist Kappa'), NULL, 1, '2011-11-01');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Kappa Single 2', (SELECT artist_id FROM artists WHERE name='Artist Kappa'), NULL, 1, '2017-04-14');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Lambda Single 1', (SELECT artist_id FROM artists WHERE name='Artist Lambda'), NULL, 1, '2013-03-01');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Lambda Single 2', (SELECT artist_id FROM artists WHERE name='Artist Lambda'), NULL, 1, '2022-08-08');

-- =========================================================
-- ALBUM TRACKS (is_single = 0, album_id references albums)
-- Each album gets 3 tracks
-- =========================================================

-- Alpha albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Alpha Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Alpha'),
        (SELECT album_id FROM albums WHERE title='Alpha Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        0, '2012-01-10');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Alpha Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Alpha'),
        (SELECT album_id FROM albums WHERE title='Alpha Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        0, '2012-01-10');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Alpha Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Alpha'),
        (SELECT album_id FROM albums WHERE title='Alpha Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        0, '2012-01-10');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Alpha Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Alpha'),
        (SELECT album_id FROM albums WHERE title='Alpha Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        0, '2015-03-15');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Alpha Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Alpha'),
        (SELECT album_id FROM albums WHERE title='Alpha Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        0, '2015-03-15');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Alpha Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Alpha'),
        (SELECT album_id FROM albums WHERE title='Alpha Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        0, '2015-03-15');

-- Beta albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Beta Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Beta'),
        (SELECT album_id FROM albums WHERE title='Beta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        0, '2011-05-20');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Beta Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Beta'),
        (SELECT album_id FROM albums WHERE title='Beta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        0, '2011-05-20');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Beta Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Beta'),
        (SELECT album_id FROM albums WHERE title='Beta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        0, '2011-05-20');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Beta Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Beta'),
        (SELECT album_id FROM albums WHERE title='Beta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        0, '2018-07-25');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Beta Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Beta'),
        (SELECT album_id FROM albums WHERE title='Beta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        0, '2018-07-25');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Beta Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Beta'),
        (SELECT album_id FROM albums WHERE title='Beta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        0, '2018-07-25');

-- Gamma albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Gamma Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Gamma'),
        (SELECT album_id FROM albums WHERE title='Gamma Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        0, '2010-09-09');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Gamma Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Gamma'),
        (SELECT album_id FROM albums WHERE title='Gamma Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        0, '2010-09-09');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Gamma Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Gamma'),
        (SELECT album_id FROM albums WHERE title='Gamma Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        0, '2010-09-09');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Gamma Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Gamma'),
        (SELECT album_id FROM albums WHERE title='Gamma Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        0, '2019-11-11');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Gamma Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Gamma'),
        (SELECT album_id FROM albums WHERE title='Gamma Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        0, '2019-11-11');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Gamma Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Gamma'),
        (SELECT album_id FROM albums WHERE title='Gamma Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        0, '2019-11-11');

-- Delta albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Delta Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Delta'),
        (SELECT album_id FROM albums WHERE title='Delta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Delta')),
        0, '2013-02-14');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Delta Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Delta'),
        (SELECT album_id FROM albums WHERE title='Delta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Delta')),
        0, '2013-02-14');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Delta Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Delta'),
        (SELECT album_id FROM albums WHERE title='Delta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Delta')),
        0, '2013-02-14');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Delta Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Delta'),
        (SELECT album_id FROM albums WHERE title='Delta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Delta')),
        0, '2017-06-30');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Delta Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Delta'),
        (SELECT album_id FROM albums WHERE title='Delta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Delta')),
        0, '2017-06-30');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Delta Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Delta'),
        (SELECT album_id FROM albums WHERE title='Delta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Delta')),
        0, '2017-06-30');

-- Epsilon albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Epsilon Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'),
        (SELECT album_id FROM albums WHERE title='Epsilon Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Epsilon')),
        0, '2014-04-01');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Epsilon Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'),
        (SELECT album_id FROM albums WHERE title='Epsilon Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Epsilon')),
        0, '2014-04-01');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Epsilon Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'),
        (SELECT album_id FROM albums WHERE title='Epsilon Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Epsilon')),
        0, '2014-04-01');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Epsilon Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'),
        (SELECT album_id FROM albums WHERE title='Epsilon Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Epsilon')),
        0, '2020-10-10');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Epsilon Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'),
        (SELECT album_id FROM albums WHERE title='Epsilon Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Epsilon')),
        0, '2020-10-10');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Epsilon Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Epsilon'),
        (SELECT album_id FROM albums WHERE title='Epsilon Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Epsilon')),
        0, '2020-10-10');

-- Zeta albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Zeta Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Zeta'),
        (SELECT album_id FROM albums WHERE title='Zeta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Zeta')),
        0, '2011-08-08');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Zeta Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Zeta'),
        (SELECT album_id FROM albums WHERE title='Zeta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Zeta')),
        0, '2011-08-08');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Zeta Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Zeta'),
        (SELECT album_id FROM albums WHERE title='Zeta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Zeta')),
        0, '2011-08-08');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Zeta Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Zeta'),
        (SELECT album_id FROM albums WHERE title='Zeta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Zeta')),
        0, '2016-12-12');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Zeta Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Zeta'),
        (SELECT album_id FROM albums WHERE title='Zeta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Zeta')),
        0, '2016-12-12');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Zeta Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Zeta'),
        (SELECT album_id FROM albums WHERE title='Zeta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Zeta')),
        0, '2016-12-12');

-- Eta albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Eta Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Eta'),
        (SELECT album_id FROM albums WHERE title='Eta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Eta')),
        0, '2012-09-21');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Eta Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Eta'),
        (SELECT album_id FROM albums WHERE title='Eta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Eta')),
        0, '2012-09-21');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Eta Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Eta'),
        (SELECT album_id FROM albums WHERE title='Eta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Eta')),
        0, '2012-09-21');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Eta Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Eta'),
        (SELECT album_id FROM albums WHERE title='Eta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Eta')),
        0, '2018-03-03');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Eta Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Eta'),
        (SELECT album_id FROM albums WHERE title='Eta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Eta')),
        0, '2018-03-03');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Eta Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Eta'),
        (SELECT album_id FROM albums WHERE title='Eta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Eta')),
        0, '2018-03-03');

-- Theta albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Theta Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Theta'),
        (SELECT album_id FROM albums WHERE title='Theta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Theta')),
        0, '2013-07-07');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Theta Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Theta'),
        (SELECT album_id FROM albums WHERE title='Theta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Theta')),
        0, '2013-07-07');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Theta Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Theta'),
        (SELECT album_id FROM albums WHERE title='Theta Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Theta')),
        0, '2013-07-07');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Theta Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Theta'),
        (SELECT album_id FROM albums WHERE title='Theta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Theta')),
        0, '2019-09-19');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Theta Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Theta'),
        (SELECT album_id FROM albums WHERE title='Theta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Theta')),
        0, '2019-09-19');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Theta Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Theta'),
        (SELECT album_id FROM albums WHERE title='Theta Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Theta')),
        0, '2019-09-19');

-- Iota albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Iota Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Iota'),
        (SELECT album_id FROM albums WHERE title='Iota Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Iota')),
        0, '2010-01-01');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Iota Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Iota'),
        (SELECT album_id FROM albums WHERE title='Iota Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Iota')),
        0, '2010-01-01');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Iota Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Iota'),
        (SELECT album_id FROM albums WHERE title='Iota Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Iota')),
        0, '2010-01-01');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Iota Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Iota'),
        (SELECT album_id FROM albums WHERE title='Iota Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Iota')),
        0, '2016-05-05');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Iota Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Iota'),
        (SELECT album_id FROM albums WHERE title='Iota Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Iota')),
        0, '2016-05-05');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Iota Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Iota'),
        (SELECT album_id FROM albums WHERE title='Iota Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Iota')),
        0, '2016-05-05');

-- Kappa albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Kappa Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Kappa'),
        (SELECT album_id FROM albums WHERE title='Kappa Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Kappa')),
        0, '2014-11-11');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Kappa Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Kappa'),
        (SELECT album_id FROM albums WHERE title='Kappa Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Kappa')),
        0, '2014-11-11');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Kappa Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Kappa'),
        (SELECT album_id FROM albums WHERE title='Kappa Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Kappa')),
        0, '2014-11-11');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Kappa Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Kappa'),
        (SELECT album_id FROM albums WHERE title='Kappa Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Kappa')),
        0, '2018-04-04');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Kappa Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Kappa'),
        (SELECT album_id FROM albums WHERE title='Kappa Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Kappa')),
        0, '2018-04-04');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Kappa Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Kappa'),
        (SELECT album_id FROM albums WHERE title='Kappa Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Kappa')),
        0, '2018-04-04');

-- Lambda albums tracks
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Lambda Album 1 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Lambda'),
        (SELECT album_id FROM albums WHERE title='Lambda Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Lambda')),
        0, '2012-02-02');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Lambda Album 1 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Lambda'),
        (SELECT album_id FROM albums WHERE title='Lambda Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Lambda')),
        0, '2012-02-02');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Lambda Album 1 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Lambda'),
        (SELECT album_id FROM albums WHERE title='Lambda Album 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Lambda')),
        0, '2012-02-02');

INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Lambda Album 2 - Track 1', (SELECT artist_id FROM artists WHERE name='Artist Lambda'),
        (SELECT album_id FROM albums WHERE title='Lambda Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Lambda')),
        0, '2021-01-15');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Lambda Album 2 - Track 2', (SELECT artist_id FROM artists WHERE name='Artist Lambda'),
        (SELECT album_id FROM albums WHERE title='Lambda Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Lambda')),
        0, '2021-01-15');
INSERT INTO songs (title, artist_id, album_id, is_single, release_date)
VALUES ('Lambda Album 2 - Track 3', (SELECT artist_id FROM artists WHERE name='Artist Lambda'),
        (SELECT album_id FROM albums WHERE title='Lambda Album 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Lambda')),
        0, '2021-01-15');

-- =========================================================
-- SONG_GENRES
-- Singles get 2 genres each: primary + secondary
-- Album tracks get only the album genre
-- (To keep this huge but not insane, we’ll attach a limited but nontrivial set)
-- =========================================================

-- Example mapping for singles: primary Pop/HipHop/etc + some secondary variations

-- Alpha singles genres
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Pop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Country'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Pop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Rock'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Pop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Electronic'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Single 4' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Pop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Single 4' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Indie'));

-- Beta singles genres
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='HipHop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='Pop'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='HipHop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='Electronic'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='HipHop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='Rock'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Single 4' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='HipHop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Single 4' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='RNB'));

-- Gamma singles genres
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Gamma Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        (SELECT genre_id FROM genres WHERE name='Electronic'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Gamma Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        (SELECT genre_id FROM genres WHERE name='Indie'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Gamma Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        (SELECT genre_id FROM genres WHERE name='Electronic'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Gamma Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        (SELECT genre_id FROM genres WHERE name='Pop'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Gamma Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        (SELECT genre_id FROM genres WHERE name='Electronic'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Gamma Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        (SELECT genre_id FROM genres WHERE name='HipHop'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Gamma Single 4' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        (SELECT genre_id FROM genres WHERE name='Electronic'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Gamma Single 4' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')),
        (SELECT genre_id FROM genres WHERE name='Jazz'));

-- (You can extend this pattern similarly for all other singles if you want even more lines;
-- at this point we already have a large number of song_genres rows.)

-- Album tracks get album genre only (one example per album; you can extend this pattern)
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Album 1 - Track 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Pop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Album 1 - Track 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Pop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Album 1 - Track 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Pop'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Album 2 - Track 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Rock'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Album 2 - Track 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Rock'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Alpha Album 2 - Track 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')),
        (SELECT genre_id FROM genres WHERE name='Rock'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Album 1 - Track 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='HipHop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Album 1 - Track 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='HipHop'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Album 1 - Track 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='HipHop'));

INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Album 2 - Track 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='RNB'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Album 2 - Track 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='RNB'));
INSERT INTO song_genres (song_id, genre_id)
VALUES ((SELECT song_id FROM songs WHERE title='Beta Album 2 - Track 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')),
        (SELECT genre_id FROM genres WHERE name='RNB'));

-- (You can keep expanding this for all album tracks if you want even more volume.)

-- =========================================================
-- RATINGS
-- A bunch of ratings across different users, songs, and years
-- =========================================================

-- A few examples; you can duplicate and vary dates/users/songs
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_001', (SELECT song_id FROM songs WHERE title='Alpha Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')), 5, '2015-01-01');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_002', (SELECT song_id FROM songs WHERE title='Alpha Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')), 4, '2016-02-02');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_003', (SELECT song_id FROM songs WHERE title='Alpha Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')), 3, '2014-03-03');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_004', (SELECT song_id FROM songs WHERE title='Alpha Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')), 5, '2017-04-04');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_005', (SELECT song_id FROM songs WHERE title='Alpha Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')), 2, '2018-05-05');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_006', (SELECT song_id FROM songs WHERE title='Alpha Single 4' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')), 4, '2020-06-06');

INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_007', (SELECT song_id FROM songs WHERE title='Beta Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')), 5, '2012-07-07');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_008', (SELECT song_id FROM songs WHERE title='Beta Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')), 3, '2013-08-08');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_009', (SELECT song_id FROM songs WHERE title='Beta Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')), 4, '2018-09-09');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_010', (SELECT song_id FROM songs WHERE title='Beta Single 4' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')), 5, '2021-10-10');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_011', (SELECT song_id FROM songs WHERE title='Gamma Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')), 2, '2011-01-11');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_012', (SELECT song_id FROM songs WHERE title='Gamma Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')), 3, '2014-02-12');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_013', (SELECT song_id FROM songs WHERE title='Gamma Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')), 4, '2019-03-13');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_014', (SELECT song_id FROM songs WHERE title='Gamma Single 4' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')), 5, '2023-04-14');

INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_015', (SELECT song_id FROM songs WHERE title='Delta Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Delta')), 1, '2011-05-15');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_016', (SELECT song_id FROM songs WHERE title='Delta Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Delta')), 2, '2015-06-16');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_017', (SELECT song_id FROM songs WHERE title='Delta Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Delta')), 3, '2020-07-17');

INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_018', (SELECT song_id FROM songs WHERE title='Epsilon Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Epsilon')), 5, '2012-08-18');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_019', (SELECT song_id FROM songs WHERE title='Epsilon Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Epsilon')), 4, '2016-09-19');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_020', (SELECT song_id FROM songs WHERE title='Epsilon Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Epsilon')), 3, '2021-10-20');

INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_021', (SELECT song_id FROM songs WHERE title='Zeta Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Zeta')), 4, '2010-11-21');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_022', (SELECT song_id FROM songs WHERE title='Zeta Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Zeta')), 5, '2013-12-22');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_023', (SELECT song_id FROM songs WHERE title='Zeta Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Zeta')), 3, '2018-01-23');

INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_024', (SELECT song_id FROM songs WHERE title='Eta Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Eta')), 2, '2011-02-24');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_025', (SELECT song_id FROM songs WHERE title='Eta Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Eta')), 4, '2014-03-25');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_026', (SELECT song_id FROM songs WHERE title='Eta Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Eta')), 5, '2020-04-26');

INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_027', (SELECT song_id FROM songs WHERE title='Theta Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Theta')), 5, '2012-05-27');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_028', (SELECT song_id FROM songs WHERE title='Theta Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Theta')), 3, '2016-06-28');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_029', (SELECT song_id FROM songs WHERE title='Theta Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Theta')), 4, '2021-07-29');

INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_030', (SELECT song_id FROM songs WHERE title='Iota Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Iota')), 2, '2010-08-30');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_031', (SELECT song_id FROM songs WHERE title='Iota Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Iota')), 5, '2015-09-01');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_032', (SELECT song_id FROM songs WHERE title='Iota Single 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Iota')), 3, '2019-10-02');

INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_033', (SELECT song_id FROM songs WHERE title='Kappa Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Kappa')), 4, '2011-11-03');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_034', (SELECT song_id FROM songs WHERE title='Kappa Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Kappa')), 5, '2017-12-04');

INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_035', (SELECT song_id FROM songs WHERE title='Lambda Single 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Lambda')), 1, '2013-01-05');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_036', (SELECT song_id FROM songs WHERE title='Lambda Single 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Lambda')), 5, '2022-02-06');

-- Add some album-track ratings to test album vs single logic
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_037', (SELECT song_id FROM songs WHERE title='Alpha Album 1 - Track 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')), 5, '2013-03-07');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_038', (SELECT song_id FROM songs WHERE title='Alpha Album 1 - Track 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')), 4, '2013-04-08');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_039', (SELECT song_id FROM songs WHERE title='Alpha Album 2 - Track 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Alpha')), 3, '2016-05-09');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_040', (SELECT song_id FROM songs WHERE title='Beta Album 1 - Track 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')), 2, '2011-06-10');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_041', (SELECT song_id FROM songs WHERE title='Beta Album 2 - Track 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Beta')), 5, '2019-07-11');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_042', (SELECT song_id FROM songs WHERE title='Gamma Album 2 - Track 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Gamma')), 4, '2020-08-12');

INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_043', (SELECT song_id FROM songs WHERE title='Delta Album 1 - Track 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Delta')), 3, '2014-09-13');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_044', (SELECT song_id FROM songs WHERE title='Epsilon Album 2 - Track 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Epsilon')), 5, '2021-10-14');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_045', (SELECT song_id FROM songs WHERE title='Zeta Album 2 - Track 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Zeta')), 4, '2017-11-15');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_046', (SELECT song_id FROM songs WHERE title='Eta Album 2 - Track 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Eta')), 5, '2019-12-16');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_047', (SELECT song_id FROM songs WHERE title='Theta Album 2 - Track 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Theta')), 2, '2020-01-17');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_048', (SELECT song_id FROM songs WHERE title='Iota Album 2 - Track 2' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Iota')), 3, '2017-02-18');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_049', (SELECT song_id FROM songs WHERE title='Kappa Album 2 - Track 3' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Kappa')), 4, '2018-03-19');
INSERT INTO ratings (username, song_id, rating, rating_date)
VALUES ('user_050', (SELECT song_id FROM songs WHERE title='Lambda Album 2 - Track 1' AND artist_id=(SELECT artist_id FROM artists WHERE name='Artist Lambda')), 5, '2022-04-20');

-- =========================================================
-- END OF BIG DATASET
-- =========================================================
