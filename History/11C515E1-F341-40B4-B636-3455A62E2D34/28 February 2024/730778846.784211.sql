SELECT
	h.*
FROM linear.issue_history AS h
INNER JOIN linear.issue AS i
	ON h.issue_id = i.id
	AND i.identifier = 'OPS-248'