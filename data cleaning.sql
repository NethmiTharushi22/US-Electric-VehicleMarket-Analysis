--Verify the Import
SELECT *
FROM vehicle_fuel
LIMIT 10;

--check the row count
SELECT COUNT(*) as Table_row_count
FROM vehicle_fuel

--Check for Missing values 
SELECT *
FROM vehicle_fuel
WHERE
state IS NULL
OR electric_ev IS NULL
OR phev IS NULL
OR hev IS NULL
OR gasoline IS NULL
OR diesel IS NULL;

--check for Duplicates 
SELECT state, COUNT(*) FROM vehicle_fuel
GROUP BY state
HAVING COUNT(*) > 1;

--check negative values
SELECT *
FROM vehicle_fuel
WHERE electric_ev < 0
   OR phev < 0
   OR hev < 0
   OR gasoline < 0
   OR diesel < 0;
--standerize the state names 
SELECT DISTINCT state
FROM vehicle_fuel
ORDER BY state;

UPDATE vehicle_fuel
SET state = TRIM(state);

SELECT state  FROM vehicle_fuel

-- summary statistics
SELECT
    MIN(electric_ev) AS min_ev,
    MAX(electric_ev) AS max_ev,
    AVG(electric_ev) AS avg_ev
FROM vehicle_fuel;


--total vehicles 
SELECT
SUM(
electric_ev +
phev +
hev +
biodiesel +
ethanol_e85 +
cng +
propane +
hydrogen +
methanol +
gasoline +
diesel +
unknown_fuel
) AS total_vehicles
FROM vehicle_fuel;


