DROP DATABASE IF EXISTS Airline_Reservation;
-- Creating the database
CREATE DATABASE Airline_Reservation;
USE Airline_Reservation;

-- 1️⃣ Airlines Table
CREATE TABLE Airlines (
    airline_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    headquarters VARCHAR(100) NOT NULL
);

-- 2️⃣ Airports Table
CREATE TABLE Airports (
    airport_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    code VARCHAR(10) UNIQUE NOT NULL
);

-- 3️⃣ Flights Table
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_id INT,
    departure_airport_id INT,
    arrival_airport_id INT,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    aircraft_type VARCHAR(50) NOT NULL,
    FOREIGN KEY (airline_id) REFERENCES Airlines(airline_id) ON DELETE CASCADE,
    FOREIGN KEY (departure_airport_id) REFERENCES Airports(airport_id) ON DELETE CASCADE,
    FOREIGN KEY (arrival_airport_id) REFERENCES Airports(airport_id) ON DELETE CASCADE
);

-- 4️⃣ Passengers Table
CREATE TABLE Passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    passport_no VARCHAR(20) UNIQUE NOT NULL,
    nationality VARCHAR(50) NOT NULL
);

-- 5️⃣ Reservations Table
CREATE TABLE Reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT,
    flight_id INT,
    seat_number VARCHAR(5) NOT NULL,
    class VARCHAR(20) NOT NULL CHECK (class IN ('Economy', 'Business', 'First')),
    status VARCHAR(20) DEFAULT 'Confirmed',
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id) ON DELETE CASCADE,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);

-- 6️⃣ Crew Table
CREATE TABLE Crew (
    crew_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('Pilot', 'Co-Pilot', 'Attendant')),
    flight_id INT,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);

-- 7️⃣ Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT NOW(),
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('Credit Card', 'PayPal', 'UPI', 'Net Banking')),
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id) ON DELETE CASCADE
);

-- 8️⃣ Luggage Table
CREATE TABLE Luggage (
    luggage_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    weight_kg DECIMAL(5,2) NOT NULL,
    type VARCHAR(50) NOT NULL CHECK (type IN ('Checked-in', 'Carry-on')),
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id) ON DELETE CASCADE
);

-- 9️⃣ Flight Status Table
CREATE TABLE Flight_Status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Delayed', 'Departed', 'Landed', 'Cancelled')),
    update_time DATETIME NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);

-- 🔟 Offers & Discounts Table
CREATE TABLE Offers_Discounts (
    offer_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT,
    discount_percent DECIMAL(5,2) NOT NULL CHECK (discount_percent BETWEEN 0 AND 100),
    expiry_date DATE NOT NULL,
    FOREIGN KEY (passenger_id) REFERENCES Passengers(passenger_id) ON DELETE CASCADE
);

INSERT INTO Airlines (name, country, headquarters) VALUES
('Air India', 'India', 'New Delhi'),
('Vistara', 'India', 'Gurgaon'),
('IndiGo', 'India', 'Gurgaon'),
('SpiceJet', 'India', 'Gurgaon'),
('Go First', 'India', 'Mumbai'),
('Akasa Air', 'India', 'Mumbai'),
('Alliance Air', 'India', 'Delhi'),
('AirAsia India', 'India', 'Bangalore'),
('Blue Dart Aviation', 'India', 'Chennai'),
('TruJet', 'India', 'Hyderabad'),
('Star Air', 'India', 'Bangalore'),
('Pinnacle Air', 'India', 'Delhi'),
('Taj Air', 'India', 'Mumbai'),
('Quikjet Airlines', 'India', 'Bangalore'),
('Turbo Megha Airways', 'India', 'Hyderabad'),
('Deccan Charters', 'India', 'Bangalore'),
('Pawan Hans', 'India', 'Noida'),
('Club One Air', 'India', 'Delhi'),
('IndiGo Express', 'India', 'Delhi'),
('FlyBig', 'India', 'Indore');


