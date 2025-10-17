# SQL-Guidebook

# Week 7 Major Assignment: Personal SQL Guidebook

---

## 🎯 Objective

This README serves as a personal SQL reference guidebook, a concise and practical collection of essential SQL syntax, examples, and real queries. It demonstrates a clear understanding of SQL fundamentals and advanced concepts, designed as a reusable guide for anyone exploring data analysis, database management, or general SQL problem-solving.

---

## 🧱 1. Table Creation & Data Setup

### Example Schema (PostgreSQL / SQLite)

```sql
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    department_id INTEGER,
    salary NUMERIC,
    hire_date DATE
);

CREATE TABLE departments (
    dept_id INTEGER PRIMARY KEY,
    dept_name TEXT
);

INSERT INTO departments (dept_id, dept_name)
VALUES (1, 'Engineering'), (2, 'Finance'), (3, 'Marketing');

INSERT INTO employees (emp_id, first_name, last_name, department_id, salary, hire_date)
VALUES
(101, 'Alice', 'Wang', 1, 95000, '2021-04-01'),
(102, 'Bob', 'Smith', 2, 88000, '2020-11-10'),
(103, 'Charlie', 'Kim', 1, 105000, '2019-02-22'),
(104, 'Diana', 'Chen', 3, 76000, '2022-07-14'),
(105, 'Evan', 'Lee', 2, 99000, '2021-09-30');
```

### Tip

Use small, realistic datasets (5–10 rows per table) so you can easily test JOINs and window functions.

---

## 2. Questions & Queries

### Q1. Retrieve all employees sorted by salary

```sql
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;
```

**Purpose:** Demonstrates SELECT, FROM, ORDER BY.

---

### Q2. Count employees per department

```sql
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
GROUP BY d.dept_name
ORDER BY employee_count DESC;
```

**Purpose:** Demonstrates INNER JOIN and GROUP BY.

---

### Q3. Update salary for Finance employees

```sql
UPDATE employees
SET salary = salary * 1.05
WHERE department_id = (SELECT dept_id FROM departments WHERE dept_name = 'Finance');
```

**Purpose:** Demonstrates UPDATE with subquery.

---

### Q4. Add a computed column for seniority

```sql
SELECT first_name, last_name,
    CASE
        WHEN hire_date <= '2020-01-01' THEN 'Senior'
        WHEN hire_date <= '2022-01-01' THEN 'Mid-level'
        ELSE 'Junior'
    END AS seniority
FROM employees;
```

**Purpose:** Demonstrates data transformation using CASE WHEN.

---

### Q5. Average salary by department

```sql
SELECT d.dept_name, ROUND(AVG(e.salary), 2) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
GROUP BY d.dept_name;
```

**Purpose:** Demonstrates aggregation (AVG) and JOIN.

---

### Q6. Rank employees by salary within department

```sql
SELECT e.first_name, e.last_name, d.dept_name,
       RANK() OVER (PARTITION BY d.dept_name ORDER BY e.salary DESC) AS rank_in_dept
FROM employees e
JOIN departments d ON e.department_id = d.dept_id;
```

**Purpose:** Demonstrates window functions (RANK, PARTITION BY).

---

### Q7. Common Table Expression (CTE) for high earners

```sql
WITH high_earners AS (
    SELECT emp_id, first_name, salary
    FROM employees
    WHERE salary > 90000
)
SELECT * FROM high_earners ORDER BY salary DESC;
```

**Purpose:** Demonstrates CTE and modular query design.

---

### Q8. Using COALESCE for null-safe joins

```sql
SELECT e.first_name, COALESCE(d.dept_name, 'Unassigned') AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.dept_id;
```

**Purpose:** Demonstrates COALESCE for handling NULL values.

---

### Q9. Combine data from multiple queries

```sql
SELECT first_name, last_name FROM employees WHERE department_id = 1
UNION
SELECT first_name, last_name FROM employees WHERE salary > 100000;
```

**Purpose:** Demonstrates UNION.

---

### Q10. Find the most recent hire date per department

```sql
SELECT d.dept_name, MAX(e.hire_date) AS latest_hire
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
GROUP BY d.dept_name;
```

**Purpose:** Demonstrates GROUP BY with aggregate MAX.

---

## 3. Advanced SQL Features Explored Independently

| Feature                | Description                        | Example                                                                                    |
| ---------------------- | ---------------------------------- | ------------------------------------------------------------------------------------------ |
| **DATE Functions**     | Extract year/month/day from a date | `SELECT EXTRACT(YEAR FROM hire_date) FROM employees;`                                      |
| **String Functions**   | Combine or format text fields      | `SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;`                   |
| **LEAD/LAG**           | Compare salary with previous row   | `SELECT emp_id, salary, LAG(salary) OVER (ORDER BY salary) AS prev_salary FROM employees;` |
| **EXCEPT / INTERSECT** | Compare query results              | `SELECT emp_id FROM employees EXCEPT SELECT emp_id FROM departments;`                      |

---

## 4. Output Samples

> *(Include screenshots or sample results here for submission)*

| Query                              | Sample Output           |
| ---------------------------------- | ----------------------- |
| Q2: Count employees per department | <img width="710" height="128" alt="image" src="https://github.com/user-attachments/assets/fbf98f4a-4f87-460c-ac10-9da66fea8fa7" />
 |
| Q6: Rank by salary                 | <img width="1175" height="185" alt="image" src="https://github.com/user-attachments/assets/c2260ade-b4ee-4d30-8833-f21d862ea9d8" />
  |

---

## 5. Guidebook Summary

* **Basic Queries:** SELECT, WHERE, ORDER BY
* **Aggregations:** COUNT, AVG, SUM, GROUP BY, HAVING
* **JOINS:** INNER, LEFT, RIGHT, FULL
* **Data Cleaning:** CASE WHEN, COALESCE
* **Window Functions:** RANK, ROW_NUMBER, LEAD, LAG
* **CTEs & Subqueries:** Modular and readable SQL
* **Independent Features:** String and Date manipulation, UNION, EXCEPT

---

## Submission Checklist

* [x] Multiple tables created and populated
* [x] 10 queries demonstrating SQL mastery
* [x] Advanced SQL features included
* [x] Screenshots or sample outputs attached
* [x] Explanations added under each query

---
