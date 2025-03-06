-- 2. Write a SQL query using ROLLUP to calculate the total sales amount by region and
-- category, including subtotals for each region.
SELECT 
    r.region_name,
    p.category,
    SUM(s.total_amount) AS total_sales_amount
FROM sales s
JOIN regions r ON s.region_id = r.region_id
JOIN products p ON s.product_id = p.product_id
GROUP BY ROLLUP (r.region_name, p.category)
ORDER BY r.region_name NULLS LAST, p.category NULLS LAST;

-- 3. Write a SQL query using CUBE to calculate sales quantity across regions and product
-- categories, generating all possible combinations of subtotals.

SELECT 
    r.region_name,
    p.category,
    SUM(s.quantity) AS total_quantity
FROM sales s
JOIN regions r ON s.region_id = r.region_id
JOIN products p ON s.product_id = p.product_id
GROUP BY CUBE (r.region_name, p.category)
ORDER BY r.region_name NULLS LAST, p.category NULLS LAST;
