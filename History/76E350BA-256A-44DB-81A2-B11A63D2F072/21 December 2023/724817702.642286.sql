SELECT * FROM linear.issue
WHERE team_id IN (
    SELECT id
    FROM linear.team
    WHERE key IN ('CCF','DSCI','PLAT','SEC', 'QA')
)
AND _fivetran_deleted = TRUE;