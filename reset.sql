-- Parking Lot Management System
-- reset.sql
-- Drops all tables so the schema can be recreated cleanly

DROP TABLE IF EXISTS violations;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS parking_sessions;
DROP TABLE IF EXISTS permits;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS attendants;
DROP TABLE IF EXISTS parking_spots;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS spot_types;
DROP TABLE IF EXISTS parking_lots;
