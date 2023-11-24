select count(order_id) from orders;
select * from orders;
SELECT 
    order_status, 
    COUNT(*) AS status_count
FROM 
    orders
WHERE 
    order_status IN ('delivered', 'cancelled', 'unavailable', 'other_status')
GROUP BY 
    order_status;
    
SELECT
    YEAR(order_purchase_timestamp) AS order_year,
    MONTH(order_purchase_timestamp) AS order_month,
    COUNT(*) AS order_id
FROM
    orders
GROUP BY
    order_year, ordsellersproduct_category_name_translationproduct_category_nameer_month
ORDER BY
    order_year, order_month;
    
SELECT COUNT(DISTINCT product_id) AS num_unique_products
FROM products;
#percentage of total items in the different category
SELECT 
    product_category_name,
    COUNT(*) AS num_products,
    round((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM products)), 2) AS percentage
FROM 
    products
GROUP BY 
    product_category_name
ORDER BY 
    num_products DESC;
    
    
SELECT COUNT(DISTINCT p.product_id) AS num_products_in_orders
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id;

  #max and min price  
    SELECT
    MAX(price) AS max_price,
    MIN(price) AS min_price
FROM
    order_items;
#total of items in portfolio
SELECT 
    COUNT(*) AS num_products from products;
    
  #  total average days for delivery
    SELECT (SUM(DATEDIFF(order_delivered_customer_date , order_purchase_timestamp))/COUNT(order_id)) AS 'average days' FROM orders
;

#total of the tech product
select COUNT(*) AS tech_product_count,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM sales)), 2) AS percentage_sold
FROM
    order_items
    join products using(product_id)
WHERE
    product_category_name IN ('audio', 'electronicos', 'pc_gamer', 'telefonia', 'informatica_acessorios');
    
#the sum of the items according to the category
SELECT 
    COUNT(o.product_id)
FROM
    order_items AS o
        LEFT JOIN
    products AS p USING (product_id)
        LEFT JOIN
    product_category_name_translation AS pt USING (product_category_name)
WHERE
    pt.product_category_name_english IN ('audio' , 'auto',
        'cds_dvds_musicals',
        'computers',
        'computers_accessories',
        'consoles_games',
        'dvds_blu_ray',
        'electronics',
        'fixed_telephony',
        'pc_gamer',
        'signaling_and_security',
        'tablets_printing_image',
        'telephony');
        
 # to sort product according to their size     
SELECT COUNT(product_id),
CASE
WHEN (product_length_cm * product_height_cm * product_width_cm) > 18000 THEN 'Big size'
WHEN (product_length_cm * product_height_cm * product_width_cm) BETWEEN 10000 AND 18000 THEN 'Medium size'
WHEN (product_length_cm * product_height_cm * product_width_cm) < 10000 THEN 'Small size'
END AS 'Product size'
FROM products
GROUP BY `Product size`;