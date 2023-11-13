-- adcionar a uma tabela
-- codigo | CD! | CD2 | CD3 | CD4 | CD5 | CD6
-- Fornecedor 1 | 300 | 40 | 32 | 50 | 2.9 | Nacional
CREATE OR REPLACE FUNCTION public.fornecedor1() RETURNS TABLE(
        cd1 integer,
        cd2 integer,
        cd3 integer,
        cd4 integer,
        cd5 numeric,
        cd6 character varying
    ) LANGUAGE plpgsql AS $function$
DECLARE fornecedor1 RECORD;
BEGIN FOR fornecedor1 IN
SELECT *
FROM fornecedor1 LOOP RETURN NEXT fornecedor1;
END LOOP;
END;
$function$;




