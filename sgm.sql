CREATE TABLE "instrument" (
  "id" SERIAL PRIMARY KEY,
  "type" VARCHAR(100) NOT NULL
);
CREATE TABLE "available_time" (
  "id" SERIAL PRIMARY KEY,
  "date" DATE NOT NULL,
  "time" TIME NOT NULL
);
CREATE TABLE "student" (
  "id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(100) NOT NULL,
  "last_name" VARCHAR(100) NOT NULL,
  "ssn" VARCHAR(100) NOT NULL UNIQUE,
  "email" VARCHAR(100) NOT NULL UNIQUE,
  "phone_number" VARCHAR(100) NOT NULL
);
CREATE TABLE "sibling" (
  "id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(100) NOT NULL,
  "last_name" VARCHAR(100) NOT NULL,
  "ssn" VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE "instructor" (
  "id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(100) NOT NULL,
  "last_name" VARCHAR(100) NOT NULL,
  "ssn" VARCHAR(10) NOT NULL UNIQUE,
  "email" VARCHAR(100) NOT NULL,
  "phone_number" VARCHAR(100) NOT NULL
);
CREATE TABLE "school_instrument" (
  "id" SERIAL PRIMARY KEY,
  "instrument_type" VARCHAR(100) NOT NULL,
  "brand" VARCHAR(100) NOT NULL,
  "rent_fee" INT NOT NULL
);
CREATE TABLE "adress" (
  "id" SERIAL PRIMARY KEY,
  "student_id" INT,
  "instructor_id" INT,
  "street_name" VARCHAR(100) NOT NULL,
  "city" VARCHAR(100) NOT NULL,
  "zip" VARCHAR(10) NOT NULL,
  FOREIGN KEY ("student_id") REFERENCES "student"("id"),
  FOREIGN KEY ("instructor_id") REFERENCES "instructor"("id")
);
CREATE TABLE "instrument_inventory" (
  "school_instrument_id" INT PRIMARY KEY,
  "quantity" INT NOT NULL,
  FOREIGN KEY ("school_instrument_id") REFERENCES "school_instrument"("id")
);
CREATE TABLE "instrument_rental" (
  "id" SERIAL PRIMARY KEY,
  "student_id" INT,
  "school_instrument_id" INT NOT NULL,
  "rent_date" TIMESTAMP,
  "delivered" BOOLEAN,
  FOREIGN KEY ("student_id") REFERENCES "student"("id"),
  FOREIGN KEY ("school_instrument_id") REFERENCES "instrument_inventory"("school_instrument_id")
);
CREATE TABLE "discount" (
  "student_id" INT PRIMARY KEY,
  "percentage" DECIMAL(3, 2),
  FOREIGN KEY ("student_id") REFERENCES "student"("id")
);
CREATE TABLE "group_lesson" (
  "id" SERIAL PRIMARY KEY,
  "instructor_id" INT,
  "minimum_student" INT NOT NULL,
  "max_student" INT NOT NULL,
  "level" VARCHAR(50) NOT NULL,
  "time" TIME NOT NULL,
  "date" DATE NOT NULL,
  FOREIGN KEY ("instructor_id") REFERENCES "instructor"("id")
);

CREATE TABLE "ensemble" (
  "id" SERIAL PRIMARY KEY,
  "instructor_id" INT,
  "minimum_student" INT NOT NULL,
  "max_student" INT NOT NULL,
  "level" VARCHAR(50) NOT NULL,
  "genre" VARCHAR(50) NOT NULL,
  "time" TIME NOT NULL,
  "date" DATE NOT NULL,
  FOREIGN KEY ("instructor_id") REFERENCES "instructor"("id")
);

CREATE TABLE "individual_lesson" (
  "id" SERIAL PRIMARY KEY,
  "instructor_id" INT,
  "time" TIME NOT NULL,
  "date" DATE NOT NULL,
  FOREIGN KEY ("instructor_id") REFERENCES "instructor"("id")
);
CREATE TABLE "lesson_price" (
  "id" SERIAL PRIMARY KEY,
  "group_lesson_id" INT,
  "individual_lesson_id" INT,
  "ensemble_id" INT,
  "amount" INT NOT NULL,
  "currency" VARCHAR(10) NOT NULL,
  FOREIGN KEY ("group_lesson_id") REFERENCES "group_lesson"("id"),
  FOREIGN KEY ("individual_lesson_id") REFERENCES "individual_lesson"("id"),
  FOREIGN KEY ("ensemble_id") REFERENCES "ensemble"("id")
);
CREATE TABLE "contact_person" (
  "student_id" INT NOT NULL PRIMARY KEY,
  "first_name" VARCHAR(100) NOT NULL,
  "last_name" VARCHAR(100) NOT NULL,
  "email" VARCHAR(100) NOT NULL,
  "phone_number" VARCHAR(100) NOT NULL,
  FOREIGN KEY ("student_id") REFERENCES "student"("id")
);
CREATE TABLE "available_time_instructor" (
  "instructor_id" INT NOT NULL,
  "available_time_id" INT NOT NULL,
  PRIMARY KEY ("instructor_id", "available_time_id"),
  FOREIGN KEY ("instructor_id") REFERENCES "instructor"("id"),
  FOREIGN KEY ("available_time_id") REFERENCES "available_time"("id")
);
CREATE TABLE "student_instrument" (
  "student_id" INT NOT NULL,
  "instrument_id" INT NOT NULL,
  PRIMARY KEY ("student_id", "instrument_id"),
  "skill_level" VARCHAR(20) NOT NULL,
  FOREIGN KEY ("student_id") REFERENCES "student"("id"),
  FOREIGN KEY ("instrument_id") REFERENCES "instrument"("id")
);
CREATE TABLE "instructor_instrument" (
  "instructor_id" INT NOT NULL,
  "instrument_id" INT NOT NULL,
  PRIMARY KEY ("instructor_id", "instrument_id"),
  FOREIGN KEY ("instructor_id") REFERENCES "instructor"("id"),
  FOREIGN KEY ("instrument_id") REFERENCES "instrument"("id")
);
CREATE TABLE "student_sibling" (
  "student_id" INT NOT NULL, 
  "sibling_id" INT NOT NULL,
  PRIMARY KEY ("student_id", "sibling_id"),
  FOREIGN KEY ("student_id") REFERENCES "student"("id"),
  FOREIGN KEY ("sibling_id") REFERENCES "sibling"("id")
);