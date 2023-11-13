-- função simples em SQL usando $body$
CREATE OR REPLACE FUNCTION incrementar (valor integer) RETURNS integer AS $body$ BEGIN RETURN valor + 1;
END;
$body$ LANGUAGE plpgsql;
-- incrementar
SELECT incrementar(1);
-- ------------