#Q3

SELECT 
	COUNT("VendorID") AS Trips
FROM tripdata_2025
WHERE TO_CHAR(lpep_pickup_datetime, 'YYYY-MM') = '2025-11'
	AND trip_distance <= 1.00;

#Q4

SELECT 
    lpep_pickup_datetime
FROM tripdata_2025
WHERE trip_distance::double precision = (
    SELECT MAX(trip_distance::double precision) 
    FROM tripdata_2025 
    WHERE trip_distance::double precision < 100
);

#Q5

SELECT
	zones.zone AS zone,
	COUNT(trip."VendorID") AS qntd
FROM taxi_zone AS zones
JOIN tripdata_2025 AS trip ON trip."PULocationID" = zones.locationid
WHERE TO_CHAR(trip.lpep_pickup_datetime, 'YYYY-MM-DD') = '2025-11-18'
GROUP BY 1
ORDER BY qntd DESC
LIMIT 1;

#Q6

SELECT 
    z_dropoff."zone" AS dropoff_zone,
    MAX(t.tip_amount) AS largest_tip
FROM tripdata_2025 t
JOIN taxi_zone z_pickup ON t."PULocationID" = z_pickup."locationid"
JOIN taxi_zone z_dropoff ON t."DOLocationID" = z_dropoff."locationid"
WHERE 
    z_pickup."zone" = 'East Harlem North'
    AND t.lpep_pickup_datetime >= '2025-11-01 00:00:00'
    AND t.lpep_pickup_datetime < '2025-12-01 00:00:00'
GROUP BY z_dropoff."zone"
ORDER BY largest_tip DESC
LIMIT 1;
