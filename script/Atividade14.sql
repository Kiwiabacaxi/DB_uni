/* Atividade 14
 @Aluno: Carlos Alexandre Sousa Silva
 */
-- Escreva uma consulta para exibir as ofertas e os compradores que estão acima da média de preços.
SELECT vl_oferta,
    cd_comprador
FROM oferta
WHERE vl_oferta > (
        SELECT AVG(vl_oferta)
        FROM oferta
    );
-- Escreva uma consulta para exibir o nome do comprador e a oferta de compra das 3 maiores ofertas de compra em ordem decrescente.
SELECT nm_comprador,
    vl_oferta
FROM comprador
    NATURAL JOIN oferta
ORDER BY vl_oferta DESC
LIMIT 3;
-- Escreva uma consulta com todos os compradores e os seus respectivos lances e os endereços dos imóveis.
SELECT nm_comprador,
    vl_oferta,
    rua
FROM comprador
    NATURAL JOIN oferta
    NATURAL JOIN imoveis;
-- Escreva uma consulta com o nome dos compradores, os endereços dos imóveis e somente os lances maiores que a média de lances.
SELECT nm_comprador,
    vl_oferta,
    rua
FROM comprador
    NATURAL JOIN oferta
    NATURAL JOIN imoveis
WHERE vl_oferta > (
        SELECT AVG(vl_oferta)
        FROM oferta
    )
ORDER BY vl_oferta DESC;
-- Escreva uma consulta que exiba os nomes dos vendedores com os imóveis.
SELECT DISTINCT nm_vendedor
FROM vendedor
    NATURAL JOIN imoveis
WHERE EXISTS (
        SELECT *
        FROM imoveis
    );
-- Escreva uma consulta que exiba os nomes dos vendedores com o código do imóvel, os lances e os nomes dos compradores.
SELECT v.nm_vendedor,
    i.cd_imovel,
    o.vl_oferta,
    comp.nm_comprador
FROM vendedor v
    INNER JOIN imoveis i ON v.cd_vendedor = i.cd_vendedor
    INNER JOIN oferta o ON i.cd_imovel = o.cd_imovel
    INNER JOIN comprador comp ON o.cd_comprador = comp.cd_comprador;
-- Faça uma consulta para encontrar algum imóvel com endereço que tenha o nome “pedro”.
SELECT *
FROM imoveis
WHERE rua LIKE '%PEDRO%';
-- Faça uma consulta para imprimir todos os compradores que tenham a letra “M” no começo do nome.
SELECT nm_comprador
FROM comprador
WHERE nm_comprador LIKE 'M%';
-- Faça uma consulta que exiba o código do imóvel, o código do comprador, o nome do comprador, o valor da oferta e a data da oferta em formato do Brasil, ordenado pelo nome do comprador decrescente.
SELECT o.cd_imovel,
    o.cd_comprador,
    comp.nm_comprador,
    o.vl_oferta,
    TO_CHAR(o.data_oferta, 'DD/MM/YYYY') AS data_oferta_brasil
FROM oferta o
    INNER JOIN comprador comp ON o.cd_comprador = comp.cd_comprador
ORDER BY comp.nm_comprador DESC;
-- Faça uma consulta que retorne a soma, a media de todos os valores ofertados, o valor máximo e o valor mínimo ofertado para compra dos imóveis.
SELECT SUM(vl_oferta) AS soma_ofertas,
    AVG(vl_oferta) AS media_ofertas,
    MAX(vl_oferta) AS max_oferta,
    MIN(vl_oferta) AS min_oferta
FROM oferta;
-- Faça uma lista de imóveis do mesmo bairro do imóvel 2. Exclua o imóvel 2 da sua busca.
SELECT *
FROM imoveis
WHERE cd_bairro = (
        SELECT cd_bairro
        FROM imoveis
        WHERE cd_imovel = 2
    )
    AND cd_imovel != 2;
-- Faça uma lista que mostre todos os imóveis que custam mais que a média de preço dos imóveis.
SELECT *
FROM imoveis
WHERE CAST(v_preco AS INTEGER) > (
        SELECT AVG(CAST(v_preco AS INTEGER))
        FROM imoveis
    );
-- Faça uma lista com todos os compradores que tenham ofertas cadastradas com valor superior a 70 mil.
SELECT DISTINCT comprador.*
FROM comprador
    NATURAL JOIN oferta
