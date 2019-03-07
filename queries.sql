-- Connect By Root
SELECT first_name "Employee", CONNECT_BY_ROOT last_name "Manager",
LEVEL "Pathlen", SYS_CONNECT_BY_PATH(last_name, '/') "Path"
FROM employees
CONNECT BY PRIOR employee_id = manager_id;

-- Connect By Is Cycle
SELECT employee_id AS "Employee ID", first_name AS "Employee Name", job_id AS "Job ID", PRIOR first_name AS "Manager Name"
FROM employees
START WITH manager_id IS NULL
CONNECT BY nocycle manager_id = PRIOR employee_id
ORDER BY employee_id;

-- Connect By Is Leaf
SELECT employee_id AS "Employee ID", first_name AS "Employee Name", job_id AS "Job ID", PRIOR first_name AS "Manager Name", CONNECT_BY_ISLEAF "Is Not A Manager"
FROM employees
START WITH manager_id IS NULL
CONNECT BY manager_id = PRIOR employee_id
ORDER BY employee_id;

-- Level
SELECT employee_id AS "Employee ID", first_name AS "Employee Name", job_id AS "Job ID", PRIOR first_name AS "Manager Name", LEVEL "Employee Level"
FROM employees
START WITH manager_id IS NULL
CONNECT BY
manager_id = PRIOR employee_id
ORDER BY employee_id;

-- Self Join Solution
SELECT e1.employee_id AS "Employee ID", e1.first_name AS "Employee Name", e1.job_id AS "Job ID", e2.first_name AS "Manager Name"
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id
ORDER BY e1.employee_id;

-- Same as before, with hierarchical
SELECT employee_id AS "Employee ID", first_name AS "Employee Name", job_id AS "Job ID", PRIOR first_name AS "Manager Name"
FROM employees
START WITH manager_id IS NULL
CONNECT BY
manager_id = PRIOR employee_id
ORDER BY employee_id;
