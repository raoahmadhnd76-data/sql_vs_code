CREATE TABLE TMDB_all_movies (
    id INT,
    title VARCHAR(255),
    vote_average FLOAT,
    vote_count INT,
    status VARCHAR(50),
    release_date DATE,
    revenue BIGINT,
    runtime INT,
    budget BIGINT,
    imdb_id VARCHAR(20),
    original_language VARCHAR(10),
    original_title VARCHAR(255),
    popularity FLOAT,
    genres TEXT,
    production_companies TEXT,
    production_countries TEXT,
    spoken_languages TEXT,
    director TEXT,
    writers TEXT,
    producers TEXT,
    imdb_rating FLOAT,
    imdb_votes INT
);

-- Paste the following command in postgresql in PSQL TOOL of the imdb_movies database
-- \copy TMDB_all_movies FROM 'C:\Users\mahme\Downloads\Data Analysis\sql_vs_code\TMDB_all_movies.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');