USE cse4110_vehicle_sales;

-- 1. Brand (10개 브랜드)
INSERT INTO Brand (name) VALUES 
('Genesis'), ('Hyundai'), ('Kia'), ('BMW'), ('Mercedes-Benz'),
('Audi'), ('Porsche'), ('Tesla'), ('Toyota'), ('Lexus');

-- 2. Plant (10개 공장)
INSERT INTO Plant (name, location) VALUES 
('Ulsan_Plant1', 'Ulsan, South Korea'),
('Asan_Plant', 'Asan, South Korea'),
('Sohari_Plant', 'Gwangmyeong, South Korea'),
('Munich_Main', 'Munich, Germany'),
('Stuttgart_Hub', 'Stuttgart, Germany'),
('Ingolstadt_Factory', 'Ingolstadt, Germany'),
('Zuffenhausen', 'Stuttgart, Germany'),
('Gigafactory_Shanghai', 'Shanghai, China'),
('Toyota_City_Plant', 'Aichi, Japan'),
('Tahira_Factory', 'Aichi, Japan');

-- 3. Supplier (10개 공급업체)
INSERT INTO Supplier (name, phone, email) VALUES 
('Hyundai_Mobis', '555-0100', 'supplier01@example.com'),
('HL_Mando', '555-0101', 'supplier02@example.com'),
('Getrag_Transmissions', '555-0102', 'supplier03@example.com'),
('Bosch_Automotive', '555-0103', 'supplier04@example.com'),
('Continental_AG', '555-0104', 'supplier05@example.com'),
('Denso_Corp', '555-0105', 'supplier06@example.com'),
('Aisin_Seiki', '555-0106', 'supplier07@example.com'),
('CATL_Battery', '555-0107', 'supplier08@example.com'),
('Panasonic_Energy', '555-0108', 'supplier09@example.com'),
('Brembo_Brakes', '555-0109', 'supplier10@example.com');

-- 4. Part (10개 부품 종류)
INSERT INTO Part (name, category, price) VALUES 
('V6_Engine_Block', 'Engine', 4500.00),
('Dual_Clutch_Transmission', 'Transmission', 3200.00),
('8_Speed_Automatic_Transmission', 'Transmission', 2900.00),
('ABS_Brake_Caliper', 'Brakes', 450.00),
('LED_Matrix_Headlight', 'Light', 600.00),
('Li_Ion_Battery_Pack_82kWh', 'Battery', 9500.00),
('Multi_Link_Suspension_Strut', 'Suspension', 750.00),
('Leather_Steering_Wheel', 'Interior', 300.00),
('Electronic_Control_Unit', 'ECU', 1200.00),
('Panoramic_Sunroof_Glass', 'Body', 1500.00);

-- 5. Dealer (10개 딜러 대리점)
INSERT INTO Dealer (name, address) VALUES 
('Gangnam_Central_Dealer', 'Gangnam-gu, Seoul, Korea'),
('Seocho_Premium_Dealer', 'Seocho-gu, Seoul, Korea'),
('Bundang_Elite_Motors', 'Bundang-gu, Seongnam, Korea'),
('Busan_Haeundae_Showroom', 'Haeundae-gu, Busan, Korea'),
('Incheon_Airport_Dealer', 'Jung-gu, Incheon, Korea'),
('Tokyo_Ginza_Auto', 'Chuo-ku, Tokyo, Japan'),
('California_Bay_Electric', 'San Jose, California, USA'),
('Munich_Autobahn_Cars', 'Munich, Bavaria, Germany'),
('London_Mayfair_Luxury', 'Westminster, London, UK'),
('Jeju_Island_Motors', 'Jeju-si, Jeju, Korea');

-- 6. Customer (11개 고객)
INSERT INTO Customer (name, address, phone, gender, annual_income) VALUES 
('Customer_01', 'Sample Address 1', '555-0100', 'M', 45000.00),
('Customer_02', 'Sample Address 2', '555-0101', 'F', 125000.00),
('Customer_03', 'Sample Address 3', '555-0102', 'M', 62000.00),
('Customer_04', 'Sample Address 4', '555-0103', 'F', 35000.00),
('Customer_05', 'Sample Address 5', '555-0104', 'M', 180000.00),
('Customer_06', 'Sample Address 6', '555-0105', 'F', 95000.00),
('Customer_07', 'Sample Address 7', '555-0106', 'M', 75000.00),
('Customer_08', 'Sample Address 8', '555-0107', 'F', 58000.00),
('Customer_09', 'Sample Address 9', '555-0108', 'F', 28000.00),
('Customer_10', 'Sample Address 10', '555-0109', 'M', 220000.00),
('Customer_11', 'Sample Address 11', '555-01010', 'M', 52000.00);

-- 7-1. Model_Brand (10개 모델 명칭 라인업 매핑)
INSERT INTO Model_Brand (name, brand_ID) VALUES 
('G80', 1), ('GV80', 1), ('Avante', 2), ('Palisade', 2), 
('K5', 3), ('EV6', 3), ('M3', 4), ('Z4', 4), 
('E_Class', 5), ('Model_3', 8);

