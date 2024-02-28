WITH numbers AS (
	  SELECT 1 AS n UNION ALL
	  SELECT 2 UNION ALL
	  SELECT 3 UNION ALL
	  SELECT 4 UNION ALL
	  SELECT 5 UNION ALL
	  SELECT 6 UNION ALL
	  SELECT 7 UNION ALL
	  SELECT 8 UNION ALL
	  SELECT 9 UNION ALL
	  SELECT 10 UNION ALL
	),
	split_merged_ids AS (
	  SELECT 
	    id, 
	    SPLIT_PART(hc.property_hs_merged_object_ids, ';', n.n) as email
	  FROM 
	    hubs.contact AS hc, 
	    numbers AS n
	  WHERE 
	    SPLIT_PART(hc.property_hs_merged_object_ids, ';', n.n) <> ''
-- 	    AND hc.property_hs_additional_emails IS NOT NULL
	)