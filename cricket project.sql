CREATE DATABASE first_project;
USE first_project;
SELECT * FROM cricket_data limit 3;

UPDATE cricket_data
SET start_date = STR_TO_DATE(start_date, '%d-%m-%Y');

UPDATE cricket_data
SET end_date = STR_TO_DATE(end_date, '%d-%m-%Y');

UPDATE cricket_data
SET start_date = left(start_date, 10);

UPDATE cricket_data
SET end_date = left(end_date, 10);

ALTER TABLE cricket_data
MODIFY COLUMN start_date DATE;

ALTER TABLE cricket_data
MODIFY COLUMN end_date DATE;

 # Q:1 Total matches played ?-- 
 
 SELECT count(*) AS total_matches
 FROM cricket_data;
 
 # Q2 How many matches were played in each season?
 
 SELECT season , COUNT(*) AS total_matches
 FROM cricket_data
 GROUP BY season
 ORDER BY season;
 
# Q3 Which team has won the most matches?

SELECT winner, COUNT(*) AS wins 
FROM cricket_data
GROUP BY winner
ORDER BY wins DESC

# Q3 Top 5 teams with the most wins?

SELECT winner, COUNT(*) AS wins
FROM cricket_data
GROUP BY winner
ORDER BY wins DESC
LIMIT 5;


# Q5 How many times did a team win both the toss and the match?

SELECT count(*) AS toss_and_match_win
FROM cricket_data
WHERE toss_won = winner;

# Q6 Toss decision analysis: Batting first vs Bowling (Fielding) first

SELECT decision, COUNT(*) AS total
FROM cricket_data 
group by decision;

# Q7 Highest first innings score ?

SELECT MAX(first_inning_score) AS highest_score
from cricket_data;

# Q8 Lowest first innings score?

SELECT min(first_inning_score) AS highest_score
from cricket_data;

# Q9 Which player has won the Player of the Match award the most times?

SELECT pom, COUNT(*) AS awards 
from cricket_data 
group by pom
order by awards desc
limit 5

# Home team vs Away team performance analysis?
SELECT home_team, COUNT(*) AS away_matches
FROM cricket_data
GROUP BY away_team;

# Matches won by chasing the target ?

select count(*) as chasing_wins
from cricket_data
where second_inning_score > first_inning_score;

# Season-wise winner count?

SELECT season, winner, count(*) AS wins
from cricket_data
group by season, winner 
order by season, winner, wins desc

# Average score per match ?

SELECT 
    AVG(first_inning_score) AS avg_first,
    AVG(second_inning_score) AS avg_second
FROM cricket_data;

-- Close matches (winning margin less than 10 runs)?
select * from cricket_data
where abs(first_inning_score-second_inning_score) <10;

-- Team-wise win percentage?

SELECT 
    winner,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cricket_data) AS win_percentage
FROM cricket_data
GROUP BY winner
ORDER BY win_percentage DESC;







 

