DROP TABLE IF EXISTS medical_appointments;
--- create table and load dataset

CREATE TABLE medical_appointments (
    patientid BIGINT,
    appointmentid BIGINT,
    gender TEXT,
    scheduledday TIMESTAMP,
    appointmentday DATE,
    age INT,
    neighbourhood TEXT,
    scholarship INT,
    hypertension INT,
    diabetes INT,
    alcoholism INT,
    handcap INT,
    sms_received INT,
    no_show TEXT
);

SELECT COUNT(*) 
FROM medical_appointments;

SELECT *
FROM medical_appointments
limit 10;
