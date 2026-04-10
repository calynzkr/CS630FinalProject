Project Overview:
This project implements a Parking Lot Management System using a relational database. It is designed to manage customers, vehicles, parking spots, parking sessions (tickets), and payments efficiently. The system demonstrates proper database design, normalization, and use of constraints to ensure data integrity.


Database Design

The database consists of the following tables:

Customers – Stores customer information
Vehicles – Stores vehicles linked to customers
ParkingSpots – Represents parking spaces and availability
Tickets – Tracks parking sessions (entry/exit)
Payments – Records payments for each parking session
🔗 Relationships
One customer → many vehicles
One vehicle → many tickets
One parking spot → many tickets (over time)
One ticket → one payment
