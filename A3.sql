---Zunaira Fauzan 500975247
---Hamdia Abdulhafiz Abdullahi 500975140
---Fatima Jawed 500939913


---code to create the tables and define primary and foreign keys-----
CREATE TABLE patient (
    patient_id    NUMBER NOT NULL,
    first_name    VARCHAR2(50 CHAR),
    last_name     VARCHAR2(50 CHAR),
    nationality   VARCHAR2(25 CHAR),
    gender        VARCHAR2(10 CHAR),
    address       VARCHAR2(50 CHAR),
    date_of_birth DATE,
    phone_no      NUMBER,
    email_address VARCHAR2(50 CHAR)
);
ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( patient_id );

CREATE TABLE employee (
    employee_id   NUMBER NOT NULL,
    first_name    VARCHAR2(50 CHAR),
    last_name     VARCHAR2(50 CHAR),
    position      VARCHAR2(50 CHAR),
    salary        NUMBER,
    phone_no      NUMBER,
    email_address VARCHAR2(50 CHAR)
);

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employee_id );

CREATE TABLE doctors (
    employee_id    NUMBER NOT NULL,
    doctor_id      NUMBER NOT NULL,
    doc_first_name VARCHAR2(50 CHAR),
    doc_last_name  VARCHAR2(50 CHAR),
    specialisation VARCHAR2(50 CHAR),
    shift_start    DATE,
    shift_end      DATE
);

ALTER TABLE doctors ADD CONSTRAINT doctors_pkv1 PRIMARY KEY ( employee_id );

ALTER TABLE doctors ADD CONSTRAINT doctors_pkv2 UNIQUE ( doctor_id );

ALTER TABLE doctors
    ADD CONSTRAINT doctors_employee_fk FOREIGN KEY ( employee_id )
        REFERENCES employee ( employee_id );
        
CREATE TABLE receptionists (
    employee_id NUMBER NOT NULL,
    receptionist_first_name VARCHAR2(50 CHAR),
    receptionist_last_name VARCHAR2(50 CHAR),
    shift_start DATE,
    shift_end   DATE
);

ALTER TABLE receptionists ADD CONSTRAINT receptionists_pk PRIMARY KEY ( employee_id );

ALTER TABLE receptionists
    ADD CONSTRAINT receptionists_employee_fk FOREIGN KEY ( employee_id )
        REFERENCES employee ( employee_id );
        
CREATE TABLE nurses (
    employee_id NUMBER NOT NULL,
    nurse_id    NUMBER NOT NULL,
    Nurse_first_name VARCHAR2(50 CHAR),
    Nurse_last_name VARCHAR2(50 CHAR),
    shift_start DATE,
    shift_end   DATE
);

ALTER TABLE nurses ADD CONSTRAINT nurses_pk PRIMARY KEY ( employee_id );

ALTER TABLE nurses ADD CONSTRAINT nurses_pkv1 UNIQUE ( nurse_id );

ALTER TABLE nurses
    ADD CONSTRAINT nurses_employee_fk FOREIGN KEY ( employee_id )
        REFERENCES employee ( employee_id );
        
        
CREATE TABLE records (
    appointment_id          NUMBER NOT NULL,
    patient_id              NUMBER NOT NULL,
    created_date            DATE,
    appointment_date        DATE,
    appointment_time        DATE,
    appointment_description VARCHAR2(50),
    doctor_id               NUMBER NOT NULL
);

ALTER TABLE records ADD CONSTRAINT records_pk PRIMARY KEY ( appointment_id,
                                                            patient_id );

ALTER TABLE records
    ADD CONSTRAINT table_14_doctors_fk FOREIGN KEY ( doctor_id )
        REFERENCES doctors ( doctor_id );

ALTER TABLE records
    ADD CONSTRAINT table_14_patient_fk FOREIGN KEY ( patient_id )
        REFERENCES patient ( patient_id );

CREATE TABLE rooms (
    room_id        NUMBER NOT NULL,
    status         VARCHAR2(15 CHAR),
    room_type      VARCHAR2(50),
    nurse_incharge NUMBER NOT NULL
);

ALTER TABLE rooms
    ADD CONSTRAINT rooms_nurses_fk FOREIGN KEY ( nurse_incharge )
        REFERENCES nurses ( nurse_id );
        
ALTER TABLE patient 
ADD room_no NUMBER;

ALTER TABLE rooms ADD CONSTRAINT rooms_pk PRIMARY KEY ( room_id );

ALTER TABLE patient
    ADD CONSTRAINT patient_rooms_fk FOREIGN KEY ( room_no )
        REFERENCES rooms ( room_id );
        
ALTER TABLE doctors
ADD doc_fee NUMBER;

