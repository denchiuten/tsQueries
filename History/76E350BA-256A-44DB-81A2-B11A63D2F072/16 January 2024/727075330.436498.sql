SELECT *
FROM jra.issue_field_history
WHERE field_id = 'customfield_10000' AND value <> '{}'
LIMIT 500;