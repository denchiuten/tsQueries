SELECT 
	map.*,
	l.id,
	l.name,
	l.team_id,
	parent.name AS parent_name
FROM plumbing.hs_ticket_to_linear_label AS map
LEFT JOIN linear.label AS l
	ON map.linear_label_name = l.name
	AND l._fivetran_deleted IS FALSE
LEFT JOIN linear.label AS parent
	ON l.parent_id = parent.id
	AND parent._fivetran_deleted IS FALSE;