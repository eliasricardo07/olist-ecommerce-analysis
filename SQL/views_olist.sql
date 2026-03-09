CREATE VIEW analytics.vw_geral_vendas AS
SELECT
    f.price as valor,
    f.freight_value as valor_frete,
    c.customer_state AS estado_cliente,
    p.product_category_name AS categoria,
    s.seller_state AS estado_vendedor,
    d.ano,
    d.mes,
    d.nome_mes
FROM analytics.fact_order_items f
JOIN analytics.dim_clientes c ON f.cliente_sk = c.cliente_sk
JOIN analytics.dim_produtos p ON f.produtos_sk = p.produtos_sk
JOIN analytics.dim_vendedores s ON f.vendedores_sk = s.vendedores_sk
JOIN analytics.dim_data d ON f.data_sk = d.data_sk;

CREATE VIEW analytics.vw_vendas_categoria AS
SELECT
    p.product_category_name,
    COUNT(*) AS qtd_vendas,
    SUM(f.price) AS receita_total,
    AVG(f.price) AS ticket_medio,
    SUM(f.freight_value) AS frete_total
FROM analytics.fact_order_items f
JOIN analytics.dim_produtos p ON f.produtos_sk = p.produtos_sk
GROUP BY p.product_category_name;

CREATE VIEW analytics.vw_analise_geografica AS
SELECT
    c.customer_state,
    c.customer_city,
    COUNT(DISTINCT f.cliente_sk) AS qtd_clientes,
    SUM(f.price) AS receita,
    AVG(f.price) AS ticket_medio
FROM analytics.fact_order_items f
JOIN analytics.dim_clientes c ON f.cliente_sk = c.cliente_sk
GROUP BY c.customer_state, c.customer_city;

CREATE VIEW analytics.vw_vendas_tempo AS
SELECT
    d.ano,
    d.mes,
    d.nome_mes,
    d.trimestre,
    COUNT(*) AS qtd_vendas,
    SUM(f.price) AS receita
FROM analytics.fact_order_items f
JOIN analytics.dim_data d ON f.data_sk = d.data_sk
GROUP BY d.ano, d.mes, d.nome_mes, d.trimestre;

select * from analytics.dim_data dd ;