WHERE vl_oferta > 70000;
-- Faça uma lista com todos os imóveis com oferta superior à média do valor das ofertas.
SELECT DISTINCT imoveis.*
FROM imoveis
    JOIN oferta ON imoveis.cd_imovel = oferta.cd_imovel
WHERE vl_oferta > (
        SELECT AVG(vl_oferta)
        FROM oferta
    );
-- Faça uma lista com todos os imóveis com preço superior à media de preço dos imóveis do bairro.
SELECT DISTINCT imoveis.*
FROM imoveis
    JOIN oferta ON imoveis.cd_imovel = oferta.cd_imovel
WHERE CAST(v_preco AS INTEGER) > (
        SELECT AVG(CAST(v_preco AS INTEGER))
        FROM imoveis
        WHERE cd_bairro = imoveis.cd_bairro
    );
-- Faça uma lista dos imóveis com maior preço agrupado por bairro, cujo maior preço seja superior à media de preços dos imóveis.
SELECT cd_bairro,
    MAX(CAST(v_preco AS INTEGER)) AS maior_preco
FROM imoveis
GROUP BY cd_bairro
HAVING MAX(CAST(v_preco AS INTEGER)) > (
        SELECT AVG(CAST(v_preco AS INTEGER))
        FROM imoveis
    )
ORDER BY cd_bairro;
-- Faça uma lista com os imóveis que têm preço igual ao menor preço de cada vendedor.
SELECT i.*
FROM imoveis i
    JOIN (
        SELECT cd_vendedor,
            MIN(CAST(v_preco AS INTEGER)) AS menor_preco
        FROM imoveis
        GROUP BY cd_vendedor
    ) min_preco ON i.cd_vendedor = min_preco.cd_vendedor
WHERE CAST(i.v_preco AS INTEGER) = min_preco.menor_preco;
-- Faça uma lista com as ofertas dos imóveis com data de lançamento do imóvel inferior a 30 dias e superior a 180 dias, a contar de hoje e cujo código vendedor seja 2.
SELECT o.*
FROM oferta o
    JOIN imoveis i ON o.cd_imovel = i.cd_imovel
WHERE i.dt_lancamento BETWEEN CURRENT_DATE - INTERVAL '180 DAYS'
    AND CURRENT_DATE - INTERVAL '30 DAYS'
    AND i.cd_vendedor = 2;
-- Faça uma lista com as ofertas dos imóveis que têm o preço igual ao menor preço de todos os vendedores, exceto as ofertas do próprio comprador.
SELECT o.*
FROM oferta o
    JOIN imoveis i ON o.cd_imovel = i.cd_imovel
    JOIN vendedor v ON i.cd_vendedor = v.cd_vendedor
    JOIN (
        SELECT cd_vendedor,
            MIN(CAST(v_preco AS INTEGER)) AS menor_preco
        FROM imoveis
        GROUP BY cd_vendedor
    ) min_preco ON i.cd_vendedor = min_preco.cd_vendedor
WHERE o.vl_oferta = min_preco.menor_preco
    AND o.cd_comprador <> i.cd_vendedor;
-- Faça uma lista com ofertas menores que todas as ofertas do comprador 2, exceto as ofertas do próprio comprador.
SELECT o.*
FROM oferta o
    INNER JOIN comprador comp ON o.cd_comprador = comp.cd_comprador
WHERE CAST(o.vl_oferta AS INTEGER) < ALL (
        SELECT vl_oferta
        FROM oferta
        WHERE cd_comprador = 2
            AND cd_imovel != o.cd_imovel
    );
-- Faça uma lista do todos os imóveis cujo Estado e cidade sejam os mesmos do vendedor 3, exceto os imóveis do vendedor 3.
SELECT *
FROM imoveis
WHERE sg_estado = (
        SELECT sg_estado
        FROM vendedor
        WHERE cd_vendedor = 3
    )
    AND cd_cidade = (
        SELECT cd_cidade
        FROM vendedor
        WHERE cd_vendedor = 3
    )
    AND cd_vendedor != 3;
-- Faça uma lista de todos os imóveis cujo Estado e cidade sejam do mesmo Estado, cidade e bairro do imóvel código 5.
SELECT *
FROM imoveis
WHERE sg_estado = (
        SELECT sg_estado
        FROM imoveis
        WHERE cd_imovel = 5
    )
    AND cd_cidade = (
        SELECT cd_cidade
        FROM imoveis
        WHERE cd_imovel = 5
    )
    AND cd_bairro = (
        SELECT cd_bairro
        FROM imoveis
        WHERE cd_imovel = 5
    );