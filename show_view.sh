#!/bin/sh
#export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib

cat << EOF | sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"

---------------VIEWS---------------

column "Type of Room" format a18

--How many nurses in each of the rooms?
CREATE VIEW "Number_of_Nurses_in_Each_Room" AS
SELECT COUNT(NURSE_INCHARGE) "Number of Nurses", ROOM_TYPE "Type of Room"
FROM ROOMS
GROUP BY ROOM_TYPE;

SELECT * FROM "Number_of_Nurses_in_Each_Room";

column "Patient Name" format a17
column "Doctor Name" format a17
column "Appointment Date" format a17
column "Appointment Description" format a24 

--Show upcoming appointments of patients with their doctors and appointment details 
--CREATE VIEW "Upcoming_Appointments" AS
--SELECT CONCAT(CONCAT(PATIENT.FIRST_NAME,' '),PATIENT.LAST_NAME) AS "Patient Name",
--CONCAT(CONCAT(DOCTORS.DOC_FIRST_NAME, ' '), DOCTORS.DOC_LAST_NAME) AS "Doctor Name",
--RECORDS.APPOINTMENT_DATE AS "Appointment Date", RECORDS.APPOINTMENT_DESCRIPTION AS "Appointment Description"
--FROM PATIENT, DOCTORS, RECORDS
--WHERE PATIENT.PATIENT_ID = RECORDS.PATIENT_ID
--AND DOCTORS.DOCTOR_ID = RECORDS.DOCTOR_ID
--ORDER BY RECORDS.APPOINTMENT_DATE;

--SELECT * FROM "Upcoming_Appointments"; 

--How many patients got each type of lab test done?
--CREATE VIEW "Patients_per_Treatment" AS
--SELECT COUNT(PATIENT_ID) "Number of Patients", DISTINCT TEST_TYPE "Type of Lab Test"
--FROM LABS
--GROUP BY TEST_TYPE;

--SELECT * FROM "Patients_per_Treatment";

EOF

exit;