-- 7-2. Model_Detail (10개 모델 디테일)
INSERT INTO Model_Detail (name, styles, year, price) VALUES 
('G80', 'Sedan', 2024, 65000.00),
('GV80', 'SUV', 2024, 75000.00),
('Avante', 'Sedan', 2024, 23000.00),
('Palisade', 'SUV', 2025, 48000.00),
('K5', 'Sedan', 2024, 28000.00),
('EV6', 'SUV', 2024, 55000.00),
('M3', 'Sedan', 2025, 85000.00),
('Z4', 'Convertible', 2024, 60000.00),
('E_Class', 'Sedan', 2025, 72000.00),
('Model_3', 'Sedan', 2024, 42000.00);

-- 8. Vehicle (10대 차량)
INSERT INTO Vehicle (VIN, model_ID, plant_ID, sale_ID, year, month, day) VALUES 
('KNA1234567VEH0001', 1, 1, NULL, 2024, 3, 15),
('KNA1234567VEH0002', 2, 1, NULL, 2024, 4, 20),
('KNA1234567VEH0003', 3, 2, NULL, 2024, 5, 12),
('KNA1234567VEH0004', 4, 2, NULL, 2026, 1, 10), -- 2026년 데이터 추가
('WBA1234567VEH0005', 8, 4, NULL, 2024, 6, 18), 
('WBA1234567VEH0006', 8, 4, NULL, 2024, 5, 25), 
('WBA1234567VEH0007', 7, 4, NULL, 2025, 2, 14),
('WDA1234567VEH0008', 9, 5, NULL, 2025, 3, 22),
('5YJ1234567VEH0009', 10, 8, NULL, 2026, 3, 30), -- 2026년 데이터 추가
('KNA1234567VEH0010', 3, 2, NULL, 2026, 2, 13);  -- 2026년 데이터 추가

-- 9. Option_Spec 
INSERT INTO Option_Spec (VIN, option_ID, color, engine_type, transmission_type, interior) VALUES 
('KNA1234567VEH0001', 1, 'Obsidian Black', 'Gasoline 3.5T', '8-Speed AT', 'Base Package'),
('KNA1234567VEH0001', 2, 'Obsidian Black', 'Gasoline 3.5T', '8-Speed AT', 'Premium Leather Pack'), -- 다중 옵션
('KNA1234567VEH0002', 1, 'Uyuni White', 'Diesel 3.0', '8-Speed AT', 'Signature Design II'),
('KNA1234567VEH0003', 1, 'Cyber Gray', 'Gasoline 1.6', 'Dual Clutch', 'Cloth Gray'),
('KNA1234567VEH0003', 2, 'Cyber Gray', 'Gasoline 1.6', 'Dual Clutch', 'Tech Convenience Pack'), -- 다중 옵션
('KNA1234567VEH0004', 1, 'Abyss Black', 'Gasoline 3.8', '8-Speed AT', 'Artificial Leather'),
('WBA1234567VEH0005', 1, 'San Francisco Red', 'Gasoline 2.0T', '8-Speed AT', 'Alcantara Red Line'),
('WBA1234567VEH0006', 1, 'Misano Blue', 'Gasoline 3.0T', '8-Speed AT', 'Leather Cognac'),
('WBA1234567VEH0007', 1, 'Alpine White', 'Gasoline 3.0T', '8-Speed AT', 'Merino Leather Black'),
('WDA1234567VEH0008', 1, 'Polar White', 'Gasoline 2.0T', '9-Speed AT', 'Artico Silk Beige'),
('5YJ1234567VEH0009', 1, 'Solid Black', 'Electric Dual-Motor', 'Single-Speed', 'Premium Eco White'),
('KNA1234567VEH0010', 1, 'Intense Blue', 'Gasoline 1.6', 'Dual Clutch', 'Cloth Black');

-- 10. Manufacturedpart
INSERT INTO Manufacturedpart (serial_number, price, part_ID, plant_ID, VIN, prod_year, prod_month, prod_day) VALUES 
('ENG-V6-1001', 4500.00, 1, 1, 'KNA1234567VEH0001', 2024, 2, 10),
('TRN-DCT-7001', 3200.00, 2, 4, 'KNA1234567VEH0003', 2024, 4, 5),  
('TRN-DCT-7002', 3200.00, 2, 4, 'KNA1234567VEH0010', 2026, 1, 12), 
('TRN-8AT-2001', 2900.00, 3, 1, 'KNA1234567VEH0002', 2024, 3, 1),
('BRK-ABS-3001', 450.00, 4, 3, 'KNA1234567VEH0004', 2025, 12, 15),
('LGT-LED-4001', 600.00, 5, 5, 'WDA1234567VEH0008', 2025, 2, 20),
('BAT-LIO-5001', 9500.00, 6, 8, '5YJ1234567VEH0009', 2026, 2, 25),
('SUS-MLK-6001', 750.00, 7, 4, 'WBA1234567VEH0005', 2024, 5, 10),
('ECU-GEN-9001', 1200.00, 9, 2, 'KNA1234567VEH0004', 2025, 1, 2),
('SUN-PNR-8001', 1500.00, 10, 4, 'WBA1234567VEH0007', 2025, 1, 20);

