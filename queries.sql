-- Task 1
SELECT
    od.*,
    (
        SELECT o.customer_id
        FROM orders AS o
        WHERE o.id = od.order_id
    ) AS customer_id
FROM order_details AS od;

-- Task 2
SELECT *
FROM order_details
WHERE order_id IN (
    SELECT id
    FROM orders
    WHERE shipper_id = 3
);

-- Task 3
SELECT
    order_id,
    AVG(quantity) AS avg_quantity
FROM (
    SELECT *
    FROM order_details
    WHERE quantity > 10
) AS temp
GROUP BY order_id;

-- Task 4
WITH temp AS (
    SELECT *
    FROM order_details
    WHERE quantity > 10
)
SELECT
    order_id,
    AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;

-- Task 5
DROP FUNCTION IF EXISTS divide_numbers;

DELIMITER //

CREATE FUNCTION divide_numbers(
    first_number FLOAT,
    second_number FLOAT
)
RETURNS FLOAT
DETERMINISTIC
NO SQL
BEGIN
    DECLARE result FLOAT;

    SET result = first_number / second_number;

    RETURN result;
END //

DELIMITER ;

SELECT
    quantity,
    divide_numbers(quantity, 2) AS divided_quantity
FROM order_details;
