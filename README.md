# Netflix Movies and TV Shows Data Analysis using SQL

![Netflix Logo](https://github.com/Mallikaa-24/netflix_sql_project/blob/main/logo.jpg)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(10),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year VARCHAR(100),
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
select 
 type, count(*) as total_content
 from netflix
 group by type;
```
**Objective:** Determine the distribution of content types on Netflix.

### 2. List all movies released in a particular year (e.g. 2020)

```sql
select title 
 from netflix 
 where type = 'Movie' and release_year = '2020';
```
**Objective:** Retrieve all movies released in a specific year.

### 3. Find the top 5 countries with most content on Netflix

```sql
 select unnest(string_to_array(country,',')) as new_country,
 count(*) as total_content
 from netflix
 group by country
 order by 2 desc limit 5;
```
**Objective:** Identify the top 5 countries with the highest number of content items.

### 4. Identify the longest movie

```sql
 select title,duration
 from netflix
 where type= 'Movie' and duration = (Select (Max(duration)) from netflix);
```
**Objective:** Find the movie with the longest duration.

### 5. Find the content added in the last 5 years

```sql
select * 
from netflix
where to_date(date_added,'Month,DD,YYYY') >= current_date - interval'5 years';
```
**Objective:** Retrieve content added to Netflix in the last 5 years.

### 6. Find all the movies/TV shows by director 'Rajiv Chilaka'

```sql
select *
from netflix
where director like '%Rajiv Chilaka%';
```
**Objective:** List all content directed by 'Rajiv Chilaka'.

### 7. List all shows with more than 5 seasons

```sql
select title, duration
from netflix
where 
split_part(duration,' ',1)::numeric > 5  and type = 'TV Show';
```
**Objective:** Identify TV shows with more than 5 seasons.

### 8. Count the number of items in each genre

```sql
select unnest(string_to_array(listed_in,',')) as genre, count(show_id) as total_content
from netflix
group  by 1;
```
**Objective:** Count the number of content items in each genre.

### 9. List all movies that are documentaries

```sql
Select *
from netflix
where listed_in like '%Documentaries%';
```
**Objective:** Retrieve all movies classified as documentaries.

### 10. Find all content without a director

```sql
Select * 
from netflix
where director is null;
```
**Objective:** List content that does not have a director.

## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.

