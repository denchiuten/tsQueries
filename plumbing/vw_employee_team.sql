CREATE OR REPLACE VIEW bob.vw_employee_team AS
SELECT
	h.employee_id,
	JSON_EXTRACT_PATH_TEXT(h.custom_columns::VARCHAR, 'column_1681191721226') AS team_id,
	clv.name AS team_name
FROM bob.employee_work_history AS h
INNER JOIN bob.employee AS e
	ON h.employee_id = e.id
	AND e._fivetran_deleted IS FALSE
INNER JOIN bob.company_list_value AS clv
	ON JSON_EXTRACT_PATH_TEXT(h.custom_columns::VARCHAR, 'column_1681191721226') = clv.id
WHERE
	1 = 1
	AND h.is_current IS TRUE 
	AND JSON_EXTRACT_PATH_TEXT(h.custom_columns::VARCHAR, 'column_1681191721226') <> '';