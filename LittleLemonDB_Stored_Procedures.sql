-- Task 1: Creating a Procedure to Display Maximum Ordered Quantity
DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(Quantity) AS Max_Ordered_Quantity FROM Orders;
END//

DELIMITER ;

-- Task 2: Creating a Prepared Statement to Retrieve Order Details
DELIMITER //

CREATE PROCEDURE GetOrderDetail(IN customer_id INT)
BEGIN
    PREPARE stmt FROM 'SELECT Order_ID, Quantity, Total_Cost FROM Orders WHERE Customer_ID = ?';
    SET @customer_id = customer_id;
    EXECUTE stmt USING @customer_id;
    DEALLOCATE PREPARE stmt;
END//

DELIMITER ;

-- Task 3: Creating a Stored Procedure to Cancel an Order
DELIMITER //

CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    DELETE FROM Orders WHERE Order_ID = order_id;
END//

DELIMITER ;

-- Task 4: Populating the Bookings Table

-- Inserting records into the Bookings table
INSERT INTO Bookings (BookingID, BookingDate, TableNumber, CustomerID)
VALUES
(1, '2022-10-10', 5, 1),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1);

-- Task 5: Creating the CheckBooking Stored Procedure

-- Creating the CheckBooking stored procedure
DELIMITER //

CREATE PROCEDURE CheckBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE is_booked INT;
    SELECT COUNT(*) INTO is_booked
    FROM Bookings
    WHERE BookingDate = booking_date AND TableNumber = table_number;
    
    IF is_booked > 0 THEN
        SELECT 'Table is already booked' AS Message;
    ELSE
        SELECT 'Table is available' AS Message;
    END IF;
END//

DELIMITER ;

-- Task 6: Creating the AddValidBooking Stored Procedure

-- Creating the AddValidBooking stored procedure
DELIMITER //

CREATE PROCEDURE AddValidBooking(IN booking_date DATE, IN table_number INT)
BEGIN
    DECLARE is_booked INT;
    SET is_booked = (SELECT COUNT(*) FROM Bookings WHERE BookingDate = booking_date AND TableNumber = table_number);
    
    START TRANSACTION;
    
    IF is_booked > 0 THEN
        ROLLBACK;
        SELECT 'Booking cancelled. Table is already booked on the specified date.' AS Message;
    ELSE
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID)
        VALUES (booking_date, table_number, NULL); -- Assuming no customer for this example
        COMMIT;
        SELECT 'Booking successful' AS Message;
    END IF;
END//

DELIMITER ;

-- Task 7: Creating the AddBooking Procedure

DELIMITER //

CREATE PROCEDURE AddBooking(IN booking_id INT, IN customer_id INT, IN booking_date DATE, IN table_number INT)
BEGIN
    INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber)
    VALUES (booking_id, customer_id, booking_date, table_number);
    
    SELECT 'Booking added successfully' AS Message;
END//

DELIMITER ;

-- Task 8: Creating the UpdateBooking Procedure

DELIMITER //

CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN new_booking_date DATE)
BEGIN
    UPDATE Bookings
    SET BookingDate = new_booking_date
    WHERE BookingID = booking_id;
    
    SELECT 'Booking updated successfully' AS Message;
END//

DELIMITER ;

-- Task 9: Creating the CancelBooking Procedure

DELIMITER //

CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
    DELETE FROM Bookings
    WHERE BookingID = booking_id;
    
    SELECT 'Booking cancelled successfully' AS Message;
END//

DELIMITER ;

