SELECT
	h.email,
	h.owner_id
FROM linear.users AS l
INNER JOIN hubs.owner AS h
	ON l.email = h.email
WHERE l.id = ''

