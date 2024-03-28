CREATE OR REPLACE VIEW bob.vw_employee_team AS
SELECT
	h.employee_id,
	
	-- function to extract the value of a custom column that we use in Hibob to record each employee's team
	JSON_EXTRACT_PATH_TEXT(h.custom_columns::VARCHAR, 'column_1681191721226') AS team_id,
	clv.name AS team_name
FROM bob.employee_work_history AS h
INNER JOIN bob.employee AS e
	ON h.employee_id = e.id
	AND e._fivetran_deleted IS FALSE

-- now join to company_list_value table to map the value of the column_1681191721226 column to a name for each team
INNER JOIN bob.company_list_value AS clv
	ON JSON_EXTRACT_PATH_TEXT(h.custom_columns::VARCHAR, 'column_1681191721226') = clv.id
WHERE
	1 = 1
	AND h.is_current IS TRUE -- required because employee_work_history adds a new row each time an employee changes roles
	AND JSON_EXTRACT_PATH_TEXT(h.custom_columns::VARCHAR, 'column_1681191721226') <> '';