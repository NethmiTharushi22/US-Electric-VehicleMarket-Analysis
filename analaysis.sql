--create total vehicle column
ALTER TABLE vehicle_fuel
ADD COLUMN total_vehicles BIGINT;

--total vehicles per each state
UPDATE vehicle_fuel
SET total_vehicles =
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
--check
SELECT
state,
total_vehicles
FROM vehicle_fuel
LIMIT 10;

SELECT *
FROM vehicle_fuel
WHERE total_vehicles < 0;


--Add EV Adoption Rate
ALTER TABLE vehicle_fuel
ADD COLUMN ev_adoption_rate DECIMAL(5,2);

UPDATE vehicle_fuel
SET ev_adoption_rate =
ROUND(
(electric_ev * 100.0) / total_vehicles,
2
);		
--Add phev Adoption Rate
ALTER TABLE vehicle_fuel
ADD COLUMN phev_adoption_rate DECIMAL(5,2);

UPDATE vehicle_fuel
SET phev_adoption_rate =
ROUND(
(phev * 100.0) / total_vehicles,
2
);		
--Add hev Adoption Rate
ALTER TABLE vehicle_fuel
ADD COLUMN hev_adoption_rate DECIMAL(5,2);

UPDATE vehicle_fuel
SET hev_adoption_rate =
ROUND(
(hev * 100.0) / total_vehicles,
2
);	
--Add gasoline Adoption Rate
ALTER TABLE vehicle_fuel
ADD COLUMN gasoline_adoption_rate DECIMAL(5,2);

UPDATE vehicle_fuel
SET gasoline_adoption_rate =
ROUND(
(gasoline * 100.0) / total_vehicles,
2
);	

SELECT
state,
electric_ev,
total_vehicles,
ev_adoption_rate
FROM vehicle_fuel
ORDER BY ev_adoption_rate DESC;

ALTER TABLE vehicle_fuel_clean RENAME  TO vehicle_fuel


--create final view

CREATE VIEW vw_ev_market_dashboard AS

SELECT
state,
electric_ev,
phev,
hev,
biodiesel,
ethanol_e85,
cng,
propane,
hydrogen,
methanol,
gasoline,
diesel,
unknown_fuel,
total_vehicles,
ev_adoption_rate,
phev_adoption_rate,
hev_adoption_rate,
gasoline_adoption_rate

FROM vehicle_fuel;

SELECT *
FROM vw_ev_market_dashboard
LIMIT 10;

-- highest ev_percentage
SELECT
state,
ev_adoption_rate
FROM vw_ev_market_dashboard
ORDER BY ev_adoption_rate DESC
LIMIT 5;


-- States Lagging Behind ev_percentage
SELECT
state,
ev_adoption_rate
FROM vw_ev_market_dashboard
ORDER BY ev_adoption_rate ASC
LIMIT 5;


--California vs major states 
SELECT state,electric_ev,total_vehicles,ev_adoption_rate
FROM vw_ev_market_dashboard
WHERE state IN (
'California',
'Texas',
'Florida',
'New York'
)
ORDER BY ev_adoption_rate DESC;

--Alternative Fuel Analysis
SELECT
SUM(biodiesel) AS biodiesel_total,
SUM(ethanol_e85) AS ethanol_total,
SUM(hydrogen) AS hydrogen_total,
SUM(cng) AS cng_total,
SUM(propane) AS propane_total
FROM vehicle_fuel;