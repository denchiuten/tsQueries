SELECT DISTINCT
	map.linear_label_name
LEFT JOIN plumbing.jira_fix_version_to_linear_label AS map
	ON v.name = map.jira_version_name