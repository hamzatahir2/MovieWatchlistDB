-- ================================================================
--  Movie Watchlist System — Complete SQL File
--  Course : Database Systems | BSCS | Spring 2026
--  Instructor : Ms. Ambreen Akmal
--  University : The University of Lahore — Department of CS & IT
--  Submission : Slate Portal
-- ================================================================
-- ORDER OF EXECUTION:
--   Section 1 → DDL  (Create Database & Tables)
--   Section 2 → DML  (Sample Data)
--   Section 3 → Features 1–10 (Queries)
-- ================================================================


-- ================================================================
-- SECTION 1: DDL — CREATE DATABASE & TABLES
-- ================================================================

CREATE DATABASE IF NOT EXISTS MovieWatchlistDB;
USE MovieWatchlistDB;

-- Users
CREATE TABLE Users (
    user_id    INT AUTO_INCREMENT PRIMARY KEY,
    username   VARCHAR(50)  NOT NULL UNIQUE,
    email      VARCHAR(100) NOT NULL UNIQUE,
    password   VARCHAR(255) NOT NULL,
    role       ENUM('user','admin') DEFAULT 'user',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Movies
CREATE TABLE Movies (
    movie_id     INT AUTO_INCREMENT PRIMARY KEY,
    title        VARCHAR(200) NOT NULL,
    release_year YEAR         NOT NULL,
    duration_min INT,
    language     VARCHAR(50),
    director     VARCHAR(100),
    synopsis     TEXT
);

-- Genres
CREATE TABLE Genres (
    genre_id   INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL UNIQUE
);

-- Movie_Genres (Many-to-Many bridge table)
CREATE TABLE Movie_Genres (
    movie_id INT NOT NULL,
    genre_id INT NOT NULL,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id) ON DELETE CASCADE
);

-- Cinemas
CREATE TABLE Cinemas (
    cinema_id   INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    city        VARCHAR(100) NOT NULL,
    address     TEXT,
    total_seats INT DEFAULT 200
);

-- Showtimes
CREATE TABLE Showtimes (
    showtime_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id    INT          NOT NULL,
    cinema_id   INT          NOT NULL,
    show_date   DATE         NOT NULL,
    show_time   TIME         NOT NULL,
    price       DECIMAL(8,2) NOT NULL,
    seats_left  INT          NOT NULL,
    FOREIGN KEY (movie_id)  REFERENCES Movies(movie_id)   ON DELETE CASCADE,
    FOREIGN KEY (cinema_id) REFERENCES Cinemas(cinema_id) ON DELETE CASCADE
);

-- Watchlist
CREATE TABLE Watchlist (
    watchlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT NOT NULL,
    movie_id     INT NOT NULL,
    status       ENUM('Want to Watch','Watching','Watched') DEFAULT 'Want to Watch',
    added_on     DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)  REFERENCES Users(user_id)   ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE,
    UNIQUE (user_id, movie_id)
);

-- Reviews
CREATE TABLE Reviews (
    review_id   INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT     NOT NULL,
    movie_id    INT     NOT NULL,
    rating      TINYINT CHECK (rating BETWEEN 1 AND 10),
    comment     TEXT,
    reviewed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)  REFERENCES Users(user_id)   ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE,
    UNIQUE (user_id, movie_id)
);

-- Bookings
CREATE TABLE Bookings (
    booking_id  INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT NOT NULL,
    showtime_id INT NOT NULL,
    seats       INT NOT NULL DEFAULT 1,
    booked_at   DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)     REFERENCES Users(user_id)         ON DELETE CASCADE,
    FOREIGN KEY (showtime_id) REFERENCES Showtimes(showtime_id) ON DELETE CASCADE
);

-- ViewHistory
CREATE TABLE ViewHistory (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT  NOT NULL,
    movie_id   INT  NOT NULL,
    watched_on DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (user_id)  REFERENCES Users(user_id)   ON DELETE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE
);


-- ================================================================
-- SECTION 2: DML — SAMPLE DATA
-- ================================================================

-- Sample Users
INSERT INTO Users (username, email, password, role) VALUES
('ali_raza',   'ali@email.com',   'hashed_pw1', 'user'),
('sara_khan',  'sara@email.com',  'hashed_pw2', 'user'),
('admin_user', 'admin@email.com', 'hashed_pw3', 'admin');

-- Sample Movies
INSERT INTO Movies (title, release_year, duration_min, language, director, synopsis) VALUES
('Interstellar',    2014, 169, 'English', 'Christopher Nolan', 'Space exploration saga'),
('Kal Ho Na Ho',    2003, 186, 'Hindi',   'Nikkhil Advani',    'Romantic drama in New York'),
('The Dark Knight', 2008, 152, 'English', 'Christopher Nolan', 'Batman vs Joker');

-- Sample Genres
INSERT INTO Genres (genre_name) VALUES
('Sci-Fi'), ('Drama'), ('Action'), ('Romance');

-- Movie-Genre assignments
INSERT INTO Movie_Genres (movie_id, genre_id) VALUES
(1,1),(1,2),   -- Interstellar: Sci-Fi, Drama
(2,2),(2,4),   -- Kal Ho Na Ho: Drama, Romance
(3,3),(3,2);   -- The Dark Knight: Action, Drama

-- Sample Cinemas
INSERT INTO Cinemas (name, city, address, total_seats) VALUES
('Cinepax Lahore',  'Lahore',  'MM Alam Road', 300),
('Nueplex Karachi', 'Karachi', 'DHA Phase 6',  250);

-- Sample Showtimes
INSERT INTO Showtimes (movie_id, cinema_id, show_date, show_time, price, seats_left) VALUES
(1, 1, '2026-06-15', '19:00:00', 800.00, 150),
(3, 2, '2026-06-16', '21:30:00', 900.00, 100);


