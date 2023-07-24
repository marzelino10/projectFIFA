/* Matches played per team */

SELECT country_name, COUNT(country_name) AS no_matches_played
FROM (
      SELECT home_team_name AS country_name   
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch` 
      UNION ALL
      SELECT away_team_name AS country_name
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch`
      )
GROUP BY country_name
ORDER BY no_matches_played DESC;



/* Goals per country */

SELECT country_name, SUM(country_score) AS total_goals
FROM (
      SELECT home_team_name AS country_name,
             home_team_score AS country_score     
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch` 
      UNION ALL
      SELECT away_team_name AS country_name,
             away_team_score AS country_score
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch`
      )
GROUP BY country_name
ORDER BY total_goals DESC;


/*  host country performance AS host */

SELECT country_name, 
       COUNT(host_country_win) AS matches_host_played,
       SUM(host_country_win) AS matches_host_won,
       SUM(host_country_win)/COUNT(host_country_win)*100 AS host_winrate
FROM (
      SELECT match_id, match_name, stage_name, home_team_name, away_team_name, country_name, result,
      CASE  WHEN result = 'home team win' AND home_team_name = country_name THEN 1
            WHEN result = 'away team win' AND away_team_name = country_name THEN 1
            ELSE 0
            END AS host_country_win
      FROM `FIFA_World_Cup.AllMatch`
      WHERE home_team_name = country_name OR away_team_name = country_name
      ORDER BY match_id
      )
GROUP BY country_name
ORDER BY matches_host_played DESC;


/*  host country performance AS guest */

SELECT country_name, 
       COUNT(host_country_win) AS matches_host_played,
       SUM(host_country_win) AS matches_host_won,
       SUM(host_country_win)/COUNT(host_country_win)*100 AS host_winrate
FROM (
      SELECT *
      FROM `FIFA_World_Cup.AllMatch`
      WHERE home_team_name IN ('Germany, Brazil, Italy, Mexico, France, South Korea, Argentina, Chile, England, Sweden, Russia, Spain, Japan, United States, Uruguay, Switzerland, Qatar, South Africa')
       OR   away_team_name IN ('Germany, Brazil, Italy, Mexico, France, South Korea, Argentina, Chile, England, Sweden, Russia, Spain, Japan, United States, Uruguay, Switzerland, Qatar, South Africa')
      )
GROUP BY country_name
ORDER BY matches_host_played DESC;


/* total match host country won */

SELECT country_name, SUM(host_country_win) AS total_host_win
FROM (
      SELECT match_id, match_name, stage_name, home_team_name, away_team_name, country_name, result,
      CASE  WHEN result = 'home team win' AND home_team_name = country_name THEN 1
            WHEN result = 'away team win' AND away_team_name = country_name THEN 1
            ELSE 0
            END AS host_country_win
      FROM `FIFA_World_Cup.AllMatch`
      WHERE home_team_name = country_name OR away_team_name = country_name
      ORDER BY match_id
      )
GROUP BY country_name
ORDER BY total_host_win DESC;



/* Teams Statistics */

SELECT country_name, 
       SUM(matches_played) AS played,
       SUM(matches_won) AS wins,
       SUM(matches_draw) AS draws,
       SUM(matches_lost) AS losses,
       SUM(matches_won)/SUM(matches_played)*100 AS winrate,
       SUM(goals_scored) AS goals_for,
       SUM(goals_conceded) AS goals_against,
       SUM(goals_scored)/SUM(matches_played) AS gpm
FROM (
      SELECT home_team_name AS country_name,
             COUNT(home_team_name) AS matches_played,
             SUM(home_team_win) AS matches_won,
             SUM(draw) AS matches_draw,
             SUM(away_team_win) AS matches_lost,
             SUM(home_team_score) AS goals_scored,
             SUM(away_team_score) AS goals_conceded
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch` 
      GROUP BY home_team_name
      UNION ALL
      SELECT away_team_name AS country_name,
             COUNT(away_team_name) AS matches_played,
             SUM(away_team_win) AS matches_won,
             SUM(draw) AS matches_draw,
             SUM(home_team_win) AS matches_lost,
             SUM(away_team_score) AS goals_scored,
             SUM(home_team_score) AS goals_conceded
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch`
      GROUP BY away_team_name
      )
GROUP BY country_name
ORDER BY played DESC;


/* Biggest Win AND Loss */
SELECT country_name, 
       MAX(most_gf) AS biggest_gf,
       MIN(most_ga) AS biggest_ga
FROM (
      SELECT home_team_name AS country_name,
            MAX(home_team_score - away_team_score) AS most_gf,
            MIN(home_team_score - away_team_score) AS most_ga
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch` 
      GROUP BY home_team_name
      UNION ALL
      SELECT away_team_name AS country_name,
            MAX(away_team_score - home_team_score) AS most_gf,
            MIN(away_team_score - home_team_score) AS most_ga
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch`
      GROUP BY away_team_name
      )
GROUP BY country_name
ORDER BY biggest_ga DESC;



/* Country participation */

SELECT country_name, COUNT(DISTINCT(tournament_id)) AS appearance
FROM (
      SELECT tournament_id, home_team_name AS country_name   
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch` 
      UNION ALL
      SELECT tournament_id, away_team_name AS country_name
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch`
      )
GROUP BY country_name
ORDER BY appearance DESC;


/* Biggest Win */

SELECT country_name, 
       MAX(biggest_win)
FROM (
      SELECT home_team_name AS country_name,
             MAX(score) AS biggest_win   
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch`
      WHERE score != '0-0' AND result = 'home team win'
      GROUP BY country_name
      UNION ALL
      SELECT away_team_name AS country_name,
             MAX(reverse(score)) AS biggest_win   
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch`
      WHERE score != '0-0' AND result = 'away team win'
      GROUP BY country_name)
GROUP BY country_name
ORDER BY MAX(biggest_win) DESC;




/* Biggest Loss */

SELECT country_name, 
       reverse(MAX(biggest_loss))
FROM (
      SELECT home_team_name AS country_name,
             MAX(reverse(score)) AS biggest_loss   
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch`
      WHERE score != '0-0' AND result = 'away team win'
      GROUP BY country_name
      UNION ALL
      SELECT away_team_name AS country_name,
             MAX(score) AS biggest_loss   
      FROM `insights-lab-380602.FIFA_World_Cup.AllMatch`
      WHERE score != '0-0' AND result = 'home team win'
      GROUP BY country_name)
GROUP BY country_name
ORDER BY MAX(biggest_loss) DESC
