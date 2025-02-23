/* Awards won per awardees */
SELECT 
      CASE 
            WHEN given_name = 'not applicable' THEN family_name
            ELSE CONCAT(given_name, ' ', family_name)
            END AS full_name,
      COUNT(award_id) AS awards_won
FROM `insights-lab-380602.FIFA_World_Cup.AwardWinners`
GROUP BY full_name
ORDER BY awards_won DESC;


/* Players who won more than one award */
SELECT *
FROM (
      SELECT  tournament_id,
              award_name,
              full_name,
              COUNT(player_id) OVER (PARTITION BY tournament_id, full_name  ORDER BY award_id) AS running_awards
      FROM (
          SELECT *,
                CASE 
                      WHEN given_name = 'not applicable' THEN family_name
                      ELSE CONCAT(given_name, ' ', family_name)
                      END AS full_name
          FROM `insights-lab-380602.FIFA_World_Cup.AwardWinners`)
)
WHERE running_awards > 1
ORDER BY tournament_id, running_awards
