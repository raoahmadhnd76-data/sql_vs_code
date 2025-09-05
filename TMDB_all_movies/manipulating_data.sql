SELECT *
FROM tmdb_all_movies
LIMIT 1000;

-- Find all movies released in 2020.

SELECT 
        title,
        release_date
FROM 
        tmdb_all_movies
WHERE
        EXTRACT(YEAR FROM release_date) = 2020
LIMIT 
        100;

-- List all unique status values (e.g., Released, Rumored).

SELECT distinct
        status
FROM
        tmdb_all_movies
LIMIT
        100;

-- Get the top 5 longest movies by runtime.

SELECT 
        title,
        runtime
FROM
        tmdb_all_movies
ORDER BY
        runtime desc
LIMIT 
        100;

-- Find all movies with vote_average > 8.0.

SELECT 
        title,
        vote_average
FROM
        tmdb_all_movies
WHERE
        vote_average > 8
ORDER BY
        vote_average desc
LIMIT 
        100;

-- 🔹 Intermediate Level
-- Get the total revenue per year.

SELECT 
        EXTRACT(year FROM release_date) as movies_year,
        sum(revenue) as total_revenue
FROM
        tmdb_all_movies
WHERE 
        status = 'Released'
GROUP BY
        movies_year
ORDER BY
        movies_year
LIMIT 
        1000;

-- List the top 10 highest-grossing movies.

SELECT 
        title,
        revenue
FROM
        tmdb_all_movies
ORDER BY
        revenue desc
LIMIT 
        1000;

-- Find all movies with missing or zero budget.

SELECT 
        title,
        budget
FROM
        tmdb_all_movies
WHERE
        budget = 0 OR budget is null
ORDER BY
        revenue desc
;

-- Show how many movies were made in each original_language.

SELECT 
        original_language,
        count(title) as title_count
FROM
        tmdb_all_movies
GROUP BY
        original_language
ORDER BY
        title_count desc
;

-- Find the movie with the maximum runtime.

SELECT 
        title,
        runtime
FROM
        tmdb_all_movies
ORDER BY
        runtime desc
LIMIT 
        1000;

-- Advanced Level
-- Find the top 5 directors by total revenue of their movies.

SELECT 
        director,
        SUM(revenue) as total_revenue
FROM
        tmdb_all_movies
WHERE
        director is not null
GROUP BY
        director
ORDER BY
        total_revenue desc
LIMIT
        100;

-- Calculate the average vote_average per decade.

SELECT 
    ((EXTRACT(YEAR FROM release_date)::INT) / 10) * 10 AS decade,
    ROUND(AVG(vote_average)::NUMERIC, 2) AS avg_rating
FROM TMDB_all_movies
WHERE release_date IS NOT NULL
GROUP BY decade
ORDER BY decade;

-- List all movies where revenue is at least 10 times the budget.

SELECT 
        title,
        budget,
        revenue
FROM
        tmdb_all_movies
WHERE
        revenue = budget*10
ORDER BY
        revenue desc
LIMIT
        100;


-- to find out how many comma seperated values in genre column

select
        length(genres) - length(replace(genres, ',','')) as comma_count
FROM
        tmdb_all_movies
WHERE
        genres is not null
ORDER BY
        comma_count desc;

-- Split string genre into a single genre value

with
SELECT 
        split_part(genres,',', 1) as part1,
        split_part(genres,',', 2) as part2,
        split_part(genres,',', 3) as part3,
        split_part(genres,',', 4) as part4,
        split_part(genres,',', 5) as part5,
        split_part(genres,',', 6) as part6,
        split_part(genres,',', 7) as part7,
        split_part(genres,',', 8) as part8,
        split_part(genres,',', 9) as part9,
        split_part(genres,',', 10) as part10,
        split_part(genres,',', 11) as part11,
        split_part(genres,',', 12) as part12,
        split_part(genres,',', 13) as part13,
        split_part(genres,',', 14) as part14,
        split_part(genres,',', 15) as part15,
        split_part(genres,',', 16) as part16,
        split_part(genres,',', 17) as part17
FROM 
        tmdb_all_movies
WHERE
        genres is not null
;


-- Create seperate table for genres

CREATE TABLE genres_seperated AS
SELECT 
        UNNEST(STRING_TO_ARRAY(genres, ',')) AS single_genre
FROM 
        tmdb_all_movies
;


SELECT *
FROM genres_seperated;

update genres_seperated
set single_genre = trim(single_genre);

-- Find the number of movies per genre.

SELECT 
        single_genre,
        count(single_genre) as movie_per_genre
FROM
        genres_seperated
GROUP BY
        single_genre
ORDER BY
        movie_per_genre desc
;

-- 🔹 Bonus (More Complex)

-- Calculate ROI (Return on Investment)
-- ROI = (revenue - budget) / budget and show the top 10 movies with the highest ROI.

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

-- Find the earliest movie in your dataset for each language

SELECT 
        title,
        original_language,
        release_date
FROM
    (SELECT 
        title,
        original_language, 
        release_date,
        ROW_NUMBER() OVER(PARTITION BY original_language ORDER BY release_date) AS rn
     FROM
        tmdb_all_movies
    )
WHERE
        rn = 1;

-- Show the year with the most movie releases.

SELECT
        EXTRACT(year FROM release_date) as year,
        count(title) as movie_count
FROM
        tmdb_all_movies
WHERE
        release_date is not null
GROUP BY
        year
ORDER BY
        movie_count desc;

-- Count how many movies have “love” in their title.

SELECT
        count(title) as movie_count
FROM
        tmdb_all_movies
WHERE
        title like '%love%'
;


-- Rank movies by popularity per year using window functions.

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