INSERT INTO Airports (name, city, country, code) VALUES
('Indira Gandhi International Airport', 'Delhi', 'India', 'DEL'),
('Chhatrapati Shivaji International Airport', 'Mumbai', 'India', 'BOM'),
('Kempegowda International Airport', 'Bangalore', 'India', 'BLR'),
('Chennai International Airport', 'Chennai', 'India', 'MAA'),
('Rajiv Gandhi International Airport', 'Hyderabad', 'India', 'HYD'),
('Netaji Subhash Chandra Bose Airport', 'Kolkata', 'India', 'CCU'),
('Cochin International Airport', 'Kochi', 'India', 'COK'),
('Pune International Airport', 'Pune', 'India', 'PNQ'),
('Goa International Airport', 'Goa', 'India', 'GOI'),
('Sardar Vallabhbhai Patel International Airport', 'Ahmedabad', 'India', 'AMD'),
('Jaipur International Airport', 'Jaipur', 'India', 'JAI'),
('Lokpriya Gopinath Bordoloi Airport', 'Guwahati', 'India', 'GAU'),
('Trivandrum International Airport', 'Thiruvananthapuram', 'India', 'TRV'),
('Lal Bahadur Shastri Airport', 'Varanasi', 'India', 'VNS'),
('Sri Guru Ram Dass Jee Airport', 'Amritsar', 'India', 'ATQ'),
('Biju Patnaik International Airport', 'Bhubaneswar', 'India', 'BBI'),
('Devi Ahilya Bai Holkar Airport', 'Indore', 'India', 'IDR'),
('Bagdogra Airport', 'Siliguri', 'India', 'IXB'),
('Chandigarh International Airport', 'Chandigarh', 'India', 'IXC'),
('Madurai International Airport', 'Madurai', 'India', 'IXM');

INSERT INTO Passengers (name, email, phone, passport_no, nationality) VALUES
('Amit Sharma', 'amitsharma@gmail.com', '9898765432', 'IND123456', 'Indian'),
('Priya Verma', 'priyaverma@gmail.com', '9812345678', 'IND234567', 'Indian'),
('Rohit Gupta', 'rohitgupta@gmail.com', '9876543210', 'IND345678', 'Indian'),
('Neha Singh', 'nehasingh@gmail.com', '9834567890', 'IND456789', 'Indian'),
('Vikas Joshi', 'vikasjoshi@gmail.com', '9845678901', 'IND567890', 'Indian'),
('Swati Patel', 'swatipatel@gmail.com', '9856789012', 'IND678901', 'Indian'),
('Rajesh Kumar', 'rajeshkumar@gmail.com', '9867890123', 'IND789012', 'Indian'),
('Meera Iyer', 'meera.iyer@gmail.com', '9878901234', 'IND890123', 'Indian'),
('Ankit Chauhan', 'ankitchauhan@gmail.com', '9889012345', 'IND901234', 'Indian'),
('Pooja Deshmukh', 'poojadesh@gmail.com', '9890123456', 'IND012345', 'Indian'),
('Suresh Reddy', 'sureshreddy@gmail.com', '9811123456', 'IND112345', 'Indian'),
('Kavita Nair', 'kavitanair@gmail.com', '9822234567', 'IND223456', 'Indian'),
('Vivek Malhotra', 'vivekm@gmail.com', '9833345678', 'IND334567', 'Indian'),
('Anjali Dutta', 'anjalid@gmail.com', '9844456789', 'IND445678', 'Indian'),
('Manoj Tiwari', 'manojt@gmail.com', '9855567890', 'IND556789', 'Indian'),
('Deepika Pillai', 'deepikap@gmail.com', '9866678901', 'IND667890', 'Indian'),
('Sanjay Mehta', 'sanjaym@gmail.com', '9877789012', 'IND778901', 'Indian'),
('Rekha Sharma', 'rekhasharma@gmail.com', '9888890123', 'IND889012', 'Indian'),
('Arvind Yadav', 'arvindyadav@gmail.com', '9899901234', 'IND990123', 'Indian'),
('Divya Saxena', 'divyasaxena@gmail.com', '9800012345', 'IND000123', 'Indian');



