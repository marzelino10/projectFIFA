/* Total goals per year */

SELECT 
  EXTRACT(Year FROM match_date) AS year,
  COUNT(goal_id) AS total_goals
FROM `insights-lab-380602.FIFA_World_Cup.Goals` 
GROUP BY EXTRACT(Year FROM match_date);



/* Goals per player and country */

SELECT  player_team_name,
        CASE 
        WHEN given_name = 'not applicable' THEN family_name
        else concat(given_name, ' ', family_name)
        END AS full_name,
        COUNT(goal_id) AS total_goals
FROM `insights-lab-380602.FIFA_World_Cup.Goals`
WHERE own_goal = 0
GROUP BY player_team_name, full_name
ORDER BY total_goals DESC;




/* Goals BY sacred shirt number */
SELECT shirt_number, COUNT(goal_id) AS total_goals
FROM `insights-lab-380602.FIFA_World_Cup.Goals`
WHERE shirt_number IN (7, 9, 10, 11)
GROUP BY shirt_number
ORDER BY total_goals DESC

