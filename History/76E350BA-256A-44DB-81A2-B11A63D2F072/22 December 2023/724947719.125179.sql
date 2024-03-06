SELECT COUNT(i.*)
FROM jra.issue AS i
INNER JOIN jra.vw_latest_issue_multiselect_value AS f
	ON i.id = f.issue_id
	AND f.field_id = 'fixVersions'