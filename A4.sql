---Hamdia Abdulhafiz Abdullahi 500975140
---Fatima Jawed 500939913
---Zunaira Fauzan 500975247

--------------- SIMPLE QUERIES---------------

--Show all patients whose lab fee is below $100.00
SELECT BILL_NO "Bill Number",  
PATIENT_ID "Patient ID",
LAB_FEE "Lab Fee" 
FROM BILLS
WHERE LAB_FEE < 100.00; 

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

--Show patients whose blood type is not O negative, and has blood pressure of at least 120
SELECT * FROM LABS 
WHERE BLOOD_TYPE <> 'O neg'
AND BLOOD_PRESSURE >= 120
ORDER BY BLOOD_PRESSURE; 

--Show all attributes of nurses sorted by last name in a descending order
SELECT CONCAT(CONCAT(NURSE_LAST_NAME, ', '), NURSE_FIRST_NAME) AS "Nurse Name", 
EMPLOYEE_ID "Employee ID", NURSE_ID "Nurse ID" 
FROM NURSES;

--Show patients such that their patient id is in ascending order but their phone numbers are in a decending order
SELECT PATIENT_ID "Patient ID", FIRST_NAME "First Name", LAST_NAME "Last Name", PHONE_NO 
FROM PATIENT
ORDER BY PATIENT_ID, PHONE_NO DESC; 

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

--Show patients who have a surgery or a follow up appointment
SELECT DISTINCT PATIENT_ID AS PATIENT_IDS, APPOINTMENT_ID "Appointment ID", 
APPOINTMENT_DESCRIPTION "Appointment Description", DOCTOR_ID "Doctor ID" 
FROM RECORDS 
WHERE APPOINTMENT_DESCRIPTION LIKE 'Surgery' OR APPOINTMENT_DESCRIPTION LIKE 'Follow up'
ORDER BY PATIENT_ID; 

--Show all attributes of occupied rooms that are not Ward rooms
SELECT * FROM ROOMS 
WHERE STATUS = 'occupied' 
AND NOT(ROOM_TYPE = 'Ward'); 

--Show all attributes of the test-price table such that the test price is greater than 100 or less than 50 
SELECT * FROM TEST_PRICE 
WHERE TEST_PRICE > 100 OR TEST_PRICE < 50
ORDER BY TEST_CODE; 


---------------ADVANCED QUERIES---------------

--Show the patient names and what rooms they're currently in
SELECT PATIENT.FIRST_NAME "Patient First Name",
PATIENT.LAST_NAME "Patient Last Name",
PATIENT.GENDER "Patient Gender", 
ROOMS.ROOM_TYPE "Type of Room" 
FROM PATIENT, ROOMS
WHERE PATIENT.ROOM_NO = ROOMS.ROOM_ID; 

--Show the nurse incharge of the ICU or Ward
SELECT ROOMS.ROOM_ID "Room ID", ROOMS.ROOM_TYPE "Room Type", 
ROOMS.NURSE_INCHARGE "Assigned Nurse", NURSES.NURSE_FIRST_NAME "Nurse First Name"
FROM ROOMS, NURSES 
WHERE (ROOM_TYPE = 'ICU' OR ROOM_TYPE = 'Ward')
AND ROOMS.NURSE_INCHARGE = NURSES.NURSE_ID;  

--Show all appointments taking place in October
SELECT CONCAT(CONCAT(PATIENT.FIRST_NAME, ' '), PATIENT.LAST_NAME) AS "Patient Name",
RECORDS.APPOINTMENT_DATE "Appointment Date", 
RECORDS.APPOINTMENT_TIME "Appointment Time", 
RECORDS.APPOINTMENT_DESCRIPTION "Appointment Description",
CONCAT(CONCAT(DOCTORS.DOC_FIRST_NAME, ' '), DOCTORS.DOC_LAST_NAME) AS "Doctors Name" 
FROM PATIENT, RECORDS, DOCTORS
WHERE EXTRACT(MONTH FROM RECORDS.APPOINTMENT_DATE) = '10'
AND RECORDS.PATIENT_ID = PATIENT.PATIENT_ID
AND RECORDS.DOCTOR_ID = DOCTORS.DOCTOR_ID; 

--Show all lab results where the patient has a temperature over '36.00'
SELECT LABS.LAB_NO "Lab Number", PATIENT.PATIENT_ID "Patient ID", 
CONCAT(CONCAT(PATIENT.FIRST_NAME, ' '), PATIENT.LAST_NAME) AS "Patient Name",
LABS.TEST_TYPE "Test Type",
LABS.TEMPERATURE "Temperature"
FROM LABS, PATIENT
WHERE LABS.TEMPERATURE > '36.00'
AND PATIENT.PATIENT_ID = LABS.PATIENT_ID; 


---------------VIEWS---------------

--How many nurses in each of the rooms?
CREATE VIEW Number_of_Nurses_in_Each_Room AS
SELECT COUNT(NURSE_INCHARGE) "Number of Nurses", ROOM_TYPE "Type of Room"
FROM ROOMS
GROUP BY ROOM_TYPE;

SELECT * FROM Number_of_Nurses_in_Each_Room;

--Show upcoming appointments of patients with their doctors and appointment details 
CREATE VIEW Upcoming_Appointments AS
SELECT CONCAT(CONCAT(PATIENT.FIRST_NAME,' '),PATIENT.LAST_NAME) AS "Patient Name",
CONCAT(CONCAT(DOCTORS.DOC_FIRST_NAME, ' '), DOCTORS.DOC_LAST_NAME) AS "Doctor Name",
RECORDS.APPOINTMENT_DATE AS "Appointment Date", RECORDS.APPOINTMENT_DESCRIPTION AS "Appointment Description"
FROM PATIENT, DOCTORS, RECORDS
WHERE PATIENT.PATIENT_ID = RECORDS.PATIENT_ID
AND DOCTORS.DOCTOR_ID = RECORDS.DOCTOR_ID
ORDER BY RECORDS.APPOINTMENT_DATE;

SELECT * FROM Upcoming_Appointments; 

--How many patients got each type of lab test done?
CREATE VIEW Patients_per_Treatment AS
SELECT COUNT(PATIENT_ID) "Number of Patients", DISTINCT TEST_TYPE "Type of Lab Test"
FROM LABS 
GROUP BY TEST_TYPE;

SELECT * FROM Patients_per_Treatment; 



