-- -- 1. Write a query to calculate the total kilometers traveled, fuel consumption, and pas-
-- sengers per bus, grouped by year, month, and day.

SELECT 
    b.bus_model,
    EXTRACT(YEAR FROM t.trip_date) AS year,
    EXTRACT(MONTH FROM t.trip_date) AS month,
    EXTRACT(DAY FROM t.trip_date) AS day,
    SUM(t.kilometers_traveled) AS total_kilometers,
    SUM(t.fuel_consumption) AS total_fuel_consumption,
    SUM(t.passengers_count) AS total_passengers
FROM 
    trip t
JOIN 
    bus b ON t.bus_id = b.bus_id
GROUP BY 
    b.bus_model, 
    EXTRACT(YEAR FROM t.trip_date), 
    EXTRACT(MONTH FROM t.trip_date), 
    EXTRACT(DAY FROM t.trip_date);


-- 2. Use the ROLLUP function to calculate subtotals and grand totals for kilometers trav-
-- eled, fuel consumption, and passengers, grouped by bus model, year, and month.

SELECT 
    b.bus_model,
    EXTRACT(YEAR FROM t.trip_date) AS year,
    EXTRACT(MONTH FROM t.trip_date) AS month,
    SUM(t.kilometers_traveled) AS total_kilometers,
    SUM(t.fuel_consumption) AS total_fuel_consumption,
    SUM(t.passengers_count) AS total_passengers
FROM 
    trip t
JOIN 
    bus b ON t.bus_id = b.bus_id
GROUP BY 
    ROLLUP (b.bus_model, EXTRACT(YEAR FROM t.trip_date), EXTRACT(MONTH FROM t.trip_date));


-- 3. Use the CUBE function to generate all possible combinations of subtotals for kilometers
-- traveled, fuel consumption, and passengers, grouped by bus model, depot, and year.
SELECT 
    b.bus_model,
    d.depot_name,
    EXTRACT(YEAR FROM t.trip_date) AS year,
    SUM(t.kilometers_traveled) AS total_kilometers,
    SUM(t.fuel_consumption) AS total_fuel_consumption,
    SUM(t.passengers_count) AS total_passengers
FROM 
    trip t
JOIN 
    bus b ON t.bus_id = b.bus_id
JOIN 
    depot d ON t.depot_id = d.depot_id
GROUP BY 
    CUBE (b.bus_model, d.depot_name, EXTRACT(YEAR FROM t.trip_date));


-- 4. Use the GROUPING function to distinguish between detailed rows and subtotal rows
-- in a ROLLUP query for bus model, year, and month.

SELECT 
    b.bus_model,
    EXTRACT(YEAR FROM t.trip_date) AS year,
    EXTRACT(MONTH FROM t.trip_date) AS month,
    SUM(t.kilometers_traveled) AS total_kilometers,
    SUM(t.fuel_consumption) AS total_fuel_consumption,
    SUM(t.passengers_count) AS total_passengers,
    GROUPING(b.bus_model) AS is_bus_model_total,
    GROUPING(EXTRACT(YEAR FROM t.trip_date)) AS is_year_total,
    GROUPING(EXTRACT(MONTH FROM t.trip_date)) AS is_month_total
FROM 
    trip t
JOIN 
    bus b ON t.bus_id = b.bus_id
GROUP BY 
    ROLLUP (b.bus_model, EXTRACT(YEAR FROM t.trip_date), EXTRACT(MONTH FROM t.trip_date));


-- 5. Calculate the total kilometers traveled, fuel consumption, and passengers, grouped
-- by bus model, depot, and year.

SELECT 
    b.bus_model,
    d.depot_name,
    EXTRACT(YEAR FROM t.trip_date) AS year,
    SUM(t.kilometers_traveled) AS total_kilometers,
    SUM(t.fuel_consumption) AS total_fuel_consumption,
    SUM(t.passengers_count) AS total_passengers
FROM 
    trip t
JOIN 
    bus b ON t.bus_id = b.bus_id
JOIN 
    depot d ON t.depot_id = d.depot_id
GROUP BY 
    b.bus_model, d.depot_name, EXTRACT(YEAR FROM t.trip_date);
