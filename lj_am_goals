/* Creating a new table by left-joining All Match and Goals tables */

BEGIN;

CREATE TABLE FIFA_World_Cup.LJoin_AM_Goal AS (
    SELECT 
      m.key_id_am AS key_id, 
      m.tournament_id AS tournament_id,
      m.tournament_name AS tournament_name,
      m.match_id AS match_id,
      m.match_name AS match_name,
      m.stage_name AS stage_name,
      m.match_date AS match_date,
      m.match_time AS match_time,
      m.stadium_id AS stadium_id,
      m.stadium_name AS stadium_name,
      m.city_name AS location_city_name,
      m.country_name AS location_country_name,
      m.home_team_name AS home_team_name,
      m.home_team_code AS home_team_code,
      m.away_team_name AS away_team_name,
      m.away_team_code AS away_team_code,
      m.score AS score,
      m.home_team_score AS home_team_score,
      m.away_team_score AS away_team_score,
      m.extra_time AS extra_time,
      m.penalty_shootout AS penalty_shootout,
      m.score_penalties AS score_penalties,
      m.home_team_score_penalties AS home_team_score_penalties,
      m.away_team_score_penalties AS away_team_score_penalties,
      m.result AS result,
      m.home_team_win AS home_team_win,
      m.away_team_win AS away_team_win,
      m.draw AS draw,
      g.goal_id AS goal_id,
      g.player_team_name AS scorer_team_name,
      g.player_team_code AS scorer_team_code,
      g.player_id AS scorer_player_id,
      g.family_name AS scorer_family_name,
      g.given_name AS scorer_given_name,
      g.shirt_number AS scorer_shirt_number,
      g.minute_regulation AS minute_regulation,
      g.minute_stoppage AS minute_stoppage,
      g.match_period AS match_period,
      g.own_goal AS own_goal,
      g.penalty AS penalty
    FROM `FIFA_World_Cup.AllMatch` AS m
    LEFT JOIN `FIFA_World_Cup.Goals`AS g
    ON m.match_id = g.match_id
    ORDER BY goal_id
    );

END


/* Match won after penalty */

SELECT scorer_team_name, 
       COUNT(*) AS matches_with_penalty,
       SUM(won) AS matches_won_after_penalty,
       SUM(won) / COUNT(*) * 100 AS winrate
FROM (
      SELECT match_id, scorer_team_name,
      CASE  WHEN result = 'home team win' AND home_team_name = scorer_team_name THEN 1
              WHEN result = 'away team win' AND away_team_name = scorer_team_name THEN 1
              ELSE 0
              END AS won
      FROM `insights-lab-380602.FIFA_World_Cup.LJoin_AM_Goal`
      WHERE penalty = 1
      ORDER BY match_id
      )
GROUP BY scorer_team_name;



/* Total own goal per team */
SELECT CASE WHEN scorer_team_name = home_team_name THEN away_team_name
            WHEN scorer_team_name = away_team_name THEN home_team_name
            END AS own_goal_for,
       SUM(own_goal) AS total_own_goal
      
FROM `insights-lab-380602.FIFA_World_Cup.LJoin_AM_Goal`
WHERE own_goal = 1
GROUP BY own_goal_for
ORDER BY total_own_goal DESC;


/* Goals per match */

SELECT  *,
        total_goals/matches_played AS goals_per_match
FROM (
        SELECT
              EXTRACT(Year FROM match_date) AS year,
              COUNT(goal_id) AS total_goals,
              COUNT(DISTINCT(match_id)) AS matches_played
        FROM `insights-lab-380602.FIFA_World_Cup.LJoin_AM_Goal`
        GROUP BY EXTRACT(Year FROM match_date)
      )
ORDER BY year;


/* Total penalty per team */
SELECT scorer_team_name,
       COUNT(goal_id) AS total_penalties
FROM `insights-lab-380602.FIFA_World_Cup.LJoin_AM_Goal`
WHERE goal_id IS NOT NULL AND own_goal = 0 AND penalty = 1
GROUP BY scorer_team_name
ORDER BY total_penalties DESC;




/* Team won after own goal */
SELECT scorer_team_name,
       match_winner,
       CASE WHEN scorer_team_name = match_winner THEN 1
       ELSE 0 
       END AS team_won_after_own_goal
FROM (
      SELECT scorer_team_name,
            CASE WHEN scorer_team_name = home_team_name AND result = 'home team win' THEN home_team_name
                  WHEN scorer_team_name = home_team_name AND result = 'away team win' THEN away_team_name
                  WHEN scorer_team_name = away_team_name AND result = 'away team win' THEN away_team_name
                  WHEN scorer_team_name = away_team_name AND result = 'home team win' THEN home_team_name
                  ELSE 'Draw'
            END AS match_winner
      FROM `insights-lab-380602.FIFA_World_Cup.LJoin_AM_Goal`
      WHERE goal_id IS NOT NULL 
            AND own_goal = 1 
      ORDER BY scorer_team_name
      )
GROUP BY scorer_team_name, match_winner
