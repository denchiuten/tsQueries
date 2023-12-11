SELECT COUNT(fb.id)
FROM hubs.customer_feedback_submissions AS fb
WHERE fb.property_survey_name LIKE '%CSM%'