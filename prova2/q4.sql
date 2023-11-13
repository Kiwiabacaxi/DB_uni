-- 4 - Crie uma function onde passamos como parâmetro o código da peça e a remova da tabela encomenda. 
-- encomenda = pedido
CREATE TABLE PEDIDO(
    codpedido int,
    codcliente int,
    datapedido date,
    nf varchar(12),
    valortotal decimal(10, 2),
    CONSTRAINT pk2_pedido PRIMARY KEY (codpedido),
    CONSTRAINT pk2_pedido_cliente FOREIGN KEY (codcliente) REFERENCES CLIENTE(codcliente)
);
-- aa
CREATE OR REPLACE FUNCTION remove_pedido(cod_pedido int) RETURNS void AS $body$ BEGIN
DELETE FROM ITEMPEDIDO
WHERE codpedido = cod_pedido;
DELETE FROM PEDIDO
WHERE codpedido = cod_pedido;
END;
$body$ LANGUAGE plpgsql;
-- SINTAXE BUNITINHA
CREATE OR REPLACE FUNCTION remove_pedido(cod_pedido int) RETURNS void LANGUAGE plpgsql AS $BODY$ BEGIN
DELETE FROM ITEMPEDIDO
WHERE codpedido = cod_pedido;
DELETE FROM PEDIDO
WHERE codpedido = cod_pedido;
END;
$BODY$;