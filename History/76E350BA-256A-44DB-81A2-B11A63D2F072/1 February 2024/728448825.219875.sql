SELECT email FROM bob.employee AS b WHERE b.surname = 'Tizon'
UNION ALL
SELECT email FROM slack.users AS s WHERE s.profile_last_name = 'Tizon'
UNION ALL 
SELECT email FROM linear.users AS l WHERE l.name LIKE '%Tizon%'