-- ================================================================
-- SECTION 3: FEATURES 1–10
-- ================================================================

-- ----------------------------------------------------------------
-- Feature 1: User Registration & Login
-- ----------------------------------------------------------------

-- Register a new user (INSERT)
INSERT INTO Users (username, email, password)
VALUES ('new_user', 'new@email.com', 'hashed_password');

-- Login: verify credentials (SELECT)
SELECT user_id, username, role
FROM Users
WHERE email = 'ali@email.com' AND password = 'hashed_pw1';


-- ----------------------------------------------------------------
-- Feature 2: Add Movie to Watchlist
-- ----------------------------------------------------------------

-- Add movie to watchlist (INSERT)
INSERT INTO Watchlist (user_id, movie_id, status)
VALUES (1, 1, 'Want to Watch');


-- ----------------------------------------------------------------
-- Feature 3: Update Watchlist Status
-- ----------------------------------------------------------------

-- Update watch status (UPDATE)
UPDATE Watchlist
SET status = 'Watched'
WHERE user_id = 1 AND movie_id = 1;


-- ----------------------------------------------------------------
-- Feature 4: Remove Movie from Watchlist
-- ----------------------------------------------------------------

-- Delete watchlist entry (DELETE)
DELETE FROM Watchlist
WHERE watchlist_id = 5;


-- ----------------------------------------------------------------
-- Feature 5: Rate & Review a Movie
-- ----------------------------------------------------------------

-- Submit a review (INSERT)
-- UNIQUE(user_id, movie_id) prevents duplicate reviews
INSERT INTO Reviews (user_id, movie_id, rating, comment)
VALUES (1, 1, 9, 'Mind-bending masterpiece!');

-- View average rating for a movie (SELECT + Aggregate)
SELECT m.title,
       AVG(r.rating) AS avg_rating,
       COUNT(*)       AS total_reviews
FROM Reviews r
JOIN Movies m ON r.movie_id = m.movie_id
WHERE m.movie_id = 1
GROUP BY m.title;


-- ----------------------------------------------------------------
-- Feature 6: Search & Filter Movies
-- ----------------------------------------------------------------

-- Search by title keyword (LIKE)
SELECT * FROM Movies
WHERE title LIKE '%Dark%';

-- Filter by genre (JOIN)
SELECT DISTINCT m.title, m.release_year, m.director
FROM Movies m
JOIN Movie_Genres mg ON m.movie_id = mg.movie_id
JOIN Genres g        ON mg.genre_id = g.genre_id
WHERE g.genre_name = 'Action'
ORDER BY m.release_year DESC;

-- Filter by language
SELECT * FROM Movies
WHERE language = 'English'
ORDER BY release_year DESC;

-- Filter by director
SELECT * FROM Movies
WHERE director = 'Christopher Nolan'
ORDER BY release_year DESC;


-- ----------------------------------------------------------------
-- Feature 7: Browse Showtimes by City
-- ----------------------------------------------------------------

-- View upcoming showtimes in a city (SELECT + JOIN)
SELECT m.title,
       c.name      AS cinema,
       s.show_date,
       s.show_time,
       s.price,
       s.seats_left
FROM Showtimes s
JOIN Movies  m ON s.movie_id  = m.movie_id
JOIN Cinemas c ON s.cinema_id = c.cinema_id
WHERE c.city = 'Lahore'
  AND s.show_date >= CURRENT_DATE
ORDER BY s.show_date, s.show_time;


-- ----------------------------------------------------------------
-- Feature 8: Book Cinema Seats
-- ----------------------------------------------------------------

-- Book seats using a transaction (INSERT + UPDATE)
START TRANSACTION;

INSERT INTO Bookings (user_id, showtime_id, seats)
VALUES (1, 1, 2);

UPDATE Showtimes
SET seats_left = seats_left - 2
WHERE showtime_id = 1 AND seats_left >= 2;

COMMIT;


-- ----------------------------------------------------------------
-- Feature 9: View Watching History
-- ----------------------------------------------------------------

-- Log a watched movie (INSERT)
INSERT INTO ViewHistory (user_id, movie_id, watched_on)
VALUES (1, 1, CURRENT_DATE);

-- Retrieve history for a user (SELECT + JOIN)
SELECT m.title, m.release_year, vh.watched_on
FROM ViewHistory vh
JOIN Movies m ON vh.movie_id = m.movie_id
WHERE vh.user_id = 1
ORDER BY vh.watched_on DESC;


-- ----------------------------------------------------------------
-- Feature 10: Admin — Manage Movies & Genres
-- ----------------------------------------------------------------

-- Add a new movie (INSERT)
INSERT INTO Movies (title, release_year, duration_min, language, director)
VALUES ('Oppenheimer', 2023, 180, 'English', 'Christopher Nolan');

-- Assign genre to the new movie (INSERT into bridge table)
INSERT INTO Movie_Genres (movie_id, genre_id) VALUES (4, 2);

-- Update movie details (UPDATE)
UPDATE Movies
SET duration_min = 181
WHERE movie_id = 4;

-- Delete a movie — cascades to Watchlist, Reviews, ViewHistory, Showtimes
DELETE FROM Movies
WHERE movie_id = 4;

-- DCL: Grant read-only access to a viewer role
GRANT SELECT ON MovieWatchlistDB.* TO 'viewer'@'localhost';
REVOKE INSERT, UPDATE, DELETE ON MovieWatchlistDB.* FROM 'viewer'@'localhost';

-- ================================================================
-- END OF FILE
-- ================================================================
