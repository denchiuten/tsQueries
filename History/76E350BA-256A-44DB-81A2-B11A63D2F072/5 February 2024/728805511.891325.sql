SELECT *
FROM notion.page AS p
WHERE 
	1 = 1
	AND p._fivetran_deleted IS FALSE
	AND p.database_id = 'bdc07b54-34cd-48cd-aabe-c211767cbcd7'