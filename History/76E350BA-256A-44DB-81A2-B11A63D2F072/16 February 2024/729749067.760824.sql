UPDATE plumbing.hs_ticket_to_linear_label
SET linear_label_id = linear.label.id
FROM linear.label
WHERE 
	plumbing.hs_ticket_to_linear_label.linear_label_name = linear.label.name
	AND linear.label._fivetran_deleted IS FALSE;