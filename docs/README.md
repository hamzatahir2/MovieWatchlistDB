# 🎬 Movie Watchlist System — Database Project

**Course:** Database Systems | **Program:** BSCS  
**Lab Instructor:** Ms. Ambreen Akmal | **Semester:** Spring 2026  
**University:** The University of Lahore — Department of CS & IT

---

## 📖 Project Overview

The **Movie Watchlist System** is a database-driven application that manages cinema-style movie tracking for users. It simulates a real-world platform where registered users can browse movies, add them to personal watchlists, rate and review watched films, and track their viewing history. The system also supports administrative features such as managing movie records, genres, cinemas, and showtimes.

> Inspired by platforms like **IMDb**, **Letterboxd**, and multiplex cinema portals.

---

## 🗄️ Database Design

- Designed following **Third Normal Form (3NF)**
- All tables use **surrogate primary keys** (`AUTO_INCREMENT`)
- Enforces **foreign-key constraints** throughout
- Supports **cascading deletes** on dependent tables

### Tables

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

---

## ✅ Features List

| # | Feature | Description |
|---|---|---|
| 1 | User Registration & Login | Register new users and verify login credentials |
| 2 | Add Movie to Watchlist | Add movies with status: Want to Watch / Watching / Watched |
| 3 | Update Watchlist Status | Change the watch status of a movie in the watchlist |
| 4 | Remove Movie from Watchlist | Delete a specific entry from the watchlist |
| 5 | Rate & Review a Movie | Submit ratings (1–10) and text reviews; no duplicates allowed |
| 6 | Search & Filter Movies | Search by title, genre, language, or director |
| 7 | Browse Showtimes by City | View upcoming showtimes with cinema, date, time, and price |
| 8 | Book Cinema Seats | Book seats using a transaction with availability validation |
| 9 | View Watching History | View complete watched-movie log with dates |
| 10 | Admin: Manage Movies & Genres | Add, update, delete movies and assign genres; DCL access control |

---

## 📁 Repository Structure

```
MovieWatchlistDB/
├── README.md                    ← Project overview (this file)
├── DOCUMENTATION.md             ← Full ER diagram, relationships & feature details
├── MovieWatchlistDB.sql         ← Complete SQL: DDL + Sample Data + All 10 Features
└── docs/
    └── MovieWatchlist_DB_Documentation.pdf
```

---

## 🚀 How to Run

1. Open **MySQL Workbench** or any MySQL client.
2. Open `MovieWatchlistDB.sql` and run it fully — it includes everything in order:
   - Database creation
   - All table definitions (DDL)
   - Sample data (DML)
   - All 10 feature queries

---

## 🔗 Relationships Summary

- **Users ↔ Watchlist:** One-to-Many
- **Users ↔ Reviews:** One-to-Many
- **Users ↔ Bookings:** One-to-Many
- **Movies ↔ Genres:** Many-to-Many (via `Movie_Genres` bridge table)
- **Movies ↔ Showtimes:** One-to-Many
- **Cinemas ↔ Showtimes:** One-to-Many
- **Showtimes ↔ Bookings:** One-to-Many

---

*Submitted via Slate Portal | Spring 2026 | Database Systems — BSCS | University of Lahore*
