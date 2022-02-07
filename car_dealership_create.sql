CREATE TABLE "new_part" (
  "part_id" SERIAL PRIMARY KEY,
  "part_name" VARCHAR(100),
  "part_cost" NUMERIC(8,2)
);

CREATE TABLE "mechanic" (
  "mechanic_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "date-hired" DATE
);

CREATE TABLE "service_history" (
  "history_id" SERIAL PRIMARY KEY ,
  "service_description" VARCHAR(150),
  "date_serviced" DATE
);

CREATE TABLE "mechanic_history" (
  "mechanic_id" INTEGER,
  "history_id" INTEGER,
  FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id),
  FOREIGN KEY(history_id) REFERENCES service_history(history_id)
);

CREATE TABLE "sales_person" (
  "sales_id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "date-hired" DATE
);


CREATE TABLE "dealership"(
  "store_id" SERIAL PRIMARY KEY,
  "address" VARCHAR(150),
  "phone_number" VARCHAR(10),
  "sales_id" INTEGER,
  "mechanic_id" INTEGER,
  FOREIGN KEY(sales_id) REFERENCES sales_person(sales_id), 
  FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id)
);


CREATE TABLE "car_for_sale" (
  "car_id" SERIAL,
  "make" VARCHAR(100),
  "model" VARCHAR(100),
  "year" NUMERIC(4) NOT NULL,
  "date_recieved" DATE,
  "date_sold" DATE,
  "is_new" BOOLEAN,
  "invoice_id" INTEGER,
  "customer_id" INTEGER,
  PRIMARY KEY ("car_id")
);

CREATE TABLE "customer" (
  "customer_id" SERIAL,
  "first_name" VARCHAR(100),
  "last_name" VARCHAR(100),
  "phone_number" VARCHAR(10),
  "payment_method" VARCHAR(150),
  "invoice_id" INTEGER,
  "service_invoice_id" INTEGER,
  PRIMARY KEY ("customer_id")
);


CREATE TABLE "sales_invoice" (
  "invoice_id" SERIAL PRIMARY KEY,
  "sales_id" INTEGER,
  "car_id" INTEGER,
  "customer_id" INTEGER,
  "purchase_date" DATE NOT NULL,
  FOREIGN KEY(sales_id) REFERENCES sales_person(sales_id),
  FOREIGN KEY(car_id) REFERENCES car_for_sale(car_id),
  FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);



CREATE TABLE "car_to_repair" (
  "car_repair_id" SERIAL PRIMARY KEY,
  "odometer" SERIAL,
  "problem_description" VARCHAR(200),
  "history_id" INTEGER,
  "customer_id" INTEGER,
  FOREIGN KEY(history_id) REFERENCES service_history(history_id),
  FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);


CREATE TABLE "service_invoice" (
  "service_invoice_id" SERIAL PRIMARY KEY,
  "part_id" INTEGER,
  "labor_cost" NUMERIC(8,2),
  "total_cost" NUMERIC(8,2),
  "car_repair_id" INTEGER,
  "issue_date" DATE,
  FOREIGN KEY(car_repair_id) REFERENCES car_to_repair(car_repair_id),
  FOREIGN KEY(part_id) REFERENCES new_part(part_id),
  FOREIGN KEY(car_repair_id) REFERENCES car_to_repair(car_repair_id)
);


CREATE TABLE "mechanic_service" (
  "mechanic_id" INTEGER,
  "service_invoice_id" INTEGER
);

