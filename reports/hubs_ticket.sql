SELECT DISTINCT
	   t1.issue_label_name AS linear_issue_label,
	   t1.issue_id AS linear_issueID,
	   t1.issue_title AS linear_issue_title,
	   t1.issue_description AS linear_issue_description,
	   t1.url AS hubspot_ticket_url,
	   ht.property_hs_ticket_id AS hubspot_ticketID,
	   ht.property_associated_contact_name AS associated_contact_name
	   
FROM (  SELECT 
			  t.name AS team_name,
			  l.name AS issue_label_name,			   	
			  RIGHT(a.url, 10) AS hubspot_ticketID,
			  i.id AS issue_id,
			  i.title AS issue_title,
			  i.description AS issue_description,
			  a.url AS url
		FROM linear.issue AS i
		INNER JOIN linear.team AS t
			ON i.team_id = t.id
			AND t._fivetran_deleted IS FALSE
		INNER JOIN linear.workflow_state AS ws
			ON t.id = ws.team_id
			AND ws._fivetran_deleted IS FALSE
			AND ws.name NOT IN ('Canceled', 'Duplicate')
		INNER JOIN linear.issue_label AS il
			ON i.id = il.issue_id 
			AND il._fivetran_deleted IS FALSE
		INNER JOIN linear.label AS l
			ON il.label_id = l.id
			AND l._fivetran_deleted IS FALSE
			AND l.id = '2bc391a6-06b5-4cb5-92f2-2e2802f695a8'
		INNER JOIN linear.attachment AS a
			ON i.id = a.issue_id
			AND a.url ILIKE '%/0-_/%'
			AND a._fivetran_deleted IS FALSE
		WHERE t.name = 'Customer Support'
			AND i._fivetran_deleted IS FALSE
) AS t1	

INNER JOIN hubs.ticket AS ht
	ON t1.hubspot_ticketID = ht.property_hs_ticket_id
	AND ht._fivetran_deleted IS FALSE