SELECT 
	sub.created_at,
    sub.issue_id,
	INITCAP(sub.category) AS category,
	sub.label_name,
	sub.state
FROM (
    SELECT 
        i.created_at,
        i.id AS issue_id,
        l.name AS label_name, 
        w.name AS state,
        CASE
            WHEN l.name ILIKE '%sandbox%' THEN 'demo'
            WHEN l.parent_id = '08e6df05-2599-47af-a72b-3e3977601a1f' THEN 'product'
            -- Customer Name and ID label in Linear --
            WHEN i.sla_breaches_at IS NOT NULL THEN 'at_risk'
            ELSE NULL
        END AS category
    FROM linear.issue AS i
    INNER JOIN linear.issue_label AS il 
    	ON i.id = il.issue_id 
    	AND il._fivetran_deleted = FALSE
    INNER JOIN linear.label AS l 
    	ON il.label_id = l.id 
    	AND l._fivetran_deleted = FALSE
    INNER JOIN linear.team AS t 
    	ON i.team_id = t.id 
    	AND t._fivetran_deleted = FALSE 
    	AND t.id = '586f61ec-9886-418d-a1e4-0a304ee33e4a'
    	-- PTINC team ID in Linear -- 
    INNER JOIN linear.workflow_state AS w 
    	ON i.state_id = w.id 
    	AND w._fivetran_deleted = FALSE 
    	AND w.id NOT IN ('2282e77d-247a-4a9c-b144-fbb9b584dc54', '94d2cc72-64c7-4524-87d7-2975ced95c82')
    	-- Issue status not duplicate or canceled
) AS sub
WHERE category IS NOT NULL