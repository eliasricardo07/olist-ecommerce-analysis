# 📊 Análise de Dados - E-commerce Brasileiro (Olist)

## 🎯 Objetivo do Projeto:
*Este projeto tem como objetivo analisar os dados de um e-commerce brasileiro(Olist) para entender padrões de vendas, comportamento dos clientes, desempenho de produtos e eficiência da operação de entregas, como também iriei utilizar como meio de aprendizado para aprimorar meus conhecimentos em Sql e o processo de analisar dados.*

---

## 🗂️ Fonte dos Dados:
[Dataset Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

---

## 🧠 Dicionário de Dados

| Tabela | Descrição |
|--------|-----------|
| **olist_customers_dataset** | Contém informações dos clientes, como ID, cidade e estado. Permite analisar o perfil geográfico dos compradores. |
| **olist_orders_dataset** | Tabela central do banco. Registra os pedidos realizados, datas de compra, aprovação, envio, entrega e status do pedido. |
| **olist_order_items_dataset** | Detalha os itens de cada pedido, ligando pedidos a produtos e vendedores. Permite calcular vendas por produto e por vendedor. |
| **olist_order_payments_dataset** | Informações sobre pagamentos, como valor pago, forma de pagamento e número de parcelas. Usada para métricas de receita e ticket médio. |
| **olist_order_reviews_dataset** | Avaliações feitas pelos clientes após a entrega do pedido, incluindo nota e comentários. Usada para análise de satisfação do cliente. |
| **olist_products_dataset** | Dados dos produtos vendidos, como categoria, peso e dimensões. |
| **olist_sellers_dataset** | Informações sobre os vendedores parceiros da plataforma, incluindo localização. |
| **product_category_name_translation** | Tabela de tradução das categorias de produtos do português para o inglês. |
| **olist_geolocation_dataset** | Dados de localização baseados em CEP, permitindo análises geográficas mais detalhadas. |

---

## 📈 Perguntas de Negócio

### 🛒 Vendas
- Qual estado do Brasil gera mais pedidos?
- Qual é o ticket médio por pedido?
- Qual mês apresentou maior volume de vendas?
- Qual é a receita total gerada?

### 📦 Produtos
- Quais produtos mais vendem?
- Quais categorias geram mais receita?
- Existem produtos com alto volume de venda mas baixa receita?

### 👥 Clientes
- De quais regiões vêm os clientes que mais compram?
- Existem estados com alto volume de pedidos mas baixa receita média?

### 🚚 Operação e Logística
- Qual é o tempo médio de entrega dos pedidos?
- Existe relação entre atraso na entrega e avaliação do cliente?

### ⭐ Satisfação do Cliente
- Qual a nota média das avaliações?
- Pedidos atrasados recebem avaliações piores?
- Existem vendedores com desempenho de avaliação abaixo da média?

---

## 🏗️ Estrutura do Projeto

1. Entendimento do problema de negócio  
2. Exploração e entendimento dos dados  
3. Análise com SQL  
4. Geração de insights  
5. Visualização dos resultados no Power BI  

---

## 🛠️ Tecnologias Utilizadas

- **PostgreSQL** – Armazenamento e manipulação dos dados  
- **DBeaver** – Interface de gerenciamento do banco  
- **SQL** – Linguagem de consulta e análise  
- **Power BI** – Visualização dos dados e construção do dashboard  

---

## 🔍 Metodologia da Análise

A análise foi conduzida a partir da tabela central **orders**, relacionando-a com clientes, produtos, pagamentos, avaliações e vendedores.

As consultas SQL foram construídas para:
- Calcular métricas de vendas  
- Avaliar comportamento dos clientes  
- Identificar desempenho de produtos  
- Medir eficiência de entregas  
- Analisar satisfação do cliente  

---

## 📊 Modelo de Relacionamento dos Dados

A estrutura do banco segue um modelo relacional centrado na tabela **orders**, que conecta clientes, produtos, vendedores, pagamentos e avaliações.

Essa modelagem permite análises integradas entre vendas, logística, comportamento do cliente e satisfação.

---

## 🧾 Informações Técnicas do Dataset

- Total de pedidos: ~100.000  
- Total de clientes: ~99.000  
- Total de produtos: ~32.000  
- Período dos dados: 2016–2018  

---

## 💻 Consultas SQL

As consultas utilizadas neste projeto estão disponíveis no arquivo:

📄 **sql_queries.sql**

Cada consulta possui comentários explicando:
- Objetivo da análise  
- Tabelas utilizadas  
- Lógica aplicada  

---

## 📊 Dashboard

Os resultados das análises foram transformados em visualizações interativas no Power BI.

📌 O dashboard apresenta:
- Visão geral de vendas  
- Desempenho por estado  
- Produtos e categorias  
- Avaliações de clientes  
- Indicadores de entrega  

![Dashboard](images/dashboard.png)

---

## 🔎 Principais Insights

(Esta seção será preenchida após a conclusão das análises.)

---

## 🎓 Aprendizados

Durante o desenvolvimento deste projeto, foram aplicados e aprimorados conhecimentos em:

- Modelagem de dados  
- Escrita de consultas SQL  
- Análise exploratória  
- Documentação de projetos de dados  
- Construção de dashboards  

---

## 🚀 Próximos Passos

- Criar métricas avançadas de retenção de clientes  
- Analisar comportamento de recompra  
- Avaliar impacto do tempo de entrega nas avaliações  
- Expandir a análise para segmentação de clientes  

---

## 📌 Observação
> Esta análise foi feita apenas para fins educacionais.
