SELECT DISTINCT	v.name AS jira_version_name,
	map.linear_label_nameFROM jra.issue AS iINNER JOIN jra.vw_latest_issue_multiselect_value AS field	ON i.id = field.issue_id	AND field_id = 'fixVersions'INNER JOIN jra.version AS v	ON field.value = v.id
LEFT JOIN plumbing.jira_fix_version_to_linear_label AS map
	ON v.name = map.jira_version_name