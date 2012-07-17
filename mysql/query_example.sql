--
-- Will be found records (Gate Nomer, and average amout of cars passed through it) between 2012-07-12 and 2012-07-19
--

USE `car_parking`;
SELECT g.name, p.created_at, car_parks.created_at, round(avg(g.id)) as average_car
FROM `car_parking`.`car_parks`
LEFT JOIN `gates` as g on g.id=car_parks.gate_id
LEFT JOIN `payments` as p on p.car_park_id=car_parks.id
WHERE (DATE(car_parks.created_at) BETWEEN '2012-07-12' AND '2012-07-19')
GROUP BY HOUR(car_parks.created_at)

---
--- Exactly how many cars passed through the gates
---

USE `car_parking`;
SELECT g.name, p.created_at, p.paid_at, car_parks.created_at, count(car_parks.name) as count_cars
FROM `car_parking`.`car_parks`
LEFT JOIN `gates` as g on g.id=car_parks.gate_id
LEFT JOIN `payments` as p on p.car_park_id=car_parks.id
WHERE (DATE(car_parks.created_at) BETWEEN '2012-07-11' AND '2012-07-19')
GROUP BY g.name
ORDER BY g.name
