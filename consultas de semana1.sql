LOAD DATA LOCAL INFILE 'C:/Users/Viviney/Downloads/Global_Superstore_clean.csv'
INTO TABLE ventas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Category, City, Country, `Customer ID`, `Customer Name`, Discount, Market,
 `Order ID`, `Order Priority`, `Product ID`, `Product Name`, Profit, Quantity,
 Region, `Row ID`, Sales, Segment, `Ship Mode`, `Shipping Cost`, State,
 `Sub-Category`, Year, Market2, weeknum);
 
 
 SELECT 
    Category,
    ROUND(SUM(Sales), 2) AS ventas_totales,
    ROUND(SUM(Profit), 2) AS ganancia_total,
    ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS margen_porcentaje
FROM ventas
GROUP BY Category
ORDER BY ventas_totales DESC;

SELECT 
    Region,
    Market,
    ROUND(SUM(Sales), 2) AS ventas_totales,
    ROUND(SUM(Profit), 2) AS ganancia_total
FROM ventas
GROUP BY Region, Market
HAVING SUM(Profit) < 0
ORDER BY ganancia_total ASC;


SELECT * FROM ventas
INTO OUTFILE 'ventas_export.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SHOW VARIABLES LIKE 'secure_file_priv';

SELECT * FROM ventas
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 9.6/Uploads/ventas_export.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


SELECT * FROM ventas
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 9.6/Uploads/ventas_v2.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';