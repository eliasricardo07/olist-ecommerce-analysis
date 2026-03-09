CREATE TABLE analytics.dim_clientes AS
SELECT distinct  --utilizei para evitar repetições de consumidores--
    customer_id,
    customer_city,
    customer_state
FROM olist_customers_dataset;

SELECT COUNT(*) FROM analytics.dim_clientes;
99.441

create table analytics.dim_produtos as
select distinct
product_id,
product_category_name,
product_name_lenght,
product_description_lenght,
product_photos_qty,
product_weight_g,
product_length_cm,
product_height_cm,
product_width_cm
from olist_products_dataset;

SELECT COUNT(*) FROM analytics.dim_produtos dp ;
32.951

--agora vamo dar uma analisada se existe algum registro em branco--
SELECT COUNT(*) 
FROM analytics.dim_produtos dp 
WHERE dp.product_category_name is null ;

create table analytics.dim_vendedores as
select distinct
seller_id,
seller_city,
seller_state
from olist_sellers_dataset;

select count (*) from analytics.dim_vendedores dv ;
3.095

SELECT COUNT(*) FROM olist_order_items_dataset;
112.650 -- aqui podemos perceber que existe pedidos com mais de um item comprado--
SELECT COUNT(*) from olist_orders_dataset ;
99.441

SELECT COUNT(*)
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id;
--aqui quando bateu o mesmo numero de linhas, signifca que consegui fazer isso -> 1 linha = 1 produto dentro pedido	

CREATE TABLE analytics.fact_order_items as --crei uma tabela fato--
SELECT
    oi.order_id,
    o.customer_id,
    oi.product_id,
    oi.seller_id,
    o.order_purchase_timestamp,
    o.order_status,
    oi.price,
    oi.freight_value
FROM olist_order_items_dataset oi
JOIN olist_orders_dataset o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered';
-- aqui coloquei essa condição pois existem registro de pedidos que não foram concluidos, ou seja, vamos trabalhar somente com os pedidos que geraram receita--

SELECT COUNT(*) FROM analytics.fact_order_items;
110.197 -- Total de itens vendidos em pedidos com status 'delivered' = 'concluido' --

select count(*) 
from public.olist_orders_dataset ood 
where order_status <> 'delivered';
-- aqui temos a quantidade de pedidos nao concluidos -> 2.963--

SELECT DISTINCT
    DATE(order_purchase_timestamp) AS data
FROM analytics.fact_order_items
ORDER BY data;

CREATE TABLE analytics.dim_data AS
SELECT DISTINCT
    DATE(order_purchase_timestamp) AS data,
    EXTRACT(YEAR FROM order_purchase_timestamp) AS ano,
    EXTRACT(MONTH FROM order_purchase_timestamp) AS mes,
    TRIM(TO_CHAR(order_purchase_timestamp, 'Month')) AS nome_mes,
    EXTRACT(QUARTER FROM order_purchase_timestamp) AS trimestre,
    EXTRACT(DOW FROM order_purchase_timestamp) AS dia_semana_num
FROM analytics.fact_order_items;

select * from analytics.fact_order_items foi ;

SELECT * 
FROM analytics.dim_clientes dc
LIMIT 5;

-- bom, aqui eu pedi pro chat ir me instruindo pois queria fazer um projeto bem sólido e forte pro meu portfolio,
-- então ele me indicou aprender a aplicar uma modelagem mais avançada autilizando 'ROW_NUMBER() OVER ()' básicamente criar uma coluna enumerada pra ficar mais ogrnizada--

ALTER TABLE analytics.dim_clientes ADD COLUMN cliente_sk SERIAL PRIMARY KEY;
ALTER TABLE analytics.dim_produtos ADD COLUMN produtos_sk SERIAL PRIMARY KEY;
ALTER TABLE analytics.dim_vendedores ADD COLUMN vendedores_sk SERIAL PRIMARY KEY;
ALTER TABLE analytics.dim_data ADD COLUMN data_sk SERIAL PRIMARY KEY;