CREATE TABLE test_price (
    test_code  NUMBER NOT NULL,
    test_price NUMBER
);
ALTER TABLE test_price ADD CONSTRAINT test_price_pk PRIMARY KEY ( test_code );   

CREATE TABLE labs (
    lab_no         NUMBER NOT NULL,
    patient_id     NUMBER NOT NULL,
    test_type      VARCHAR2(25),
    "Date"         DATE,
    blood_pressure NUMBER,
    temperature    NUMBER,
    blood_type     VARCHAR2(25 CHAR),
    test_code      NUMBER NOT NULL
);

ALTER TABLE labs ADD CONSTRAINT labs_pk PRIMARY KEY ( lab_no,
                                                      patient_id );

ALTER TABLE labs
    ADD CONSTRAINT labs_patient_fk FOREIGN KEY ( patient_id )
        REFERENCES patient ( patient_id );

ALTER TABLE labs
    ADD CONSTRAINT labs_test_price_fk FOREIGN KEY ( test_code )
        REFERENCES test_price ( test_code );
        
CREATE TABLE bills (
    bill_no    NUMBER NOT NULL,
    patient_id NUMBER NOT NULL,
    doc_fee    NUMBER,
    lab_fee    NUMBER,
    total      NUMBER
);

ALTER TABLE bills ADD CONSTRAINT bills_pk PRIMARY KEY ( bill_no,
                                                        patient_id );

ALTER TABLE bills
    ADD CONSTRAINT table_10_patient_fk FOREIGN KEY ( patient_id )
        REFERENCES patient ( patient_id );


---code to insert dummy data---

INSERT INTO patient VALUES 
	('1234', 'Marcus', 'Domitius', 'Italian', 'Male', '37 Cel Street', TO_DATE('22/April/1999','DD/MON/YY'), '4223333701', 'marcusd@gmail.com', '12'); 
 
INSERT INTO patient VALUES 
	('4556', 'Killian', 'Calorian', 'Canadian', 'Male', '12 Lent Avenue', TO_DATE('03/August/2000','DD/MON/YY'), '0513478288', 'killian@gmail.com', '42'); 

INSERT INTO patient VALUES 
	('3458', 'Felix', 'Cole', 'French', 'Male', '43 Robstone Drive', TO_DATE('29/June/2003','DD/MON/YY'), '1111256754', 'felix@gmail.com', '002'); 

INSERT INTO employee VALUES 
	('11112', 'Derrek', 'Shepperd', 'Doctor', '88000.00', '4222997272', 'shepperdd@gmail.com'); 
INSERT INTO employee VALUES 
	('11113', 'Meredith', 'Grey', 'Doctor', '86000.00', '0558699231', 'greym@gmail.com'); 
INSERT INTO employee VALUES 
	('11114', 'Addison', 'Shepperd', 'Doctor', '85000.00', '0556383973', 'shepperda@gmail.com'); 
INSERT INTO employee VALUES 
	('11115', 'Cristina', 'Yang', 'Doctor', '90000.00', '6225348266', 'yangc@gmail.com'); 
INSERT INTO employee VALUES 
	('22220', 'George', 'Malley', 'Nurse', '41000.00', '4102623421', 'malleyg@gmail.com'); 
INSERT INTO employee VALUES 
	('22221', 'Isabel', 'Stevens', 'Nurse', '40000.00', '4232985631', 'stevensi@gmail.com'); 
INSERT INTO employee VALUES 
	('22223', 'Rose', 'Karev', 'Nurse', '38000.00', '4227688422', 'karevr@gmail.com'); 
INSERT INTO employee VALUES 
	('33330', 'Miranda', 'Bailey', 'Receptionist', '27000.00', '6471119999', 'baileym@gmail.com'); 
INSERT INTO employee VALUES 
	('33331', 'Owen', 'Hunt', 'Receptionist', '27500.00', '6472223033', 'hunto@gmail.com'); 

INSERT INTO doctors VALUES 
	('11112', '2556', 'Derrek', 'Shepperd', 'Neurosurgeon', TO_DATE('17/October/2021 08:30:00AM','DD/MON/YY HH:MI:SSAM'), TO_DATE('17/October/2011 07:30:00PM','DD/MON/YY HH:MI:SSPM'), '2037.00');
INSERT INTO doctors VALUES 
	('11113', '2434', 'Meredith', 'Grey', 'Eye Specialist', TO_DATE('17/October/2021 06:00:00AM','DD/MON/YY HH:MI:SSAM'), TO_DATE('17/October/2011 09:30:00PM','DD/MON/YY HH:MI:SSPM'), '1703.00');