-- 11. Supply 
INSERT INTO Supply (supplier_ID, model_ID, part_ID) VALUES 
(1, 1, 1), (1, 2, 4), (1, 3, 7), (1, 4, 9), (1, 5, 8),
(2, 5, 3), (2, 6, 3), (2, 7, 3),
(4, 7, 9), (4, 8, 9),
(3, 3, 2),
(5, 9, 5), 
(6, 8, 7), 
(7, 2, 10),
(8, 10, 6);

-- 12. Sale 
INSERT INTO Sale (sale_year, sale_month, sale_week, sale_day, payment_method, price, quantity, VIN, customer_ID, dealer_ID) VALUES 
(2024, 4, 15, 10, 'Credit Card', 65000.00, 1, 'KNA1234567VEH0001', 1, 1),
(2024, 5, 19, 12, 'Bank Transfer', 75000.00, 1, 'KNA1234567VEH0002', 2, 2),
(2024, 6, 23, 5, 'Financing', 23000.00, 1, 'KNA1234567VEH0003', 3, 1),   
(2026, 2, 7, 11, 'Credit Card', 48000.00, 1, 'KNA1234567VEH0004', 4, 3), -- 2026 데이터
(2024, 7, 27, 2, 'Cash', 60000.00, 1, 'WBA1234567VEH0005', 5, 8),        
(2024, 6, 24, 15, 'Financing', 62000.00, 1, 'WBA1234567VEH0006', 6, 8),   
(2025, 3, 11, 18, 'Bank Transfer', 87000.00, 1, 'WBA1234567VEH0007', 7, 8),
(2025, 4, 16, 25, 'Credit Card', 73000.00, 1, 'WDA1234567VEH0008', 8, 5),
(2026, 4, 15, 14, 'Financing', 43000.00, 1, '5YJ1234567VEH0009', 9, 7), -- 2026 데이터
(2026, 3, 11, 20, 'Credit Card', 23500.00, 1, 'KNA1234567VEH0010', 11, 1); -- 2026 데이터

-- 13. Own
INSERT INTO Own (supplier_ID, plant_ID) VALUES 
(1, 1), (1, 2), (2, 3), (3, 4), (4, 5), -- Bosch(4)는 Plant 5로 이동하여 충돌 제거
(5, 6), (6, 7), (7, 8), (8, 9), (9, 10);

-- 14. Target
INSERT INTO Target (plant_ID, part_ID) VALUES 
(1, 1), (4, 2), (1, 3), (3, 4), (5, 5), 
(8, 6), (4, 7), (2, 9), (4, 10), (6, 3);

-- 15. Inventory
INSERT INTO Inventory (VIN, dealer_ID, arrival_year, arrival_month, arrival_day) VALUES 
('KNA1234567VEH0001', 1, 2024, 3, 20),  
('KNA1234567VEH0002', 2, 2024, 4, 25),  
('KNA1234567VEH0003', 1, 2024, 5, 15),  
('KNA1234567VEH0004', 3, 2026, 1, 15),  -- 2026 데이터 반영
('WBA1234567VEH0005', 8, 2024, 6, 20),  
('WBA1234567VEH0006', 8, 2024, 5, 28),  
('WBA1234567VEH0007', 8, 2025, 2, 20),  
('WDA1234567VEH0008', 5, 2025, 3, 28),  
('5YJ1234567VEH0009', 7, 2026, 3, 1),   -- 2026 데이터 반영
('KNA1234567VEH0010', 1, 2026, 2, 18);  -- 2026 데이터 반영

-- 16. 실시간 거래 관계 업데이트
UPDATE Vehicle SET sale_ID = 1 WHERE VIN = 'KNA1234567VEH0001';
UPDATE Vehicle SET sale_ID = 2 WHERE VIN = 'KNA1234567VEH0002';
UPDATE Vehicle SET sale_ID = 3 WHERE VIN = 'KNA1234567VEH0003';
UPDATE Vehicle SET sale_ID = 4 WHERE VIN = 'KNA1234567VEH0004';
UPDATE Vehicle SET sale_ID = 5 WHERE VIN = 'WBA1234567VEH0005';
UPDATE Vehicle SET sale_ID = 6 WHERE VIN = 'WBA1234567VEH0006';
UPDATE Vehicle SET sale_ID = 7 WHERE VIN = 'WBA1234567VEH0007';
UPDATE Vehicle SET sale_ID = 8 WHERE VIN = 'WDA1234567VEH0008';
UPDATE Vehicle SET sale_ID = 9 WHERE VIN = '5YJ1234567VEH0009';
UPDATE Vehicle SET sale_ID = 10 WHERE VIN = 'KNA1234567VEH0010';