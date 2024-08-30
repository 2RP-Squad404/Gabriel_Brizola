# Relatório do script

**Nome do Estagiário:** Gabriel Silva Brizola          
**Data:** 30/08/2024

## Introdução
Este relatório explica a criação de um script SQL que utiliza Common Table Expressions (CTEs) para gerar a tabela Campaign_Purchase, com dados de compras e campanhas de marketing. O objetivo é analisar o comportamento dos clientes, identificando locais de compra preferidos, campanhas mais efetivas, e a ocorrência de erros nas campanhas.

**CTE (Common Table Expression): É uma expressão temporária em SQL que permite criar uma tabela virtual que pode ser referenciada dentro de uma única consulta**

## 1º CTE
```SQL
WITH total_spent AS (
    SELECT 
        client_id, 
        ROUND(SUM(amount_price),2) AS total_price -- Somando total gasto por cada cliente
    FROM 
        purchase
    GROUP BY 
        client_id -- Agrupando por cliente
)
```
## 2º CTE
```SQL
most_purchase_location AS (
    SELECT 
        client_id,
        purchase_location,
        ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY COUNT(*) DESC) AS rank -- ROW_NUMBER() = Numera a saída de um conjunto de resultados. Numera todas as linhas em sequência (por exemplo 1, 2, 3, 4, 5), sendo 1 o qual mais apareceu.
        -- OVER = Determina o particionamento e a ordenação de um conjunto de linhas antes da aplicação da função de janela associada, você pode usar a cláusula OVER com funções para computar valores agregados como médias móveis, agregações cumulativas, somas acumuladas ou os primeiros N resultados por grupo, principais argumentos do OVER(PARTITION BY, ORDER BY, ROWS/RANGE).
        -- PARTITION BY = divide o conjunto de resultados da consulta em partições.
        -- ORDER BY = define a ordem lógica das linhas dentro de cada partição do conjunto de resultados.
    FROM 
        purchase
    GROUP BY 
        client_id, purchase_location -- Agrupando pelo local e pelo cliente.
)
```
## 3º CTE
```SQL
first_purchase_date AS (
    SELECT 
        client_id, 
        TO_DATE(MIN(purchase_datetime)) AS first_purchase -- Mudando TIMESTAMP para DATE e buscando as datas minimas.
    FROM 
        purchase
    GROUP BY 
        client_id
)
```
## 4º CTE 
```SQL
last_purchase_date AS (
    SELECT 
        client_id, 
        TO_DATE(MAX(purchase_datetime)) AS last_purchase -- Mudando TIMESTAMP para DATE e buscando as datas máximas.
    FROM 
        purchase
    GROUP BY 
        client_id
)

```
## 5º CTE
```SQL
campaign_counts AS (
    SELECT 
        client_id,
        type_campaign,
        COUNT(*) AS campaign_count -- Contando o total de campanhas enviadas para os clientes.
    FROM 
        campanhas
    WHERE 
        return_status = 'received' -- Onde o status é recebido(received).
    GROUP BY 
        client_id, type_campaign
)
```
## 6º CTE
```SQL
most_campaign AS (
    SELECT 
        client_id,
        type_campaign,
        campaign_count,
        ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY campaign_count DESC) AS rank -- Esse comando está criando um ranking (ou seja, numerando) as linhas dentro de grupos de clientes (client_id) e colocando em primeiro lugar a campanha com a maior contagem (campaign_count), ele dá o número 1 para a campanha com mais contagens de cada cliente, o número 2 para o próximo, e assim por diante.
    FROM 
        campaign_counts
)
```
## 7º CTE
```SQL
campaign_errors AS (
    SELECT 
        client_id,
        COUNT(*) AS quantity_error -- Conta a quantidade.
    FROM 
        campanhas
    WHERE 
        return_status = 'error' -- Onde o status retorna erro(error).
    GROUP BY 
        client_id
)
```
## 8º CTE
```SQL
date_today AS (
    SELECT 
        CURRENT_DATE AS date_today, -- Pegando a data da consulta realizada.
        CAST(DATE_FORMAT(CURRENT_DATE, 'yyyyMMdd') AS INT) AS anomes_today -- Transformando o tipo da data em INT.
    FROM 
        campanhas
    LIMIT 1
)
```
## Inserindo dados na tabela
```SQL
INSERT INTO Campaign_Purchase
SELECT -- Selecionando as colunas que vou querer povoar a tabela Campaign_Purchase
    total_spent.client_id,
    total_spent.total_price,
    most_purchase_location.purchase_location,
    first_purchase_date.first_purchase,
    last_purchase_date.last_purchase,
    most_campaign.type_campaign,
    campaign_errors.quantity_error,
    date_today.date_today,
    date_today.anomes_today
FROM 
    total_spent
JOIN -- Juntando a tabela most_purchase_location e a tabela total_spent onde o client_id for igual
    most_purchase_location
ON total_spent.client_id = most_purchase_location.client_id AND most_purchase_location.rank = 1
JOIN -- Juntando a tabela first_purchase_date e a tabela total_spent onde o client_id for igual
    first_purchase_date 
ON total_spent.client_id = first_purchase_date.client_id
JOIN -- Juntando a tabela last_purchase_date e a tabela total_spent onde o client_id for igual
    last_purchase_date 
ON total_spent.client_id = last_purchase_date.client_id
JOIN -- Juntando a tabela most_campaign e a tabela total_spent onde o client_id for igual
    most_campaign 
ON total_spent.client_id = most_campaign.client_id AND most_campaign.rank = 1
JOIN -- Juntando a tabela campaign_errors e a tabela total_spent onde o client_id for igual
    campaign_errors 
ON total_spent.client_id = campaign_errors.client_id
JOIN -- Juntando a tabela date_today e a tabela total_spent onde o client_id for igual
    date_today
```