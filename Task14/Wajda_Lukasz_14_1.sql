--cw1
SELECT id, xpath('//lname/text()', data)::text,xpath('//address/city/text()', data)::text FROM xml_table WHERE xpath('//contact/email/text()', data)::text = '{%@o2.pl}';
--cw2
SELECT id, xpath('//lname/text()', data)::text, xpath('//address/city/text()', data)::text 
FROM xml_table WHERE CAST(id AS int) > 10000 AND CAST( id AS int) < 2000;

