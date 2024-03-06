SELECT
	type.name AS issue_type,
	i.key AS issue_key,
	i.id AS issue_id,
	p.key AS project_key,
	p.name AS project_name
FROM jra.issue AS i
INNER JOIN jra.project AS p
	ON i.project = p.id
	AND p._fivetran_deleted IS FALSE
INNER JOIN jra.issue_type AS type
	ON i.issue_type = type.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE
	AND p.key NOT IN (
		'AAM',
		'AG',
		'AH',
		'AWS',
		'BI',
		'COM',
		'COO',
		'DBCLEAN',
		'DC',
		'DG',
		'DTC',
		'EFDB',
		'ESGR',
		'FINA',
		'IM',
		'KB',
		'LR',
		'MAR',
		'MNGAC',
		'OP',
		'PTINC',
		'PTSI',
		'SUS',
		'TEST',
		'TI',
		'TM',
		'TV2'
	)