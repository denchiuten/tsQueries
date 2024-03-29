SELECT
    hist.*
  FROM jra.issue_multiselect_history AS hist
  INNER JOIN (
    SELECT 
      field_id,
      issue_id,
      MAX(time) AS latest_time
    FROM jra.issue_multiselect_history
    GROUP BY 1,2
  ) AS latest
      ON hist.issue_id = latest.issue_id
      AND hist.field_id = latest.field_id
      AND hist.time = latest.latest_time
);