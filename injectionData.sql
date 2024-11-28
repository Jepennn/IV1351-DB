-- Lägg till data i instrument tabellen
INSERT INTO "instrument" ("type") VALUES ('Guitar');
INSERT INTO "instrument" ("type") VALUES ('Piano');

-- Lägg till data i student tabellen
INSERT INTO "student" ("first_name", "last_name", "ssn", "email", "phone_number") VALUES ('John', 'Doe', '1234567890', 'john.doe@example.com', '123-456-7890');
INSERT INTO "student" ("first_name", "last_name", "ssn", "email", "phone_number") VALUES ('Jane', 'Smith', '0987654321', 'jane.smith@example.com', '098-765-4321');

-- Lägg till data i sibling tabellen
INSERT INTO "sibling" ("first_name", "last_name", "ssn") VALUES ('Emily', 'Doe', '1234567891');
INSERT INTO "sibling" ("first_name", "last_name", "ssn") VALUES ('Michael', 'Smith', '0987654322');

-- Lägg till data i instructor tabellen
INSERT INTO "instructor" ("first_name", "last_name", "ssn", "email", "phone_number") VALUES ('Alice', 'Johnson', '1234567892', 'alice.johnson@example.com', '123-456-7891');
INSERT INTO "instructor" ("first_name", "last_name", "ssn", "email", "phone_number") VALUES ('Bob', 'Brown', '0987654323', 'bob.brown@example.com', '098-765-4322');

-- Lägg till data i school_instrument tabellen
INSERT INTO "school_instrument" ("instrument_type", "brand", "rent_fee") VALUES ('Guitar', 'Yamaha', 100);
INSERT INTO "school_instrument" ("instrument_type", "brand", "rent_fee") VALUES ('Piano', 'Steinway', 200);

-- Lägg till data i adress tabellen
INSERT INTO "adress" ("student_id", "instructor_id", "street_name", "city", "zip") VALUES (1, NULL, 'Main St', 'Cityville', '12345');
INSERT INTO "adress" ("student_id", "instructor_id", "street_name", "city", "zip") VALUES (NULL, 1, 'Second St', 'Townsville', '67890');

-- Lägg till data i instrument_inventory tabellen
INSERT INTO "instrument_inventory" ("school_instrument_id", "quantity") VALUES (1, 10);
INSERT INTO "instrument_inventory" ("school_instrument_id", "quantity") VALUES (2, 5);

-- Lägg till data i instrument_rental tabellen
INSERT INTO "instrument_rental" ("student_id", "school_instrument_id", "rent_date", "delivered") VALUES (1, 1, '2023-10-01 10:00:00', FALSE);
INSERT INTO "instrument_rental" ("student_id", "school_instrument_id", "rent_date", "delivered") VALUES (2, 2, '2023-10-02 14:00:00', TRUE);

-- Lägg till data i discount tabellen
INSERT INTO "discount" ("student_id", "percentage") VALUES (1, 0.10);
INSERT INTO "discount" ("student_id", "percentage") VALUES (2, 0.10);

-- Lägg till data i group_lesson tabellen
INSERT INTO "group_lesson" ("instructor_id", "minimum_student", "max_student", "level", "time", "date") VALUES (1, 5, 10, 'Beginner', '10:00:00', '2023-10-01');
INSERT INTO "group_lesson" ("instructor_id", "minimum_student", "max_student", "level", "time", "date") VALUES (2, 3, 8, 'Intermediate', '14:00:00', '2023-10-02');

-- Lägg till data i ensemble tabellen
INSERT INTO "ensemble" ("instructor_id", "minimum_student", "max_student", "level", "genre", "time", "date") VALUES (1, 4, 12, 'Advanced', 'Jazz', '11:00:00', '2023-10-01');
INSERT INTO "ensemble" ("instructor_id", "minimum_student", "max_student", "level", "genre", "time", "date") VALUES (2, 6, 15, 'Intermediate', 'Classical', '15:00:00', '2023-10-02');

-- Lägg till data i individual_lesson tabellen
INSERT INTO "individual_lesson" ("instructor_id", "time", "date") VALUES (1, '09:00:00', '2023-10-01');
INSERT INTO "individual_lesson" ("instructor_id", "time", "date") VALUES (2, '13:00:00', '2023-10-02');

-- Lägg till data i lesson_price tabellen
INSERT INTO "lesson_price" ("group_lesson_id", "individual_lesson_id", "ensemble_id", "amount", "currency") VALUES (1, NULL, NULL, 50, 'USD');
INSERT INTO "lesson_price" ("group_lesson_id", "individual_lesson_id", "ensemble_id", "amount", "currency") VALUES (NULL, 1, NULL, 75, 'USD');
INSERT INTO "lesson_price" ("group_lesson_id", "individual_lesson_id", "ensemble_id", "amount", "currency") VALUES (NULL, NULL, 1, 100, 'USD');

-- Lägg till data i contact_person tabellen
INSERT INTO "contact_person" ("student_id", "first_name", "last_name", "email", "phone_number") VALUES (1, 'Mary', 'Doe', 'mary.doe@example.com', '123-456-7893');
INSERT INTO "contact_person" ("student_id", "first_name", "last_name", "email", "phone_number") VALUES (2, 'James', 'Smith', 'james.smith@example.com', '098-765-4323');

-- Lägg till data i available_time tabellen
INSERT INTO "available_time" ("date", "time") VALUES ('2023-10-01', '09:00:00');
INSERT INTO "available_time" ("date", "time") VALUES ('2023-10-02', '13:00:00');

-- Lägg till data i available_time_instructor tabellen
INSERT INTO "available_time_instructor" ("instructor_id", "available_time_id") VALUES (1, 1);
INSERT INTO "available_time_instructor" ("instructor_id", "available_time_id") VALUES (2, 2);

-- Lägg till data i student_instrument tabellen
INSERT INTO "student_instrument" ("student_id", "instrument_id", "skill_level") VALUES (1, 1, 'Beginner');
INSERT INTO "student_instrument" ("student_id", "instrument_id", "skill_level") VALUES (2, 2, 'Intermediate');

-- Lägg till data i instructor_instrument tabellen
INSERT INTO "instructor_instrument" ("instructor_id", "instrument_id") VALUES (1, 1);
INSERT INTO "instructor_instrument" ("instructor_id", "instrument_id") VALUES (2, 2);

-- Lägg till data i student_sibling tabellen
INSERT INTO "student_sibling" ("student_id", "sibling_id") VALUES (1, 1);
INSERT INTO "student_sibling" ("student_id", "sibling_id") VALUES (2, 2);