INSERT INTO Flights (airline_id, departure_airport_id, arrival_airport_id, departure_time, arrival_time, status, aircraft_type) VALUES
(1, 2, 5, '2025-02-10 10:00:00', '2025-02-10 12:30:00', 'Scheduled', 'Boeing 737'),
(2, 3, 1, '2025-02-11 08:15:00', '2025-02-11 10:45:00', 'Departed', 'Airbus A320'),
(3, 4, 6, '2025-02-12 13:30:00', '2025-02-12 16:00:00', 'Cancelled', 'Boeing 777'),
(4, 1, 7, '2025-02-13 06:45:00', '2025-02-13 09:15:00', 'Delayed', 'Airbus A380'),
(5, 5, 3, '2025-02-14 18:00:00', '2025-02-14 21:00:00', 'Scheduled', 'Embraer E190'),
(6, 8, 2, '2025-02-15 07:20:00', '2025-02-15 09:50:00', 'Departed', 'Boeing 737'),
(7, 9, 4, '2025-02-16 14:10:00', '2025-02-16 16:40:00', 'Scheduled', 'Airbus A320'),
(8, 10, 6, '2025-02-17 12:00:00', '2025-02-17 14:30:00', 'Cancelled', 'Boeing 777'),
(9, 1, 11, '2025-02-18 05:45:00', '2025-02-18 08:15:00', 'Scheduled', 'Airbus A380'),
(10, 3, 12, '2025-02-19 09:00:00', '2025-02-19 11:30:00', 'Delayed', 'Embraer E190'),
(11, 6, 1, '2025-02-20 16:30:00', '2025-02-20 19:00:00', 'Scheduled', 'Boeing 737'),
(12, 2, 14, '2025-02-21 07:45:00', '2025-02-21 10:15:00', 'Departed', 'Airbus A320'),
(13, 5, 8, '2025-02-22 20:10:00', '2025-02-22 23:40:00', 'Scheduled', 'Boeing 777'),
(14, 4, 15, '2025-02-23 11:00:00', '2025-02-23 13:30:00', 'Cancelled', 'Airbus A380'),
(15, 3, 9, '2025-02-24 14:45:00', '2025-02-24 17:15:00', 'Scheduled', 'Embraer E190'),
(16, 7, 6, '2025-02-25 10:30:00', '2025-02-25 13:00:00', 'Departed', 'Boeing 737'),
(17, 1, 18, '2025-02-26 06:15:00', '2025-02-26 08:45:00', 'Scheduled', 'Airbus A320'),
(18, 10, 5, '2025-02-27 21:00:00', '2025-02-27 23:30:00', 'Cancelled', 'Boeing 777'),
(19, 8, 17, '2025-02-28 12:30:00', '2025-02-28 15:00:00', 'Scheduled', 'Airbus A380'),
(20, 9, 11, '2025-02-28 18:45:00', '2025-02-28 21:15:00', 'Departed', 'Embraer E190');


INSERT INTO Reservations (passenger_id, flight_id, seat_number, class, status) VALUES
(1, 1, '12A', 'Economy', 'Confirmed'),
(2, 2, '5C', 'Business', 'Cancelled'),
(3, 3, '8F', 'First', 'Confirmed'),
(4, 4, '20B', 'Economy', 'Confirmed'),
(5, 5, '14D', 'Business', 'Confirmed'),
(6, 6, '6A', 'First', 'Cancelled'),
(7, 7, '9E', 'Economy', 'Confirmed'),
(8, 8, '2C', 'Business', 'Confirmed'),
(9, 9, '18F', 'First', 'Cancelled'),
(10, 10, '3B', 'Economy', 'Confirmed'),
(11, 11, '7A', 'Business', 'Confirmed'),
(12, 12, '11D', 'First', 'Cancelled'),
(13, 13, '4C', 'Economy', 'Confirmed'),
(14, 14, '10E', 'Business', 'Confirmed'),
(15, 15, '1F', 'First', 'Cancelled'),
(16, 16, '19B', 'Economy', 'Confirmed'),
(17, 17, '13A', 'Business', 'Confirmed'),
(18, 18, '5D', 'First', 'Cancelled'),
(19, 19, '8C', 'Economy', 'Confirmed'),
(20, 20, '16E', 'Business', 'Confirmed');

INSERT INTO Payments (reservation_id, amount, payment_method) VALUES
(1, 4500.50, 'UPI'),
(2, 6800.75, 'Credit Card'),
(3, 7500.00, 'Net Banking'),
(4, 6200.30, 'UPI'),
(5, 5100.00, 'Credit Card'),
(6, 8900.60, 'Net Banking'),
(7, 4200.20, 'UPI'),
(8, 9600.90, 'Credit Card'),
(9, 5700.50, 'Net Banking'),
(10, 7400.40, 'UPI'),
(11, 6900.80, 'Credit Card'),
(12, 5300.10, 'Net Banking'),
(13, 4800.00, 'UPI'),
(14, 9200.20, 'Credit Card'),
(15, 6700.30, 'Net Banking'),
(16, 6100.60, 'UPI'),
(17, 8800.90, 'Credit Card'),
(18, 4500.70, 'Net Banking'),
(19, 4900.80, 'UPI'),
(20, 9200.50, 'Credit Card');

