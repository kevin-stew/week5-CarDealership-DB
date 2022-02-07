--Insert file

----------------------------CAR_FOR_SALE-------------------------------------------
CREATE OR REPLACE FUNCTION add_car(
	_car_id INTEGER,
	_make VARCHAR,
	_model VARCHAR,
	_year NUMERIC(4),
	_date_recieved TIMESTAMP WITHOUT TIME ZONE,
	_date_sold TIMESTAMP WITHOUT TIME ZONE,
	_is_new BOOLEAN,
	_invoice_id INTEGER
	)
	
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO car_for_sale(car_id, make, model, year, date_recieved, date_sold, is_new, invoice_id)
	VALUES(_car_id, _make, _model, _year, _date_recieved, _date_sold, _is_new, _invoice_id);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_car(1, 'Dodge', 'Caravan', 2000, '20221015', NULL, 1, NULL)
-----------------------------------------------------------------------

INSERT INTO car_for_sale(car_id, make, model, year, date_recieved, date_sold, is_new, invoice_id)
VALUES(1, 'Dodge', 'Caravan', 2000, '20221015', NULL, 1, NULL);

INSERT INTO car_for_sale(car_id, make, model, year, date_recieved, date_sold, is_new, invoice_id)
VALUES(2, 'Dodge', 'Charger', 2012, '20200905', NULL, 0, NULL);

-----------------
SELECT *
FROM car_for_sale 

INSERT INTO car_for_sale(car_id, make, model, year, date_recieved, date_sold, is_new, invoice_id)
VALUES(1, 'Dodge', 'Caravan', 2000, '20221015', NULL, FALSE, NULL);

UPDATE car_for_sale
SET date_recieved = '20201025'
WHERE car_id = 1

INSERT INTO car_for_sale(car_id, make, model, year, date_recieved, date_sold, is_new, invoice_id)
VALUES(2, 'Dodge', 'Charger', 2012, '20200905', NULL, FALSE, NULL);

INSERT INTO car_for_sale(car_id, make, model, year, date_recieved, date_sold, is_new, invoice_id)
VALUES(3, 'Toyota', 'Prius', 2022, '20220115', NULL, TRUE, NULL);

--NOTE TO SELF: might need to remove car_for_sale entries and re-do them

--------------------------NEW_PART---------------------------------------------
CREATE OR REPLACE FUNCTION add_part(_part_id INTEGER, _part_name VARCHAR, _part_cost NUMERIC(8,2))
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO new_part(part_id, part_name, part_cost)
	VALUES(_part_id, _part_name, _part_cost);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_part(1, 'Carburetor', 30.00)

SELECT *
FROM new_part

DELETE FROM new_part
WHERE part_name = 'carburetor'

SELECT add_part(2, 'Serpentine Belt', 20.00)
SELECT add_part(3, 'Radio', 60.00)
SELECT add_part(4, 'Tape Deck', 9.99)
SELECT add_part(5, 'Air Conditioner', 400.00)
SELECT add_part(6, 'Engine', 2000.00)
SELECT add_part(7, 'Gas Tank', 500.00)

-----------------------------MECHANIC------------------------------------------
SELECT *
FROM mechanic 

ALTER TABLE mechanic
RENAME "date-hired" TO date_hired;

UPDATE mechanic
SET date_hired = '20190524'
WHERE first_name LIKE 'Amy'

CREATE OR REPLACE FUNCTION add_mechanic(_mechanic_id INTEGER, _first_name VARCHAR, _last_name VARCHAR, _date_hired TIMESTAMP WITHOUT TIME ZONE)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO mechanic(mechanic_id, first_name, last_name, date_hired)
	VALUES(_mechanic_id, _first_name, _last_name, _date_hired);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT add_mechanic(1, 'Joe', 'Shmoe', '20180415')
SELECT add_mechanic(2, 'Amy', 'Brown', '20180415')
SELECT add_mechanic(3, 'Bob', 'Sizlack', '20151122')

-----------------------------SERVICE HISTORY------------------------------------------

CREATE OR REPLACE FUNCTION add_history(_history_id INTEGER, _service_description VARCHAR, _date_serviced TIMESTAMP WITHOUT TIME ZONE)
RETURNS void
AS $MAIN$
BEGIN
	INSERT INTO service_history(history_id, service_description, date_serviced)
	VALUES(_history_id, _service_description, _date_serviced);
END;
$MAIN$
LANGUAGE plpgsql;

SELECT *
FROM service_history

SELECT add_history(1, 'Rear axil alignment', '20200707')
SELECT add_history(2, 'AC replacement', '20170504')
SELECT add_history(3, 'Sugar in engine parnk flush', '20210608')

UPDATE service_history
SET service_description = 'Sugar in engine flush'
WHERE history_id = 3


