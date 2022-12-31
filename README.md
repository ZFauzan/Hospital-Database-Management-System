# Hospital-Database-Management-System

## Introduction


The Hospital Management System is designed to streamline and organize day-to-day
operations in a hospital environment. The system is designed to serve several entities that exist
in hospitals included but not limited to patients, doctors, and administrators. To ensure privacy,
the database system can be accessed by entering a username and a password. However, only
the administrator or a receptionist have the permissions to enter data into the system. Doctors
and related medical staff may view the data in the system such as patient and laboratory
information to help them make informed decisions. The main goal of the Hospital Management
System is to provide key information relevant to patients and their healthcare and financial
accounting in a coherent manner that enhances the overall management of a hospital. In
addition, providing access to lab reports and essential documents in a paper-less format to
patients and the hospital staff makes this program efficient. The system should make it easy to
retrieve and/or store information about patients while being user-friendly and fast.


## Entities
The database will deal with seven entities that will have relationships (1:1 or 1:Many) with one
another in order to connect data across tables and make data manipulation easier. These seven
entities are:


● Patient - will store attributes such as patient_id, name, gender, date_of_birth,
address, illness, treatment, etc.


○ View laboratory reports


○ View detailed billing information


○ View admission history


○ View patient’s illness and the related treatment for it


● Doctor - will store attributes such as doctor_id, name, gender, address, etc.


○ View patient history


○ View patient details such as their illness and treatment


○ View laboratory reports


○ View a patient’s admission history


● Laboratory - will store attributes such as lab_number, lab_test, patient_id, date,
amount.


○ Store details about the date of lab appointments


○ Store lab results


○ Store cost to be paid for lab test


○ Automatically create views/reports to display lab reports


● Inpatient - will store attributes such as patient_id, admit_date, discharge_date,
room_number, etc.


○ Store and manage inpatient information and diagnosis


○ View what room the patient is staying in


● Outpatient - will store attributes such as patient_id, discharge_date, lab_number.


○ Store when a patient is being discharged


○ Store lab results for outgoing/walk-in patients


● Room - will store attributes such as room_number, room_type, room_status.


○ View which rooms are available/busy


○ View the types of rooms


○ View which patient is in which room


● Bill - will store attributes such as patient_id, room_charge, admit_days, lab_bills, etc.


○ Store the number of days the patient has been admitted


○ Calculate the total bill based on room type, lab results, number of days admitted
and doctor


○ Automatically create views/reports to display bills


## Relationships


The following relationships between the seven entities are discussed below:


● Patient


○ The relationship between Doctors and Patients would be One to Many. A doctor
can look over many patients but the patient only has one doctor.


● Laboratory


○ The relationship between a Patient and a Laboratory is One to Many as a patient
can be assigned several tests.


● Inpatient


○ The relationship between an Inpatient and a Room would be One to One. An
inpatient can only be admitted in one room and that room can only have one
patient.


● Outpatient


○ The relationship between an Outpatient and a Room is One to One. Outpatient
only accounts for when a patient is discharged and at this time that one patient is
only in one room.


● Room


○ The relationship between a Room and a Patient is One to One. Only one patient
would stay in each room at a time.


● Bill


○ The relationship between a Patient and their Bill is One to One. One patient
would get one bill for their specific visit
