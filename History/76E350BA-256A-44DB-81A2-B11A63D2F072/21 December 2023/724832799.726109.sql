SELECT
	l.email
FROM hubs.owner AS h
INNER JOIN linear.users AS l
	ON h.email = l.email
WHERE h.owner_id = 527732754