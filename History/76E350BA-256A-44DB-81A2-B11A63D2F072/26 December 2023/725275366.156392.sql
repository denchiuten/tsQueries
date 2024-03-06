SELECT *
FROM jra.sprint
WHERE
	1 = 1
	AND _fivetran_deleted IS FALSE
	AND start_date IS NOT NULL
	AND state <> 'closed'