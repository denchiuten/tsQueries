SELECT d.property_dealtype, COUNT(*)
FROM hubs.deal AS d
GROUP BY 1