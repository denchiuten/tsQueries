-- number of releases and security alerts per repository --

SELECT  
	   repo.id,
	   repo.name,
	   COUNT(r.id) AS no_of_releases,
	   r.published_at AS release_date,
	   COUNT(sa.number) AS no_of_security_alerts
	   -- find a date field for security alerts (synced in fivetran but not showing here)
FROM github.repository AS repo
LEFT JOIN github.release AS r
	ON repo.id = r.repository_id 
LEFT JOIN github.security_alert AS sa
	ON repo.id = sa.repository_id
GROUP BY 1,2,4
ORDER BY 2




