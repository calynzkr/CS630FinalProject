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
CREATE TABLE parking_spots (
    spot_id             INT PRIMARY KEY,
    lot_id              INT NOT NULL,
    spot_number         VARCHAR(10) NOT NULL,
    spot_type_id        INT NOT NULL,
    level_label         VARCHAR(20),
    is_covered          BOOLEAN NOT NULL DEFAULT FALSE,
    is_ev_charging      BOOLEAN NOT NULL DEFAULT FALSE,
    is_accessible       BOOLEAN NOT NULL DEFAULT FALSE,
    status              VARCHAR(15) NOT NULL DEFAULT 'Available'
                         CHECK (status IN ('Available','Occupied','Reserved','Maintenance')),
    CONSTRAINT uq_spot_per_lot UNIQUE (lot_id, spot_number),
    CONSTRAINT fk_spots_lot FOREIGN KEY (lot_id) REFERENCES parking_lots(lot_id),
    CONSTRAINT fk_spots_type FOREIGN KEY (spot_type_id) REFERENCES spot_types(spot_type_id)
);

CREATE TABLE customers (
    customer_id       INT PRIMARY KEY,
    first_name        VARCHAR(50) NOT NULL,
    last_name         VARCHAR(50) NOT NULL,
    phone_number      VARCHAR(20) NOT NULL UNIQUE,
    email             VARCHAR(120) NOT NULL UNIQUE,
    customer_type     VARCHAR(15) NOT NULL CHECK (customer_type IN ('Visitor','Monthly','Employee')),
    created_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE vehicles (
    vehicle_id         INT PRIMARY KEY,
    customer_id        INT NOT NULL,
    plate_number       VARCHAR(20) NOT NULL UNIQUE,
    make               VARCHAR(50) NOT NULL,
    model              VARCHAR(50) NOT NULL,
    color              VARCHAR(30),
    vehicle_type       VARCHAR(20) NOT NULL CHECK (vehicle_type IN ('Sedan','SUV','Truck','Motorcycle','Van','EV')),
    CONSTRAINT fk_vehicle_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE permits (
    permit_id           INT PRIMARY KEY,
    customer_id         INT NOT NULL,
    lot_id              INT NOT NULL,
    permit_type         VARCHAR(20) NOT NULL CHECK (permit_type IN ('Monthly','Employee','Reserved')),
    start_date          DATE NOT NULL,
    end_date            DATE NOT NULL,
    assigned_spot_id    INT,
    permit_status       VARCHAR(15) NOT NULL DEFAULT 'Active'
                         CHECK (permit_status IN ('Active','Expired','Suspended')),
    CONSTRAINT ck_permit_dates CHECK (end_date >= start_date),
    CONSTRAINT fk_permit_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_permit_lot FOREIGN KEY (lot_id) REFERENCES parking_lots(lot_id),
    CONSTRAINT fk_permit_spot FOREIGN KEY (assigned_spot_id) REFERENCES parking_spots(spot_id)
);

CREATE TABLE parking_sessions (
    session_id          INT PRIMARY KEY,
    vehicle_id          INT NOT NULL,
    spot_id             INT NOT NULL,
    entry_time          TIMESTAMP NOT NULL,
    exit_time           TIMESTAMP,
    billed_hours        DECIMAL(8,2),
    session_status      VARCHAR(12) NOT NULL DEFAULT 'Open'
                         CHECK (session_status IN ('Open','Closed','Canceled')),
    CONSTRAINT ck_session_exit CHECK (exit_time IS NULL OR exit_time >= entry_time),
    CONSTRAINT fk_session_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    CONSTRAINT fk_session_spot FOREIGN KEY (spot_id) REFERENCES parking_spots(spot_id)
);

CREATE TABLE payments (
    payment_id          INT PRIMARY KEY,
    session_id          INT NOT NULL,
    payment_time        TIMESTAMP NOT NULL,
    amount              DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_method      VARCHAR(20) NOT NULL CHECK (payment_method IN ('Card','Cash','Mobile','Permit')),
    payment_status      VARCHAR(15) NOT NULL DEFAULT 'Paid'
                         CHECK (payment_status IN ('Paid','Pending','Refunded')),
    transaction_ref     VARCHAR(50) UNIQUE,
    CONSTRAINT fk_payment_session FOREIGN KEY (session_id) REFERENCES parking_sessions(session_id)
);

CREATE TABLE attendants (
    attendant_id        INT PRIMARY KEY,
    lot_id              INT NOT NULL,
    first_name          VARCHAR(50) NOT NULL,
    last_name           VARCHAR(50) NOT NULL,
    shift_start         TIME NOT NULL,
    shift_end           TIME NOT NULL,
    phone_number        VARCHAR(20) UNIQUE,
    CONSTRAINT fk_attendant_lot FOREIGN KEY (lot_id) REFERENCES parking_lots(lot_id)
);

CREATE TABLE violations (
    violation_id         INT PRIMARY KEY,
    session_id           INT NOT NULL,
    attendant_id         INT,
    violation_time       TIMESTAMP NOT NULL,
    violation_type       VARCHAR(40) NOT NULL,
    fine_amount          DECIMAL(10,2) NOT NULL CHECK (fine_amount >= 0),
    notes                VARCHAR(255),
    CONSTRAINT fk_violation_session FOREIGN KEY (session_id) REFERENCES parking_sessions(session_id),
    CONSTRAINT fk_violation_attendant FOREIGN KEY (attendant_id) REFERENCES attendants(attendant_id)
);