-----------------------------MECHANIC HISTORY------------------------------------------
INSERT INTO mechanic_history(mechanic_id, history_id)
VALUES(1, 2);

INSERT INTO mechanic_history(mechanic_id, history_id)
VALUES(3, 1);

SELECT *
FROM mechanic_history

-----------------------------SALES PERSON------------------------------------------
ALTER TABLE sales_person
RENAME "date-hired" TO date_hired;

INSERT INTO sales_person(sales_id, first_name, last_name, date_hired)
VALUES(1, 'Todd', 'Alagash', '20150729');

INSERT INTO sales_person(sales_id, first_name, last_name, date_hired)
VALUES(2, 'Sarah', 'Gorman', '20160507');

INSERT INTO sales_person(sales_id, first_name, last_name, date_hired)
VALUES(3, 'Jack', 'Whitehea', '20170202');

SELECT *
FROM sales_person

-----------------------------DEALERSHIP------------------------------------------
INSERT INTO dealership(store_id, address, phone_number, sales_id, mechanic_id)
VALUES(1, '123 Rush Street, Chicago, IL 60611', '3120002222', NULL, NULL);
--doesn't makes sense to house mechanics and sales ppl in dealership
--rather, dealership_id should be FKs the person tables

SELECT *
FROM dealership

-----------------------------CUSTOMER------------------------------------------

SELECT *
FROM customer

INSERT INTO customer(customer_id, first_name, last_name, phone_number, payment_method, invoice_id, service_invoice_id)
VALUES(1, 'Bill', 'Jackson', '0001114444', '2424-2424-2424-2424', NULL, NULL);

ALTER TABLE customer
ALTER COLUMN phone_number TYPE VARCHAR(15);

UPDATE customer
SET phone_number = '000-111-4444'
WHERE customer_id = 1

INSERT INTO customer(customer_id, first_name, last_name, phone_number, payment_method, invoice_id, service_invoice_id)
VALUES(2, 'Suzie', 'Orman', '222-555-7788', '2424-2424-2424-2424', NULL, NULL);

INSERT INTO customer(customer_id, first_name, last_name, phone_number, payment_method, invoice_id, service_invoice_id)
VALUES(3, 'Phil', 'Robertson', '333-888-9999', '2424-2424-2424-2424', NULL, NULL);

INSERT INTO customer(customer_id, first_name, last_name, phone_number, payment_method, invoice_id, service_invoice_id)
VALUES(4, 'Sarah', 'Tompson', '222-555-4444', '2424-2424-2424-2424', NULL, NULL);

-----------------------------SALES_INVOICE------------------------------------------
SELECT *
FROM sales_invoice 

INSERT INTO sales_invoice(invoice_id, sales_id, car_id, customer_id, purchase_date)
VALUES(1, 2, 1, 4, '20220120');

INSERT INTO sales_invoice(invoice_id, sales_id, car_id, customer_id, purchase_date)
VALUES(2, 1, 2, 3, '20220125');

-----------------------------CAR_TO_REPAIR------------------------------------------
SELECT *
FROM car_to_repair

ALTER TABLE car_to_repair
ALTER COLUMN odometer TYPE VARCHAR(10);

INSERT INTO car_to_repair(car_repair_id, odometer, problem_description, history_id, customer_id)
VALUES(1, '23,025', 'Bats in the gas tank', NULL, NULL);

INSERT INTO car_to_repair(car_repair_id, odometer, problem_description, history_id, customer_id)
VALUES(2, '134,526', 'Mice in the engine', NULL, NULL);

INSERT INTO car_to_repair(car_repair_id, odometer, problem_description, history_id, customer_id)
VALUES(3, '2,023', 'cockroaches in the carburator', NULL, NULL);

-----------------------------SERVICE_INVOICE------------------------------------------
SELECT *
FROM new_part

SELECT *
FROM service_invoice

INSERT INTO service_invoice(service_invoice_id, car_repair_id, part_id, labor_cost, total_cost, issue_date)
VALUES(1, 3, 1, 200.00, 230.00, '20220103');

INSERT INTO service_invoice(service_invoice_id, car_repair_id, part_id, labor_cost, total_cost, issue_date)
VALUES(2, 1, 7, 300.00, 800.00, '20220113');

INSERT INTO service_invoice(service_invoice_id, car_repair_id, part_id, labor_cost, total_cost, issue_date)
VALUES(3, 2, 6, 3000.00, 5000.00, '20220204');

-----------------------------MECHANIC_SERVICE------------------------------------------
SELECT *
FROM mechanic_service

INSERT INTO mechanic_service(mechanic_id, service_invoice_id)
VALUES(3,2);

INSERT INTO mechanic_service(mechanic_id, service_invoice_id)
VALUES(1,3);

INSERT INTO mechanic_service(mechanic_id, service_invoice_id)
VALUES(2,1);

