SELECT h.*
FROM jra.issue_field_history AS h
INNER JOIN jra.issue AS i
	ON h.issue_id = i.id
	AND i.key = 'MEASURE-3421'
WHERE h.field_id = 'issuekey'
ORDER BY h.time