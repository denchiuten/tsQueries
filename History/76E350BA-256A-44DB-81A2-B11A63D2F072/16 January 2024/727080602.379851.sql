SELECT ooo.*
FROM bob.employee_out_of_office AS ooo
INNER JOIN bob.employee AS e
	ON ooo.employee_id = e.id
WHERE
	1 = 1
	AND ooo._fivetran_deleted IS FALSE
	AND e.first_name = 'Lovish'