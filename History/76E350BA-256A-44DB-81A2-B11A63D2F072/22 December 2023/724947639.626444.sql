SELECT *
FROM jra.issue_multiselect_history
WHERE field_id IN ('versions', 'fixVersions')
LIMIT 1000