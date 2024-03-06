SELECT h.*
FROM jra.issue_multiselect_history AS h
INNER JOIN jra.issue AS i
	ON h.issue_id = i.id
	AND i."key" = 'REDUCE-442'
WHERE field_id = 'customfield_10000' AND value <> '{}'
LIMIT 500;