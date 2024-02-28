SELECT DISTINCT 
	v.name AS jira_version_name
FROM jra.issue AS i
INNER JOIN jra.vw_latest_issue_multiselect_value AS field
	ON i.id = field.issue_id
	AND field_id = 'fixVersions'
INNER JOIN jra.version AS v
	ON field.value = v.id
ORDER BY 1