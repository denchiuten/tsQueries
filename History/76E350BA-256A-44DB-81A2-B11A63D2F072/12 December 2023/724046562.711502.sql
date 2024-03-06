SELECT
	    id,
	    property_email as email
	  FROM
	    hubs.contact
	  WHERE
	    property_email IS NOT NULL