SELECT 
        ooo.employee_id, 
        d.date
    FROM bob.employee_out_of_office AS ooo
    INNER JOIN plumbing.dates AS d