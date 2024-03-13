SELECT 
	i.id AS jira_issue_id,
	i.key AS jira_issue_key,
	opt.name AS customer_name
	
FROM jra.issue AS i
INNER JOIN jra.vw_latest_issue_field_value AS fld
	ON i.id = fld.issue_id
	AND fld.field_id = 'customfield_11209'
	AND fld.value IS NOT NULL
INNER JOIN jra.field_option AS opt
	ON fld.value = opt.id
WHERE
	1 = 1
	AND i._fivetran_deleted IS FALSE