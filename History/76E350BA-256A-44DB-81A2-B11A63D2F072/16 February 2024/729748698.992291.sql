SELECT 
	map.*,
	l.id,
	l.name,
	l.team_id,
	l._fivetran_deleted
FROM plumbing.hs_ticket_to_linear_label AS map
LEFT JOIN linear.label AS l
	ON map.linear_label_id = l.id