CREATE DATABASE cse4110_vehicle_sales CHARACTER SET utf8mb4;
USE cse4110_vehicle_sales;

-- 1. Brand
CREATE TABLE Brand (
    brand_ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Plant
CREATE TABLE Plant (
    plant_ID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    location VARCHAR(100) NOT NULL,
    CONSTRAINT plant1 UNIQUE (name, location)
);

-- 3. Supplier
CREATE TABLE Supplier (
   supplier_ID INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   phone VARCHAR(20) NOT NULL UNIQUE,
   email VARCHAR(50) NOT NULL UNIQUE
);

-- 4. Part
CREATE TABLE Part (
   part_ID INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(50) NOT NULL UNIQUE,
   category VARCHAR(30) NOT NULL,
   price DECIMAL(10, 2) NOT NULL CHECK (price >= 0)
);

-- 5. Dealer
CREATE TABLE Dealer (
   dealer_ID INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   address VARCHAR(100) NOT NULL,
   CONSTRAINT dealer1 UNIQUE (name, address)
);

-- 6. Customer
CREATE TABLE Customer (
   customer_ID INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   address VARCHAR(100) NOT NULL,
   phone VARCHAR(20) NOT NULL UNIQUE,
   gender CHAR(1) NOT NULL CHECK (gender IN ('M', 'F')),
   annual_income DECIMAL(12, 2) NOT NULL CHECK (annual_income >= 0)
);

-- 7-1. Model_Brand
CREATE TABLE Model_Brand (
   name VARCHAR(50) PRIMARY KEY,
   brand_ID INT NOT NULL,
   FOREIGN KEY (brand_ID) REFERENCES Brand(brand_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 7-2. Model_Detail
CREATE TABLE Model_Detail (
   model_ID INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   styles VARCHAR(30) NOT NULL,
   year INT NOT NULL,
   price DECIMAL(12, 2) NOT NULL,
   CONSTRAINT model_detail1 UNIQUE (name, styles, year),
   FOREIGN KEY (name) REFERENCES Model_Brand(name) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 8. Vehicle
CREATE TABLE Vehicle (
   VIN VARCHAR(17) PRIMARY KEY,
   model_ID INT NOT NULL,
   plant_ID INT NOT NULL,
   sale_ID INT NULL, -- 추후에 제약조건 추가될 예정
   year INT NOT NULL,
   month INT NOT NULL,
   day INT NOT NULL,
   FOREIGN KEY (model_ID) REFERENCES Model_Detail(model_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
   FOREIGN KEY (plant_ID) REFERENCES Plant(plant_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 9. Option_Spec 
CREATE TABLE Option_Spec (
   VIN VARCHAR(17),
   option_ID INT,
   color VARCHAR(30) NOT NULL,
   engine_type VARCHAR(50) NOT NULL,
   transmission_type VARCHAR(50) NOT NULL,
   interior VARCHAR(50) NOT NULL,
   PRIMARY KEY (VIN, option_ID),
   FOREIGN KEY (VIN) REFERENCES Vehicle(VIN) ON DELETE CASCADE ON UPDATE CASCADE
);

-- 10. Manufacturedpart
CREATE TABLE Manufacturedpart (
   serial_number VARCHAR(50) PRIMARY KEY,
   price DECIMAL(10, 2) NOT NULL,
   part_ID INT NOT NULL,
   plant_ID INT NOT NULL,
   VIN VARCHAR(17),
   prod_year INT NOT NULL,
   prod_month INT NOT NULL,
   prod_day INT NOT NULL,
   FOREIGN KEY (part_ID) REFERENCES Part(part_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
   FOREIGN KEY (plant_ID) REFERENCES Plant(plant_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
   FOREIGN KEY (VIN) REFERENCES Vehicle(VIN) ON DELETE SET NULL ON UPDATE CASCADE
);

-- 11. Supply 
CREATE TABLE Supply (
   supply_ID INT AUTO_INCREMENT PRIMARY KEY,
   supplier_ID INT NOT NULL,
   model_ID INT NOT NULL,
   part_ID INT NOT NULL,
   CONSTRAINT supply1 UNIQUE (supplier_ID, model_ID, part_ID),
   FOREIGN KEY (supplier_ID) REFERENCES Supplier(supplier_ID) ON DELETE CASCADE,
   FOREIGN KEY (model_ID) REFERENCES Model_Detail(model_ID) ON DELETE CASCADE,
   FOREIGN KEY (part_ID) REFERENCES Part(part_ID) ON DELETE CASCADE
);

-- 12. Sale 
CREATE TABLE Sale (
   sale_ID INT AUTO_INCREMENT PRIMARY KEY,
   sale_year INT NOT NULL,
   sale_month INT NOT NULL,
   sale_week INT NOT NULL,
   sale_day INT NOT NULL,
   payment_method VARCHAR(20) NOT NULL,
   price DECIMAL(12, 2) NOT NULL,
   quantity INT NOT NULL,
   VIN VARCHAR(17) NOT NULL UNIQUE,
   customer_ID INT NOT NULL,
   dealer_ID INT NOT NULL,
   FOREIGN KEY (VIN) REFERENCES Vehicle(VIN) ON DELETE RESTRICT ON UPDATE CASCADE,
   FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
   FOREIGN KEY (dealer_ID) REFERENCES Dealer(dealer_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 13. Own 
CREATE TABLE Own (
   supplier_ID INT,
   plant_ID INT,
   PRIMARY KEY (supplier_ID, plant_ID),
   FOREIGN KEY (supplier_ID) REFERENCES Supplier(supplier_ID) ON DELETE CASCADE,
   FOREIGN KEY (plant_ID) REFERENCES Plant(plant_ID) ON DELETE CASCADE
);

-- 14. Target 
CREATE TABLE Target (
   plant_ID INT,
   part_ID INT,
   PRIMARY KEY (plant_ID, part_ID),
   FOREIGN KEY (plant_ID) REFERENCES Plant(plant_ID) ON DELETE CASCADE,
   FOREIGN KEY (part_ID) REFERENCES Part(part_ID) ON DELETE CASCADE
);

-- 15. Inventory 
CREATE TABLE Inventory (
   VIN VARCHAR(17) PRIMARY KEY,
   dealer_ID INT NOT NULL,
   arrival_year INT NOT NULL,
   arrival_month INT NOT NULL,
   arrival_day INT NOT NULL,
   FOREIGN KEY (VIN) REFERENCES Vehicle(VIN) ON DELETE CASCADE,
   FOREIGN KEY (dealer_ID) REFERENCES Dealer(dealer_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

ALTER TABLE Vehicle ADD CONSTRAINT vehicle1 FOREIGN KEY (sale_ID) REFERENCES Sale(sale_ID) ON DELETE SET NULL ON UPDATE CASCADE;