SELECT
	e.email,
	e.display_name,
	CASE 
		WHEN t.site_role = 'SiteAdministratorCreator' THEN 'Creator'
		ELSE t.site_role
		END AS current_license,
	NULL AS future_license
FROM bob.employee AS e
LEFT JOIN tableau.users AS t
	ON LOWER(e.email) = LOWER(t.email)
	AND t._fivetran_deleted IS FALSE
WHERE
	1 = 1
	AND e._fivetran_deleted IS FALSE
	AND e.internal_status = 'Active'
	AND e.payroll_employment_type <> 'Agency Contractor'
ORDER BY 3,1