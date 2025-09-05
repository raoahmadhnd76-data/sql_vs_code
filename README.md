# 🎬 TMDB Movies SQL Analysis

## 📖 Introduction
This project focuses on analyzing a dataset of movies sourced from TMDB (The Movie Database) using **SQL**.  

The goal is to explore, clean, and query the data to uncover trends, insights, and patterns in the movie industry.

---

## 🔍 Background

As part of improving SQL proficiency, I worked with a real-world dataset containing movie-level details such as:

- Title, release date, genres, and languages

- Financial metrics like budget and revenue

- Popularity scores and voting averages

- Metadata like status, and runtime  

The dataset presented opportunities to practice:
- Data cleaning and schema creation

- Writing complex queries (aggregations, window functions, joins)
- Drawing insights from structured data.

TMDB_all_movies dataset link:
https://www.kaggle.com/datasets/alanvourch/tmdb-movies-daily-updates

---

## 🛠️ Tools I Used

- **PostgreSQL** – For creating schemas, importing data, and performing queries.

- **VS Code** – For writing and managing SQL scripts.

- **Git & GitHub** – For version control and project hosting.

- **Excel / CSV Utilities** – For quick dataset checks and formatting.

---

## 📊 The Analysis
I performed multiple layers of analysis, including:
- Creating tables and defining correct data types
- Importing large CSV datasets into PostgreSQL
- Cleaning text-heavy fields (e.g. genres)
- Writing queries to answer business-style questions:
  
    -  **Top-grossing movies and ROI calculation**
        ```sql
        SELECT 
            title,
            revenue
        FROM
            tmdb_all_movies
        ORDER BY
            revenue desc
        LIMIT 
            1000;
        ```
        ```sql
        SELECT
            title,
            revenue,
            budget,
            (revenue - budget) / budget as ROI
        FROM
            tmdb_all_movies
        WHERE
            revenue > 0 and
            budget > 50000
        GROUP BY
            title,
            revenue,
            budget
        ORDER BY
            ROI desc;
        ```
  - **Most popular movies by year**

    ```sql
    SELECT
        title,
        popularity,
        EXTRACT(year FROM release_date) as year,
        Rank() OVER(PARTITION by EXTRACT(year FROM release_date) ORDER BY popularity) as rn
    FROM
        tmdb_all_movies
    WHERE
        popularity > 0 and
        release_date is not null 
    LIMIT 1000;
    ```
  - **Trends in ratings by decade**
    ```sql
    SELECT 
        ((EXTRACT(YEAR FROM release_date)::INT) / 10) * 10 AS decade,
        ROUND(AVG(vote_average)::NUMERIC, 2) AS avg_rating
    FROM 
        TMDB_all_movies
    WHERE 
        release_date IS NOT NULL
    GROUP BY 
        decade
    ORDER BY 
        decade;
    ```
  - **Most prolific languages, genres, and directors**
- ****Practicing advanced SQL features:****
  - Window functions (`ROW_NUMBER`, `RANK`)

  - Grouping and aggregations

  - Filtering and handling null/missing data

---

## 📚 What I Learned
- How to **design SQL schemas** from raw CSV data.

- Techniques for **data cleaning and transformation** before analysis.
- Use of **PostgreSQL functions** (e.g., `EXTRACT`, `ROUND`, casting types).
- Writing **complex queries** to solve analytical problems.
- Importance of **data quality** when importing and cleaning datasets.

---

## ✅ Conclusions
This project was a great hands-on exercise for sharpening SQL skills.  

**Key takeaways:**
- SQL is powerful for both **data cleaning** and **analysis**.

- Proper data types and schema design simplify downstream work.
- Real-world datasets often require **significant preprocessing** to become analysis-ready.

**Future improvements:**
- Build a **dashboard** to visualize top metrics.

- Automate ETL (Extract, Transform, Load) processes for cleaner imports.

- Expand analysis to include more datasets.

---