-- INNER join orders,orderdetails,products and customers. Return back:
-- orderNumber
-- priceEach
-- quantityOrdered
-- productName
-- productLine
-- city
-- country
-- orderDate

USE classicmodels;

SELECT o.orderNumber, d.priceEach, d.quantityOrdered, p.productName, c.city, c.country, o.orderDate
	FROM orders o
		INNER JOIN customers c
			USING(customerNumber)
		INNER JOIN orderDetails d
			USING (orderNumber)
		INNER JOIN products p
			USING (productCode);


-- this solution also works but it involves more typing
SELECT orders.orderNumber, orderdetails.priceEach, orderdetails.quantityOrdered, products.productName, customers.city, customers.country, orderDate
	FROM orders
		INNER JOIN orderdetails ON
			orders.orderNumber = orderdetails.orderNumber
		INNER JOIN products ON
			orderdetails.productCode = products.productCode
		INNER JOIN customers ON
			customers.customerNumber = orders.customerNumber;