#!/bin/sh

cat << EOF | sqlplus64 "username/password@(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(Host=oracle.scs.ryerson.ca)(Port=1521))(CONNECT_DATA=(SID=orcl)))"

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

EOF

exit; 
