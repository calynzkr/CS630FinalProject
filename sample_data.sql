-- Parking Lot Management System
-- sample_data.sql
-- Representative data for testing queries and demonstrating relationships
-- File contains representative records designed to simulate real-world operations of a parking lot management system. The data is structured to demonstrate relationships between entities such as customers, vehicles, parking spots, tickets, and payments.

INSERT INTO parking_lots (lot_id, lot_name, address_line, city, state_code, zip_code, total_capacity, open_time, close_time) VALUES
(1, 'Downtown Garage', '100 Main St', 'Jersey City', 'NJ', '07302', 120, '06:00', '23:00'),
(2, 'Riverfront Lot', '25 Hudson Ave', 'Jersey City', 'NJ', '07310', 80, '00:00', '23:59');

INSERT INTO spot_types (spot_type_id, type_name, hourly_rate) VALUES
(1, 'Standard', 5.00),
(2, 'Compact', 4.00),
(3, 'Accessible', 3.00),
(4, 'EV', 6.50),
(5, 'Reserved', 8.00);

INSERT INTO parking_spots (spot_id, lot_id, spot_number, spot_type_id, level_label, is_covered, is_ev_charging, is_accessible, status) VALUES
(101, 1, 'A01', 1, 'L1', TRUE, FALSE, FALSE, 'Available'),
(102, 1, 'A02', 2, 'L1', TRUE, FALSE, FALSE, 'Occupied'),
(103, 1, 'A03', 3, 'L1', TRUE, FALSE, TRUE, 'Available'),
(104, 1, 'A04', 4, 'L1', TRUE, TRUE, FALSE, 'Reserved'),
(105, 1, 'B01', 5, 'L2', TRUE, FALSE, FALSE, 'Reserved'),
(201, 2, 'C01', 1, 'Ground', FALSE, FALSE, FALSE, 'Available'),
(202, 2, 'C02', 4, 'Ground', FALSE, TRUE, FALSE, 'Occupied'),
(203, 2, 'C03', 1, 'Ground', FALSE, FALSE, FALSE, 'Maintenance');

INSERT INTO customers (customer_id, first_name, last_name, phone_number, email, customer_type, created_at) VALUES
(1, 'Olivia', 'Chen', '201-555-1001', 'olivia.chen@example.com', 'Monthly', '2026-03-01 09:00:00'),
(2, 'Marcus', 'Lopez', '201-555-1002', 'marcus.lopez@example.com', 'Visitor', '2026-03-03 10:15:00'),
(3, 'Ava', 'Patel', '201-555-1003', 'ava.patel@example.com', 'Employee', '2026-03-05 08:30:00'),
(4, 'Daniel', 'Kim', '201-555-1004', 'daniel.kim@example.com', 'Visitor', '2026-03-06 12:10:00');

INSERT INTO vehicles (vehicle_id, customer_id, plate_number, make, model, color, vehicle_type) VALUES
(1, 1, 'NJ-ABC123', 'Toyota', 'Camry', 'Black', 'Sedan'),
(2, 2, 'NJ-MLO456', 'Honda', 'CR-V', 'Blue', 'SUV'),
(3, 3, 'NJ-EV789', 'Tesla', 'Model 3', 'White', 'EV'),
(4, 4, 'NY-DKK321', 'Ford', 'Transit', 'Gray', 'Van'),
(5, 1, 'NJ-OLV908', 'BMW', 'X3', 'Silver', 'SUV');

INSERT INTO permits (permit_id, customer_id, lot_id, permit_type, start_date, end_date, assigned_spot_id, permit_status) VALUES
(1, 1, 1, 'Monthly', '2026-03-01', '2026-03-31', 105, 'Active'),
(2, 3, 1, 'Employee', '2026-03-01', '2026-06-30', 104, 'Active');

INSERT INTO parking_sessions (session_id, vehicle_id, spot_id, entry_time, exit_time, billed_hours, session_status) VALUES
(1, 1, 105, '2026-03-10 08:05:00', '2026-03-10 18:10:00', 10.10, 'Closed'),
(2, 2, 102, '2026-03-10 09:30:00', '2026-03-10 12:00:00', 2.50, 'Closed'),
(3, 3, 104, '2026-03-10 07:55:00', NULL, NULL, 'Open'),
(4, 4, 202, '2026-03-10 11:10:00', '2026-03-10 14:40:00', 3.50, 'Closed'),
(5, 5, 101, '2026-03-11 08:00:00', '2026-03-11 10:15:00', 2.25, 'Closed');

INSERT INTO payments (payment_id, session_id, payment_time, amount, payment_method, payment_status, transaction_ref) VALUES
(1, 1, '2026-03-10 18:11:00', 0.00, 'Permit', 'Paid', 'PMT-PERMIT-1001'),
(2, 2, '2026-03-10 12:02:00', 10.00, 'Card', 'Paid', 'PMT-CARD-1002'),
(3, 4, '2026-03-10 14:41:00', 22.75, 'Mobile', 'Paid', 'PMT-MOB-1003'),
(4, 5, '2026-03-11 10:16:00', 11.25, 'Card', 'Paid', 'PMT-CARD-1004');

INSERT INTO attendants (attendant_id, lot_id, first_name, last_name, shift_start, shift_end, phone_number) VALUES
(1, 1, 'Sophia', 'Reed', '06:00', '14:00', '201-555-2001'),
(2, 1, 'Liam', 'Brooks', '14:00', '22:00', '201-555-2002'),
(3, 2, 'Maya', 'Foster', '08:00', '16:00', '201-555-2003');

INSERT INTO violations (violation_id, session_id, attendant_id, violation_time, violation_type, fine_amount, notes) VALUES
(1, 2, 1, '2026-03-10 11:00:00', 'Expired Meter', 25.00, 'Visitor exceeded prepaid duration before checkout'),
(2, 4, 3, '2026-03-10 13:45:00', 'Improper Parking', 40.00, 'Vehicle crossed line markings');
