CREATE TABLE Campaign_Purchase(
    client_id STRING,
    total_price DOUBLE,
    most_purchase_location STRING,
    first_purchase DATE,
    last_purchase DATE,
    most_campaign STRING,
    quantity_error INT,
    date_today DATE,
    anomes_today INT
)

WITH total_spent AS (
    SELECT 
        client_id, 
        ROUND(SUM(amount_price),2) AS total_price
    FROM 
        purchase
    GROUP BY 
        client_id
),
most_purchase_location AS (
    SELECT 
        client_id,
        purchase_location,
        ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY COUNT(*) DESC) AS rank
    FROM 
        purchase
    GROUP BY 
        client_id, purchase_location
),
first_purchase_date AS (
    SELECT 
        client_id, 
        TO_DATE(MIN(purchase_datetime)) AS first_purchase
    FROM 
        purchase
    GROUP BY 
        client_id
),
last_purchase_date AS (
    SELECT 
        client_id, 
        TO_DATE(MAX(purchase_datetime)) AS last_purchase
    FROM 
        purchase
    GROUP BY 
        client_id
),
campaign_counts AS (
    SELECT 
        client_id,
        type_campaign,
        COUNT(*) AS campaign_count
    FROM 
        campanhas
    WHERE 
        return_status = 'received'
    GROUP BY 
        client_id, type_campaign
),
most_campaign AS (
    SELECT 
        client_id,
        type_campaign,
        campaign_count,
        ROW_NUMBER() OVER (PARTITION BY client_id ORDER BY campaign_count DESC) AS rank
    FROM 
        campaign_counts
),
campaign_errors AS (
    SELECT 
        client_id,
        COUNT(*) AS quantity_error
    FROM 
        campanhas
    WHERE 
        return_status = 'error'
    GROUP BY 
        client_id
),
date_today AS (
    SELECT 
        CURRENT_DATE AS date_today,
        CAST(DATE_FORMAT(CURRENT_DATE, 'yyyyMMdd') AS INT) AS anomes_today
    FROM 
        campanhas
    LIMIT 1
)

INSERT INTO Campaign_Purchase
SELECT 
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
JOIN 
    most_purchase_location 
ON total_spent.client_id = most_purchase_location.client_id AND most_purchase_location.rank = 1
JOIN 
    first_purchase_date 
ON total_spent.client_id = first_purchase_date.client_id
JOIN 
    last_purchase_date 
ON total_spent.client_id = last_purchase_date.client_id
JOIN 
    most_campaign 
ON total_spent.client_id = most_campaign.client_id AND most_campaign.rank = 1
JOIN 
    campaign_errors 
ON total_spent.client_id = campaign_errors.client_id
JOIN 
    date_today