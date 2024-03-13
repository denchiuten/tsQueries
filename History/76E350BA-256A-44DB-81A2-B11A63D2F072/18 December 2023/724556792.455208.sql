SELECT	
    hist.issue_id,
    hist.value AS assignee,
    DENSE_RANK() OVER (
        ORDER BY hist.time DESC
        PARTITION BY hist.issue_id
    ) AS rank
FROM jra.issue_field_history AS hist
INNER JOIN (
    SELECT 
        field.issue_id
    FROM jra.vw_latest_issue_field_value AS field
    WHERE
        field.field_id = 'assignee'
        AND field.value IS NULL
        AND field.time::DATE = '2023-12-14'
        AND field.author_id = '63c50741cd6a09abe71e007c' -- Bryan
) AS set_alias
    ON hist.issue_id = set_alias.issue_id
WHERE
    hist.field_id = 'assignee'
ORDER BY hist.issue_id, rank;