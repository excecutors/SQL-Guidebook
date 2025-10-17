-- Q1: Employees sorted by salary
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

-- Q2: Count employees per department
SELECT d.dept_name, COUNT(e.emp_id) AS employee_count
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
GROUP BY d.dept_name
ORDER BY employee_count DESC;

-- Q3: Update salary for Finance employees (+5%)
UPDATE employees
SET salary = salary * 1.05
WHERE department_id = (SELECT dept_id FROM departments WHERE dept_name = 'Finance');

-- Q4: Seniority bucket via CASE
SELECT first_name, last_name,
  CASE
    WHEN hire_date <= '2020-01-01' THEN 'Senior'
    WHEN hire_date <= '2022-01-01' THEN 'Mid-level'
    ELSE 'Junior'
  END AS seniority
FROM employees;

-- Q5: Average salary by department
SELECT d.dept_name, ROUND(AVG(e.salary), 2) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
GROUP BY d.dept_name;

-- Q6: Rank by salary within department (uses window functions in SQLite 3.25+)
SELECT e.first_name, e.last_name, d.dept_name,
       RANK() OVER (PARTITION BY d.dept_name ORDER BY e.salary DESC) AS rank_in_dept
FROM employees e
JOIN departments d ON e.department_id = d.dept_id;

-- Q7: CTE for high earners
WITH high_earners AS (
  SELECT emp_id, first_name, salary
  FROM employees
  WHERE salary > 90000
)
SELECT * FROM high_earners ORDER BY salary DESC;

-- Q8: COALESCE example
SELECT e.first_name, COALESCE(d.dept_name, 'Unassigned') AS department
FROM employees e
LEFT JOIN departments d ON e.department_id = d.dept_id;

-- Q9: UNION example
SELECT first_name, last_name FROM employees WHERE department_id = 1
UNION
SELECT first_name, last_name FROM employees WHERE salary > 100000;

-- Q10: Latest hire per department
SELECT d.dept_name, MAX(e.hire_date) AS latest_hire
FROM employees e
JOIN departments d ON e.department_id = d.dept_id
GROUP BY d.dept_name;