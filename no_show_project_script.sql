DROP TABLE IF EXISTS medical_appointments;


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

alter table medical_appointments 
drop column no_show;

alter table medical_appointments 
rename column "No-show" to no_show;


SELECT *
FROM medical_appointments
limit 10;

ALTER TABLE medical_appointments
DROP COLUMN hypertension;

ALTER TABLE medical_appointments
RENAME COLUMN "hipertension" TO hypertension;

SELECT *
FROM medical_appointments
limit 10;

SELECT column_name
FROM information_schema.columns
WHERE table_name = 'medical_appointments'
ORDER BY ordinal_position;


CREATE TABLE clean_appointments AS
SELECT
    patientid AS patient_id,
    appointmentid AS appointment_id,
    gender,
    scheduledday,
    appointmentday,
    age,
    neighbourhood,
    scholarship,
    hypertension,
    diabetes,
    alcoholism,
    handcap AS handicap,
    sms_received,
    no_show
FROM medical_appointments
WHERE age >= 0;

SELECT COUNT(*)
FROM clean_appointments;

SELECT *
FROM clean_appointments
LIMIT 10;

ALTER TABLE clean_appointments
ADD COLUMN no_show_flag INT;

UPDATE clean_appointments
SET no_show_flag =
CASE
    WHEN no_show = 'Yes' THEN 1
    ELSE 0
END;

ALTER TABLE clean_appointments
ADD COLUMN lead_days INT;

UPDATE clean_appointments
SET lead_days = appointmentday - scheduledday::date;

select * from clean_appointments
limit 10;

SELECT
COUNT(*) AS total_rows,
MIN(age),
MAX(age)
FROM clean_appointments;

-- what percentage of patients miss appt?
SELECT
ROUND(AVG(no_show_flag) * 100,2) AS no_show_rate
FROM clean_appointments;