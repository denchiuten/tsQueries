DROP VIEW IF EXISTS bob.vw_ooo_dates;
CREATE VIEW bob.vw_ooo_dates AS (
    SELECT 
        ooo.employee_id, 
        LOWER(e.email) AS email,
        d.date
    FROM bob.employee_out_of_office AS ooo
    INNER JOIN bob.employee AS e
    		ON ooo.employee_id = e.id
    		AND e._fivetran_deleted IS FALSE
    		AND e.internal_status = 'Active'
    INNER JOIN plumbing.dates AS d
    		ON d.date BETWEEN ooo.start_date AND ooo.end_date
	WHERE
		1 = 1
		AND ooo._fivetran_deleted IS FALSE
);