--agora vou reformular minha tabela-fato pra ligar somente as surrogate keys--

CREATE TABLE analytics.fact_order_items_dw AS
SELECT
    c.cliente_sk,
    p.produtos_sk,
    s.vendedores_sk,
    d.data_sk,
    f.price,
    f.freight_value
FROM analytics.fact_order_items f
JOIN analytics.dim_clientes c
    ON f.customer_id = c.customer_id
JOIN analytics.dim_produtos p
    ON f.product_id = p.product_id
JOIN analytics.dim_vendedores s
    ON f.seller_id = s.seller_id
JOIN analytics.dim_data d
    ON DATE(f.order_purchase_timestamp) = d.data;

drop table analytics.fact_order_items ; --apagando a tabela fato antiga--

ALTER TABLE analytics.fact_order_items_dw --DEIXAMOS COM O MESMO NOME DA ANTERIOR--
RENAME TO fact_order_items;


select count(*) from analytics.dim_clientes dc ; --validando se as dimensões estão corretas--
99.441
SELECT COUNT(*) FROM analytics.dim_produtos;
32.951
SELECT COUNT(*) FROM analytics.dim_vendedores;
3.095
SELECT COUNT(*) FROM analytics.dim_data;
612

--VALIDAR SE A FATO ESTÁ CORRETA--

SELECT COUNT(*) FROM analytics.fact_order_items;

-- checar se existe algum NULL nas surrogate keys
SELECT *
FROM analytics.fact_order_items
WHERE cliente_sk IS NULL
   OR produtos_sk IS NULL
   OR vendedores_sk IS NULL
   OR data_sk IS NULL;


select * from analytics.fact_order_items foi ;
--aqui eu olhei minha tabela fato e percebi que não tem as colunas de tempo, que eu ia precisar no dashboard de logísitica
--então pensei em recriar a tabela fato já que seria mais rápido e leve do que usar um update

--ai eu lembrei que tem uma forma melhor, já que tem outras colunas ligadas na minha fato--
CREATE TABLE analytics.fact_order_items_v2 AS
SELECT
    c.cliente_sk,
    p.produtos_sk,
    s.vendedores_sk,
    d.data_sk,
    oi.price,
    oi.freight_value,
    
    -- Trazendo as datas de logística originais
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    
    -- Calculando o Tempo de Entrega (Dias) com proteção contra texto vazio
    DATE(NULLIF(o.order_delivered_customer_date, '')) - DATE(NULLIF(o.order_purchase_timestamp, '')) AS tempo_entrega_dias,
    
    -- Calculando o Status de Atraso com proteção contra texto vazio
    CASE 
        WHEN DATE(NULLIF(o.order_delivered_customer_date, '')) > DATE(NULLIF(o.order_estimated_delivery_date, '')) THEN 'Atrasado'
        WHEN NULLIF(o.order_delivered_customer_date, '') IS NULL THEN 'Não Entregue'
        ELSE 'No Prazo'
    END AS status_entrega

-- Lendo direto das tabelas originais do Olist
FROM public.olist_order_items_dataset oi
JOIN public.olist_orders_dataset o 
    ON oi.order_id = o.order_id

-- Cruzando com as suas tabelas Dimensão
JOIN analytics.dim_clientes c
    ON o.customer_id = c.customer_id
JOIN analytics.dim_produtos p
    ON oi.product_id = p.product_id
JOIN analytics.dim_vendedores s
    ON oi.seller_id = s.seller_id
JOIN analytics.dim_data d
    ON DATE(NULLIF(o.order_purchase_timestamp, '')) = d.data

-- Trazendo só os pedidos concluídos que geraram receita
WHERE o.order_status = 'delivered';


DROP TABLE analytics.fact_order_items cascade ;

ALTER TABLE analytics.fact_order_items_v2 RENAME TO fact_order_items;
