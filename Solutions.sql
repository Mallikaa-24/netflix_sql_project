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

select * from netflix;

-- 15 Business Problems

--1. Count the number of movies vs tv shows
select 
 type, count(*) as total_content
 from netflix
 group by type;

 --2. List all movies released in a particular year (e.g. 2020)
 select title 
 from netflix 
 where type = 'Movie' and release_year = '2020';

 --3. Find the top 5 countries with most content on Netflix
 select unnest(string_to_array(country,',')) as new_country,
 count(*) as total_content
 from netflix
 group by country
 order by 2 desc limit 5;

 --4. Identify the longest movie
 select title,duration
 from netflix
 where type= 'Movie' and duration = (Select (Max(duration)) from netflix);

 --5. Find the content added in the last 5 years
select * 
from netflix
where to_date(date_added,'Month,DD,YYYY') >= current_date - interval'5 years';

--6. Find all the movies/TV shows by director 'Rajiv Chilaka'
select *
from netflix
where director like '%Rajiv Chilaka%';

--7. List all shows with more than 5 seasons
select title, duration
from netflix
where 
split_part(duration,' ',1)::numeric > 5  and type = 'TV Show';

--8. Count the number of items in each genre
select unnest(string_to_array(listed_in,',')) as genre, count(show_id) as total_content
from netflix
group  by 1;

--9. List all movies that are documentaries
Select *
from netflix
where listed_in like '%Documentaries%'
;

--10. Find all content without a director
Select * 
from netflix
where director is null;
 
 