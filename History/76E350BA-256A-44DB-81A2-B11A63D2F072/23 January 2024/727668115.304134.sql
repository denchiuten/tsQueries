SELECT i.*
FROM linear.issue_history AS h
INNER JOIN linear.issue AS i
	ON h.issue_id = i.id
	AND i._fivetran_deleted IS FALSE
INNER JOIN linear.issue_label AS il
	ON i.id = il.issue_id
	AND il.label_id = '049096e6-b6a2-4f56-b9ea-e5c643e9e279'