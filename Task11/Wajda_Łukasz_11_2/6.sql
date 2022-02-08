CREATE OR REPLACE FUNCTION lab04.get_cursor() 
RETURNS refcursor AS
$$ 
DECLARE curuczestnik refcursor  ;
BEGIN
  OPEN curuczestnik FOR SELECT id, fname, lname  FROM lab04.person;
  RETURN curuczestnik ;
END;
$$ LANGUAGE plpgsql;