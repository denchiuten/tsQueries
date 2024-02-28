SELECT
	p.id AS page_id,
	p.url,
	p.description,
	u.email AS creator_email
FROM notion.page AS p
INNER JOIN notion.users AS u
	ON p.created_by = u.id
WHERE
	1 = 1
	AND p._fivetran_deleted IS FALSE