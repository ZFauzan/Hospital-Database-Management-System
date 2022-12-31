#!/bin/sh

cat << EOF | sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"

set wrap off
set linesize 150

--------------- SIMPLE QUERIES---------------

--Show all patients whose lab fee is below $ 100.00
--SELECT BILL_NO "Bill Number",  
--PATIENT_ID "Patient ID",
--LAB_FEE "Lab Fee" 
--FROM BILLS
--WHERE LAB_FEE < 100.00; 

column 'Doctor Name' format a18
column SPECIALIZATION format a18

--Show the doctors names with their ID who charge a fee of 1500 or greater and are an eye specialist 
--Or they have a fee of 2000 or greater and are a neurosurgeon
SELECT DOCTOR_ID "Doctor ID", 
CONCAT(CONCAT(DOC_FIRST_NAME, ' '), DOC_LAST_NAME) AS "Doctor Name",
DOC_FEE "Doctor Fee", SPECIALISATION "Specialization" 
FROM DOCTORS
WHERE DOC_FEE >= 1500 AND SPECIALISATION = 'Eye Specialist'
    OR DOC_FEE >= 2000 AND SPECIALISATION = 'Neurosurgeon'; 

--Show the salaries and names of doctors sorted in descending order 
SELECT EMPLOYEE_ID "Employee ID", 
CONCAT(CONCAT(FIRST_NAME, ' '), LAST_NAME) AS "Doctor Name", 
SALARY "Salary"
FROM EMPLOYEE
WHERE POSITION LIKE 'Doctor' 
ORDER BY SALARY DESC; 

column TEST_TYPE format a10
column BLOOD_TYPE format a12

--Show patients whose blood type is not O negative, and has blood pressure of at least 120
--SELECT * FROM LABS 
--WHERE BLOOD_TYPE <> 'O neg'
--AND BLOOD_PRESSURE >= 120
--ORDER BY BLOOD_PRESSURE; 

column 'Nurse Name' format a18

--Show all attributes of nurses sorted by last name in a descending order
SELECT CONCAT(CONCAT(NURSE_LAST_NAME, ', '), NURSE_FIRST_NAME) AS "Nurse Name", 
EMPLOYEE_ID "Employee ID", NURSE_ID "Nurse ID" 
FROM NURSES;

column 'First Name' format a18
column 'Last Name' format a18

--Show patients such that their patient id is in ascending order but their phone numbers are in a decending order
--SELECT PATIENT_ID "Patient ID", FIRST_NAME "First Name", LAST_NAME "Last Name", PHONE_NO 
--FROM PATIENT
--ORDER BY PATIENT_ID, PHONE_NO DESC; 

--Show all receptionists whose last names don't start with A or Z
SELECT EMPLOYEE_ID "Employee ID", 
RECEPTIONIST_FIRST_NAME "First Name",
RECEPTIONIST_LAST_NAME "Last Name"
FROM RECEPTIONISTS
MINUS
(SELECT EMPLOYEE_ID "Employee ID", 
RECEPTIONIST_FIRST_NAME "First Name",
RECEPTIONIST_LAST_NAME "Last Name"
FROM RECEPTIONISTS
WHERE RECEPTIONIST_LAST_NAME LIKE 'A%' OR RECEPTIONIST_LAST_NAME LIKE 'Z%');

column "Appointment Description" format a26

--Show patients who have a surgery or a follow up appointment
--SELECT DISTINCT PATIENT_ID AS PATIENT_IDS, APPOINTMENT_ID "Appointment ID", 
--APPOINTMENT_DESCRIPTION "Appointment Description", DOCTOR_ID "Doctor ID" 
--FROM RECORDS 
--WHERE APPOINTMENT_DESCRIPTION LIKE 'Surgery' OR APPOINTMENT_DESCRIPTION LIKE 'Follow up'
--ORDER BY PATIENT_ID; 

