SELECT email FROM bob.employee AS b WHERE b.surname = 'Tizon'
UNION ALL
SELECT s.profile_email FROM slack.users AS s WHERE s.id = 'U04HZ9905U3'
UNION ALL 
SELECT email FROM linear.users AS l WHERE l.name LIKE '%Tizon%'