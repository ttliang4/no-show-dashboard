
DROP TABLE IF EXISTS clean_appt;

--- create a table for cleaned data
CREATE TABLE clean_appt AS
SELECT
    patientid AS patient_id,
    appointmentid AS appointment_id,
    gender,
    scheduledday,
    appointmentday,
    age,
    neighbourhood,
    scholarship,
    hipertension as hypertension, --- typo
    diabetes,
    alcoholism,
    handcap AS handicap, --- typo
    sms_received,
    "No-show" as arrived --- fix no show column, double negative, values flipped
FROM medical_appointments
WHERE age >= 0; --- drop negative ages


select * from clean_appt
limit 10;


--- show column lists, data type
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'clean_appt'
ORDER BY ordinal_position;

--- alter column patient id to string
alter table clean_appt
alter column patient_id TYPE TEXT;

-- alter column appt id to string
alter table clean_appt
alter column appointment_id TYPE TEXT;


SELECT COUNT(*)
FROM clean_appointments;

--- add a column of wait days = appointment day - scheduled day
--- also = wait day
ALTER TABLE clean_appt
ADD COLUMN wait_days INT;

UPDATE clean_appt
SET wait_days = appointmentday - scheduledday::date;


select min(wait_days), max(wait_days)
from clean_appt;

--- there is negative wait time, need to drop
delete from clean_appt
where wait_days < 0;

--- add a column with no show binary
--- if not arrived = 1 no show
ALTER TABLE clean_appt
ADD COLUMN no_show_flag INT;

UPDATE clean_appt
SET no_show_flag =
CASE
    WHEN arrived = 'Yes' THEN 1
    ELSE 0
END;

--- name day of the week
alter table clean_appt 
add column appt_day_of_week text;

update clean_appt 
set appt_day_of_week = to_char(appointmentday, 'Day');

--- check table
select * from clean_appt
limit 10;

SELECT
COUNT(*) AS total_rows
from clean_appt;





