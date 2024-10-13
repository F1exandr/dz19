SELECT * FROM orders WHERE ship_country LIKE 'U%'; -- 1
SELECT order_id, customer_id, freight, ship_country
FROM orders
WHERE ship_country LIKE 'N%'
ORDER BY freight DESC
LIMIT 10; -- 2
SELECT first_name, last_name, home_phone, region
FROM employees
WHERE region IS NULL; -- 3
SELECT COUNT(*)
FROM customers
WHERE region IS NOT NULL; -- 4
SELECT country, COUNT(*)
FROM suppliers
GROUP BY country
ORDER BY COUNT(*) DESC; -- 5
SELECT ship_country, SUM(freight) AS total_freight
FROM orders
WHERE ship_region IS NOT NULL
GROUP BY ship_country
HAVING SUM(freight) > 2750
ORDER BY total_freight DESC; -- 6
SELECT DISTINCT country
FROM (
  SELECT country FROM customers
  UNION
  SELECT country FROM suppliers
)
ORDER BY country ASC; -- 7
SELECT country
FROM (
  SELECT country FROM customers
  INTERSECT
  SELECT country FROM suppliers
  INTERSECT
  SELECT country FROM employees
  ); -- 8
SELECT country
FROM (
  SELECT country FROM customers
  INTERSECT
  SELECT country FROM suppliers
  EXCEPT
  SELECT country FROM employees
); -- 9
SELECT c.company_name, e.first_name, e.last_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN employees e ON o.employee_id = e.employee_id
WHERE c.city = 'London' AND e.city = 'London' AND o.ship_via = 1; -- 10
SELECT p.product_name, p.units_in_stock, s.company_name, s.phone
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE p.discontinued = 0 AND p.category_id IN (1, 8) AND p.units_in_stock < 20; -- 11
SELECT c.company_name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL; -- 12
SELECT c.company_name, o.order_id
FROM orders o
RIGHT JOIN customers c ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL; -- 13