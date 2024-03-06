SELECT DISTINCT 
	v.id,
	p.key AS project_key,
	v.name AS version_name
FROM jra.issue AS i
INNER JOIN jra.vw_latest_issue_multiselect_value AS field
	ON i.id = field.issue_id
	AND field_id = 'fixVersions'
INNER JOIN jra.version AS v
	ON field.value = v.id
INNER JOIN jra.project AS p
	ON v.project_id = p.id
ORDER BY 2,3