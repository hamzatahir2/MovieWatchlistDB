# 📄 Movie Watchlist System — Full Documentation

**Course:** Database Systems | **Program:** BSCS  
**Lab Instructor:** Ms. Ambreen Akmal | **Semester:** Spring 2026  
**University:** The University of Lahore — Department of CS & IT  
**Maximum Marks:** 10 | **Submission:** Slate Portal

---

## 1. Project Scenario Description

The Movie Watchlist System is a database-driven application designed to manage cinema-style movie tracking for users. It simulates a real-world platform where registered users can browse movies, add them to personal watchlists, rate and review watched films, and track their viewing history. The system also supports administrative features such as managing movie records, genres, cinemas, and showtimes.

This scenario mirrors platforms like **IMDb**, **Letterboxd**, or a multiplex cinema portal, making it relevant and feature-rich for a complete DBMS implementation.

---

## 2. Database Design Overview

The database is designed following **Third Normal Form (3NF)** to eliminate redundancy and ensure referential integrity. All tables use surrogate primary keys (`AUTO_INCREMENT` integers) and enforce foreign-key constraints. The schema covers users, movies, genres, cinemas, showtimes, watchlists, reviews, and bookings.

---

## 3. Tables and Relationships

| Table | Primary Key | Foreign Keys | Description |
|---|---|---|---|
| Users | user_id | — | Registered platform users |
| Movies | movie_id | — | Movie catalogue |
| Genres | genre_id | — | Movie genre categories |
| Movie_Genres | — | movie_id, genre_id | Many-to-many: movies ↔ genres |
| Cinemas | cinema_id | — | Cinema/theatre info |
| Showtimes | showtime_id | movie_id, cinema_id | Screening schedules |
| Watchlist | watchlist_id | user_id, movie_id | User's personal watchlist |
| Reviews | review_id | user_id, movie_id | Ratings and reviews |
| Bookings | booking_id | user_id, showtime_id | Seat bookings |
| ViewHistory | history_id | user_id, movie_id | Watched movie log |

### Relationship Summary

- **Users ↔ Watchlist:** One-to-Many (1 user → many watchlist entries)
- **Users ↔ Reviews:** One-to-Many (1 user → many reviews)
- **Users ↔ Bookings:** One-to-Many (1 user → many bookings)
- **Movies ↔ Genres:** Many-to-Many (via `Movie_Genres` bridge table)
- **Movies ↔ Showtimes:** One-to-Many (1 movie → many showtimes)
- **Cinemas ↔ Showtimes:** One-to-Many (1 cinema → many showtimes)
- **Showtimes ↔ Bookings:** One-to-Many (1 showtime → many bookings)

---

## 4. ER Diagram (Entity-Relationship Overview)

```
Users(user_id, username, email, password, role, created_at)
 ├── 1:M ── Watchlist(watchlist_id, user_id, movie_id, status, added_on)
 ├── 1:M ── Reviews(review_id, user_id, movie_id, rating, comment, reviewed_at)
 ├── 1:M ── Bookings(booking_id, user_id, showtime_id, seats, booked_at)
 └── 1:M ── ViewHistory(history_id, user_id, movie_id, watched_on)

Movies(movie_id, title, release_year, duration_min, language, director, synopsis)
 ├── M:M ── Genres via Movie_Genres(movie_id, genre_id)
 └── 1:M ── Showtimes(showtime_id, movie_id, cinema_id, show_date, show_time, price, seats_left)

Cinemas(cinema_id, name, city, address, total_seats)
 └── 1:M ── Showtimes

Genres(genre_id, genre_name)
```

---

## 5. Feature Descriptions

### Feature 1 — User Registration & Login
Allows new users to register with a unique username and email. Passwords are stored securely. Existing users can log in by verifying credentials.

### Feature 2 — Add Movie to Watchlist
Authenticated users can add any movie from the catalogue to their personal watchlist with a status of `Want to Watch`, `Watching`, or `Watched`.

### Feature 3 — Update Watchlist Status
Users can update the watch status of a movie in their watchlist (e.g., move from `Want to Watch` to `Watched`).

### Feature 4 — Remove Movie from Watchlist
Users can delete a specific entry from their watchlist by providing the watchlist ID.

### Feature 5 — Rate & Review a Movie
Users who have watched a movie can submit a numeric rating (1–10) and a text review. Duplicate reviews by the same user for the same movie are prevented via a `UNIQUE` constraint.

### Feature 6 — Search & Filter Movies
Users can search movies by title keyword, filter by genre, language, release year, or director. Results are sorted by rating or release year.

### Feature 7 — Browse Showtimes by City
Users can view all upcoming showtimes for a specific city, including cinema name, show date/time, and ticket price.

### Feature 8 — Book Cinema Seats
Users can book a specified number of seats for a selected showtime. The system validates seat availability before confirming a booking using a `TRANSACTION`.

### Feature 9 — View Watching History
Users can view their complete watched-movie log with dates, enabling personal analytics on viewing habits.

### Feature 10 — Admin: Manage Movies & Genres
Administrators can add new movies, assign genres via the `Movie_Genres` bridge table, update movie details, and delete movies (with cascading deletes on related tables). Includes DCL statements for access control.

---

## 6. SQL Query Types Used

| SQL Category | Statements Used |
|---|---|
| DDL | `CREATE DATABASE`, `CREATE TABLE` |
| DML | `INSERT`, `UPDATE`, `DELETE`, `SELECT` |
| TCL | `START TRANSACTION`, `COMMIT` |
| DCL | `GRANT`, `REVOKE` |
| Clauses | `JOIN`, `WHERE`, `GROUP BY`, `ORDER BY`, `LIKE`, `DISTINCT` |
| Constraints | `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, `NOT NULL`, `DEFAULT` |

---

*Submitted via Slate Portal | Spring 2026 | Database Systems — BSCS | University of Lahore*
