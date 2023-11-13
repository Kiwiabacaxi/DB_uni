-- 10 - Faça uma consulta que apresente o nome do cliente e todas as suas compras (valor total das notas de compras) realizadas nos últimos 30 dias;
SELECT C.nome AS "Nome do Cliente",
    SUM(P.valortotal) AS "Valor Total das Compras"
FROM CLIENTE C
    INNER JOIN PEDIDO P ON C.codcliente = P.codcliente
WHERE P.datapedido BETWEEN (CURRENT_DATE - INTERVAL '30 DAYS')
    AND CURRENT_DATE
GROUP BY C.nome
ORDER BY "Valor Total das Compras" DESC;
-- aa
SELECT C.nome AS "Nome do Cliente",
    SUM(P.valor) AS "Valor Total das Compras"
FROM CLIENTE C
    JOIN PEDIDO P ON C.codcliente = P.codcliente
WHERE P.datacompra >= NOW() - INTERVAL '30 days'
GROUP BY C.nome;