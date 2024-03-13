SELECT h.*
FROM linear.issue_history AS h
INNER JOIN linear.issue AS i
	ON h.issue_id = i.id
	AND i._fivetran_deleted IS FALSE
INNER JOIN linear.issue_label AS il
	ON i.id = il.issue_id
	AND il.label_id = '049096e6-b6a2-4f56-b9ea-e5c643e9e279'
WHERE
	1 = 1
	AND h._fivetran_deleted IS FALSE
-- 	AND (h.from_assignee_id <> h.to_assignee_id OR h.from_state_id <> h.to_state_id)