--------------------- check if hubspot link is added into the Linear project and pull the project name

SELECT DISTINCT
	p.name AS project_name,
	p.url AS linear_project_link,
	pl.url AS attached_hubspot_company_link
FROM linear.project AS p
INNER JOIN linear.project_link AS pl
	ON p.id = pl.project_id
WHERE pl.url = -- HubSpot company link --


--------------------- extracting basic information of customer from hubspot

SELECT DISTINCT
	c.id
	c.property_name AS company_name,
	c.property_address||' '||c.property_zip AS company_address,
	REPLACE(INITCAP(c.property_industry), '_', ' '),
	d.property_commencement_date::DATE,
	d.property_end_date::DATE,
	EXTRACT('year' FROM CURRENT_DATE) AS reporting_year
FROM hubs.deal AS d
INNER JOIN hubs.deal_company AS dc
	ON d.deal_id = dc.deal_id
	AND d._fivetran_deleted IS FALSE
	AND d.property_commencement_date IS NOT NULL
	AND d.property_end_date IS NOT NULL
INNER JOIN hubs.company AS c
	ON dc.company_id = c.id
	AND c._fivetran_deleted IS FALSE
WHERE SPLIT_PART('https://app.hubspot.com/contacts/22313216/record/0-2/9717757750', '/', 8) = c.id


--------------------- extracting involved team members from Linear issue assignees 

SELECT DISTINCT
	SPLIT_PART(pl.url, '/', 8) AS company_id, 
	p.name AS project_name,
	pl.url,
	e.full_name AS employee_name,
	e.title AS employee_work_title,
	'Terrascope' AS organization		
FROM linear.project AS p
INNER JOIN linear.project_link AS pl
	ON p.id = pl.project_id
INNER JOIN linear.issue AS i
	ON p.id = i.project_id
	AND i._fivetran_deleted IS FALSE
INNER JOIN linear.users AS u
	ON i.assignee_id = u.id
	AND u._fivetran_deleted IS FALSE
INNER JOIN bob.employee AS e
	ON u.email = e.email
	AND e._fivetran_deleted IS FALSE
WHERE p.name ILIKE 'IM - %'
-- WHERE p.name = 'IM - MediaCorp 2022 (Apr-Mar)'
	AND SPLIT_PART('https://app.hubspot.com/contacts/22313216/record/0-2/9717757750', '/', 8) = c.id
	AND p._fivetran_deleted IS FALSE
		


--------------------- extracting platform users from Auth0

SELECT DISTINCT
    'IM - MediaCorp 2022 (Apr-Mar)' AS project_name,
    c.property_name AS company_name,
    cont.property_firstname || ' ' || cont.property_lastname AS name,
    cont.property_jobtitle,
    LOWER(u.email) AS email,
--     r.name AS role_name,
--     r.description AS role_description,    
    LISTAGG(DISTINCT CASE 
        WHEN r.name ILIKE '%view%' THEN 'Viewer'
        WHEN r.name ILIKE '%edit%' THEN 'Editor'
        ELSE 'Other'
    END, ' | ') WITHIN GROUP (ORDER BY CASE 
        WHEN r.name ILIKE '%view%' THEN 'Viewer'
        WHEN r.name ILIKE '%edit%' THEN 'Editor'
        ELSE 'Other'
    END) AS access_type, 
--     CASE 
--     	WHEN r.name ILIKE '%view%' THEN 'Viewer'
--     	WHEN r.name ILIKE '%edit%' THEN 'Editor'
--     	ELSE 'Other'
--  		END AS access_type,	
    CASE 
        WHEN map.auth_0_id IS NULL THEN 'Internal'
        ELSE 'External'
        END AS data_plane_type
FROM auth0.users AS u
INNER JOIN hubs.contact_to_emails AS h
    ON LOWER(u.email) = LOWER(h.email)
INNER JOIN hubs.contact AS cont
	ON h.id = cont.id
INNER JOIN hubs.contact_company AS cc
	ON cont.id = cc.contact_id
INNER JOIN hubs.company AS c
	ON cc.company_id = c.id
INNER JOIN auth0.organization_member_role AS omr
    ON u.id = omr.member_id
    AND omr._fivetran_deleted IS FALSE
INNER JOIN auth0.role AS r
    ON omr.id = r.id
    AND r._fivetran_deleted IS FALSE
INNER JOIN auth0.organization AS o
    ON omr.organization_id = o.id
    AND o._fivetran_deleted IS FALSE
LEFT JOIN plumbing.auth_0_to_hubspot_company AS map
    ON o.id = map.auth_0_id
LEFT JOIN google_sheets.customer_config AS con
    ON omr.organization_id = con.org_id
WHERE u._fivetran_deleted IS FALSE
    AND data_plane_type = 'External'
    AND LOWER(u.email) NOT ILIKE '%@terrascope.com'
	AND c.property_name = 'Mediacorp Pte Ltd'
GROUP BY 1,2,3,4,5,7
ORDER BY 1

