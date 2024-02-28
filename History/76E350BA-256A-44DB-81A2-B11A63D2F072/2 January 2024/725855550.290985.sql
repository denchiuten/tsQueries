SELECT 'DROP TABLE "' || table_schema || '"."' || table_name || '" CASCADE;' 
FROM information_schema.tables 
WHERE table_schema = 'slack';