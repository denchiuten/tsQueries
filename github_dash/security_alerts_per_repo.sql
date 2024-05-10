SELECT 
	sa.created_at,
	rep.name,
	sa.state,
	COUNT(sa.number) AS no_of_security_alerts
FROM github.security_alert AS sa
INNER JOIN github.repository AS rep
	ON sa.repository_id = rep.id
GROUP BY 1,2,3
ORDER BY 2