column ROOM_TYPE format a10
column 'Nurse First Name' format a18

--Show all attributes of occupied rooms that are not Ward rooms
SELECT * FROM ROOMS 
WHERE STATUS = 'occupied' 
AND NOT(ROOM_TYPE = 'Ward'); 

--Show all attributes of the test-price table such that the test price is greater than 100 or less than 50 
SELECT * FROM TEST_PRICE 
WHERE TEST_PRICE > 100 OR TEST_PRICE < 50
ORDER BY TEST_CODE; 

---------------ADVANCED QUERIES---------------

column DOC_FIRST_NAME format a15
column DOC_LAST_NAME format a15

---Find Doctors whose fees are less than 2000---
SELECT DOC_FIRST_NAME, DOC_LAST_NAME
FROM DOCTORS
WHERE EXISTS (SELECT FIRST_NAME, LAST_NAME FROM EMPLOYEE WHERE EMPLOYEE.EMPLOYEE_ID = DOCTORS.EMPLOYEE_ID AND DOC_FEE < 2000);

column 'Patient First Name' format a18
column 'Patient Last Name' format a18
column 'Patient Gender' format a18
column 'Type of Room' format a18

--Show the patient names and what rooms they're currently in
--SELECT PATIENT.FIRST_NAME "Patient First Name",
--PATIENT.LAST_NAME "Patient Last Name",
--PATIENT.GENDER "Patient Gender", 
--ROOMS.ROOM_TYPE "Type of Room" 
--FROM PATIENT, ROOMS
--WHERE PATIENT.ROOM_NO = ROOMS.ROOM_ID; 

column 'Room Type' format a10

--Show the nurse incharge of the ICU or Ward
SELECT ROOMS.ROOM_ID "Room ID", ROOMS.ROOM_TYPE "Room Type", 
ROOMS.NURSE_INCHARGE "Assigned Nurse", NURSES.NURSE_FIRST_NAME "Nurse First Name"
FROM ROOMS, NURSES 
WHERE (ROOM_TYPE = 'ICU' OR ROOM_TYPE = 'Ward')
AND ROOMS.NURSE_INCHARGE = NURSES.NURSE_ID;  

column 'Patient Name' format a16
column 'Appointment Date' format a16
column 'Appointment Time' format a16
column 'Appointment Description' format a25
column 'Doctors Name' format a16

--Show all appointments taking place in October
--SELECT CONCAT(CONCAT(PATIENT.FIRST_NAME, ' '), PATIENT.LAST_NAME) AS "Patient Name",
--RECORDS.APPOINTMENT_DATE "Appointment Date", 
--RECORDS.APPOINTMENT_TIME "Appointment Time", 
--RECORDS.APPOINTMENT_DESCRIPTION "Appointment Description",
--CONCAT(CONCAT(DOCTORS.DOC_FIRST_NAME, ' '), DOCTORS.DOC_LAST_NAME) AS "Doctors Name" 
--FROM PATIENT, RECORDS, DOCTORS
--WHERE EXTRACT(MONTH FROM RECORDS.APPOINTMENT_DATE) = '10'
--AND RECORDS.PATIENT_ID = PATIENT.PATIENT_ID
--AND RECORDS.DOCTOR_ID = DOCTORS.DOCTOR_ID; 

column 'Test Type' format a10

--Show all lab results where the patient has a temperature over '36.00'
--SELECT LABS.LAB_NO "Lab Number", PATIENT.PATIENT_ID "Patient ID", 
--CONCAT(CONCAT(PATIENT.FIRST_NAME, ' '), PATIENT.LAST_NAME) AS "Patient Name",
--LABS.TEST_TYPE "Test Type",
--LABS.TEMPERATURE "Temperature"
--FROM LABS, PATIENT
--WHERE LABS.TEMPERATURE > '36.00'
--AND PATIENT.PATIENT_ID = LABS.PATIENT_ID; 

EOF

exit; 
