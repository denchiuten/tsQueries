SELECT *
FROM plumbing.business_hours_sg
ORDER BY ABS(EXTRACT(EPOCH FROM (business_hour::timestamp - TIMESTAMP '2024-02-13T06:12:12.896Z')))
LIMIT 1;