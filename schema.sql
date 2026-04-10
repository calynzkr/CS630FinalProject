-- Parking Lot Management System
-- schema.sql
-- Creates tables, primary keys, foreign keys, and business constraints

CREATE TABLE parking_lots (
    lot_id           INT PRIMARY KEY,
    lot_name         VARCHAR(100) NOT NULL,
    address_line     VARCHAR(150) NOT NULL,
    city             VARCHAR(60) NOT NULL,
    state_code       CHAR(2) NOT NULL,
    zip_code         VARCHAR(10) NOT NULL,
    total_capacity   INT NOT NULL CHECK (total_capacity > 0),
    open_time        TIME NOT NULL,
    close_time       TIME NOT NULL
);

CREATE TABLE spot_types (
    spot_type_id     INT PRIMARY KEY,
    type_name        VARCHAR(30) NOT NULL UNIQUE,
    hourly_rate      DECIMAL(8,2) NOT NULL CHECK (hourly_rate >= 0)
);
