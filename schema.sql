-- Drop tables if re-running
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Tables
CREATE TABLE departments (
  dept_id INTEGER PRIMARY KEY,
  dept_name TEXT NOT NULL
);

CREATE TABLE employees (
  emp_id INTEGER PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name  TEXT NOT NULL,
  department_id INTEGER,
  salary NUMERIC,
  hire_date TEXT, -- ISO string 'YYYY-MM-DD' is fine for SQLite
  FOREIGN KEY (department_id) REFERENCES departments(dept_id)
);