INSERT INTO doctors VALUES 
	('11114', '2818', 'Addison', 'Shepperd', 'Gynacologist', TO_DATE('17/October/2021 11:30:00AM','DD/MON/YY HH:MI:SSAM'), TO_DATE('17/October/2011 11:30:00PM','DD/MON/YY HH:MI:SSPM'), '1034.86');
INSERT INTO doctors VALUES 
	('11115', '2209', 'Cristina', 'Yang', 'Family Doctor', TO_DATE('17/October/2021 06:30:00AM','DD/MON/YY HH:MI:SSAM'), TO_DATE('17/October/2011 11:30:00PM','DD/MON/YY HH:MI:SSPM'), '2075.60');

INSERT INTO receptionists VALUES 
	('33330', 'Miranda', 'Bailey', TO_DATE('17/October/2021 08:00:00AM','DD/MON/YY HH:MI:SSAM'), TO_DATE('17/October/2011 06:00:00PM','DD/MON/YY HH:MI:SSPM'));
INSERT INTO receptionists VALUES 
	('33331', 'Owen', 'Hunt', TO_DATE('17/October/2021 06:00:00PM','DD/MON/YY HH:MI:SSPM'), TO_DATE('18/October/2011 12:00:00AM','DD/MON/YY HH:MI:SSAM'));

INSERT INTO nurses VALUES 
	('22220', '3773', 'George', 'Malley', TO_DATE('17/October/2021 06:00:00AM','DD/MON/YY HH:MI:SSAM'), TO_DATE('17/October/2011 12:00:00PM','DD/MON/YY HH:MI:SSPM'));
INSERT INTO nurses VALUES 
	('22221', '3023', 'Isabel', 'Stevens', TO_DATE('17/October/2021 12:00:00PM','DD/MON/YY HH:MI:SSPM'), TO_DATE('17/October/2011 06:00:00PM','DD/MON/YY HH:MI:SSPM'));
INSERT INTO nurses VALUES 
	('22223', '3145', 'Rose', 'Karev', TO_DATE('17/October/2021 06:00:00PM','DD/MON/YY HH:MI:SSPM'), TO_DATE('18/October/2011 12:00:00AM','DD/MON/YY HH:MI:SSAM'));

INSERT INTO records VALUES 
	('0084', '1234', TO_DATE('01/October/2021','DD/MON/YY'), TO_DATE('17/October/2021','DD/MON/YY'), TO_DATE('17/October/2021 08:45:00AM','DD/MON/YY HH:MI:SSAM'), 'Surgery', '2556'); 
INSERT INTO records VALUES 
	('0026', '4556', TO_DATE('09/October/2021','DD/MON/YY'), TO_DATE('13/October/2021','DD/MON/YY'), TO_DATE('13/October/2021 09:35:00AM','DD/MON/YY HH:MI:SSAM'), 'Eye Test', '2434'); 
INSERT INTO records VALUES 
	('0098', '3458', TO_DATE('02/October/2021','DD/MON/YY'), TO_DATE('05/October/2021','DD/MON/YY'), TO_DATE('05/October/2021 09:55:00AM','DD/MON/YY HH:MI:SSAM'), 'Follow up', '2818'); 

INSERT INTO rooms VALUES 
	('12', 'occupied', 'ICU', '3773');
INSERT INTO rooms VALUES 
	('42', 'occupied', 'Ward', '3023');
INSERT INTO rooms VALUES 
	('002', 'occupied', 'Operating Room', '3145');


INSERT INTO test_price VALUES 
	('0052', '302.85'); 
INSERT INTO test_price VALUES 
	('0056', '99.72'); 
INSERT INTO test_price VALUES 
	('0012', '38.25'); 
INSERT INTO test_price VALUES 
	('0037', '350.00'); 
INSERT INTO test_price VALUES 
	('0026', '95.00'); 

INSERT INTO labs VALUES 
	('04', '1234', 'CT Scan', TO_DATE('01/October/2021','DD/MON/YY'), '122', '39.30', 'B pos', '0052'); 
INSERT INTO labs VALUES 
	('02', '4556', 'Eye Test', TO_DATE('08/October/2021','DD/MON/YY'), '120', '35.98', 'AB pos', '0012');  
INSERT INTO labs VALUES 
	('01', '3458', 'X-RAY', TO_DATE('15/October/2021','DD/MON/YY'), '116', '37.13', 'B neg', '0026'); 

INSERT INTO bills VALUES 
	('5555', '1234', '2037.00', '302.85', '2412.11');
INSERT INTO bills VALUES 
	('5522', '4556', '1703.00', '38.25', '1112.45');
INSERT INTO bills VALUES 
	('5500', '3458', '1034.86', '95.00', '1312.02');
    
