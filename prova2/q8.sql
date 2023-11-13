-- 8 - Consultar a quantidade de compras realizadas por cada cliente
SELECT c.codcliente,
    c.nome,
    COUNT(p.codpedido) AS quantidade_de_vendas
FROM CLIENTE c
    LEFT JOIN PEDIDO p ON c.codcliente = p.codcliente
GROUP BY c.codcliente,
    c.nome
ORDER BY c.codcliente;
--  sintaxe bonitinha
SELECT c.codcliente,
    c.nome,
    COUNT(p.codpedido) AS quantidade_de_vendas
FROM CLIENTE c
    LEFT JOIN PEDIDO p ON c.codcliente = p.codcliente
GROUP BY c.codcliente,
    c.nome
ORDER BY c.codcliente;