-- If you need to update payment_date for existing records
SET SQL_SAFE_UPDATES = 0;
UPDATE Payments SET payment_date = NOW() WHERE payment_date IS NULL;
SET SQL_SAFE_UPDATES = 1; 
INSERT INTO Crew (name, role, flight_id) VALUES
('Amit Sharma', 'Pilot', 1),
('Priya Verma', 'Co-Pilot', 2),
('Rohit Gupta', 'Attendant', 3),
('Neha Singh', 'Pilot', 4),
('Vikas Joshi', 'Co-Pilot', 5),
('Swati Patel', 'Attendant', 6),
('Rajesh Kumar', 'Pilot', 7),
('Meera Iyer', 'Co-Pilot', 8),
('Ankit Chauhan', 'Attendant', 9),
('Pooja Deshmukh', 'Pilot', 10),
('Suresh Reddy', 'Co-Pilot', 11),
('Kavita Nair', 'Attendant', 12),
('Vivek Malhotra', 'Pilot', 13),
('Anjali Dutta', 'Co-Pilot', 14),
('Manoj Tiwari', 'Attendant', 15),
('Deepika Pillai', 'Pilot', 16),
('Sanjay Mehta', 'Co-Pilot', 17),
('Rekha Sharma', 'Attendant', 18),
('Arvind Yadav', 'Pilot', 19),
('Divya Saxena', 'Co-Pilot', 20);


INSERT INTO Luggage (reservation_id, weight_kg, type) VALUES
(1, 15.5, 'Checked-in'),
(2, 7.0, 'Carry-on'),
(3, 20.3, 'Checked-in'),
(4, 10.0, 'Carry-on'),
(5, 25.7, 'Checked-in'),
(6, 8.2, 'Carry-on'),
(7, 18.4, 'Checked-in'),
(8, 9.5, 'Carry-on'),
(9, 22.1, 'Checked-in'),
(10, 11.0, 'Carry-on'),
(11, 14.8, 'Checked-in'),
(12, 6.3, 'Carry-on'),
(13, 23.5, 'Checked-in'),
(14, 10.7, 'Carry-on'),
(15, 21.2, 'Checked-in'),
(16, 5.0, 'Carry-on'),
(17, 16.5, 'Checked-in'),
(18, 7.9, 'Carry-on'),
(19, 19.0, 'Checked-in'),
(20, 8.5, 'Carry-on');


-- First, drop the existing table if it exists
DROP TABLE IF EXISTS Flight_Status;

-- Recreate the Flight_Status table with the correct constraint
CREATE TABLE Flight_Status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Delayed', 'Departed', 'Landed', 'Cancelled', 'Scheduled')), -- Added 'Scheduled' to allowed values
    update_time DATETIME NOT NULL,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id) ON DELETE CASCADE
);

-- Now insert the data
INSERT INTO Flight_Status (flight_id, status, update_time) VALUES
(1, 'Departed', '2025-02-10 10:30:00'),
(2, 'Delayed', '2025-02-11 08:20:00'),
(3, 'Cancelled', '2025-02-12 13:00:00'),
(4, 'Landed', '2025-02-13 09:30:00'),
(5, 'Departed', '2025-02-14 18:20:00'),
(6, 'Scheduled', '2025-02-15 07:50:00'),
(7, 'Delayed', '2025-02-16 14:30:00'),
(8, 'Cancelled', '2025-02-17 12:10:00'),
(9, 'Landed', '2025-02-18 05:50:00'),
(10, 'Departed', '2025-02-19 09:15:00'),
(11, 'Scheduled', '2025-02-20 16:45:00'),
(12, 'Delayed', '2025-02-21 07:30:00'),
(13, 'Cancelled', '2025-02-22 20:50:00'),
(14, 'Landed', '2025-02-23 11:45:00'),
(15, 'Departed', '2025-02-24 14:55:00'),
(16, 'Scheduled', '2025-02-25 10:40:00'),
(17, 'Delayed', '2025-02-26 06:25:00'),
(18, 'Cancelled', '2025-02-27 21:10:00'),
(19, 'Landed', '2025-02-28 12:45:00'),
(20, 'Departed', '2025-02-28 18:50:00');

INSERT INTO Offers_Discounts (passenger_id, discount_percent, expiry_date) VALUES
(1, 15.0, '2025-03-15'),
(2, 20.0, '2025-03-10'),
(3, 10.5, '2025-03-20'),
(4, 25.0, '2025-03-25'),
(5, 30.0, '2025-03-12'),
(6, 18.0, '2025-03-22'),
(7, 12.5, '2025-03-17'),
(8, 22.0, '2025-03-29'),
(9, 35.0, '2025-03-05'),
(10, 40.0, '2025-03-18'),
(11, 28.0, '2025-03-26'),
(12, 14.0, '2025-03-08'),
(13, 17.5, '2025-03-13'),
(14, 32.0, '2025-03-30'),
(15, 45.0, '2025-03-09'),
(16, 50.0, '2025-03-28'),
(17, 27.0, '2025-03-07'),
(18, 19.0, '2025-03-16'),
(19, 29.5, '2025-03-14'),
(20, 38.0, '2025-03-21');


