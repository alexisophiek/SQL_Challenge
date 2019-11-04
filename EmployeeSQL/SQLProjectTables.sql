-- DROP TABLE department_managers

CREATE TABLE departments
	(dept_no VARCHAR PRIMARY KEY NOT NULL,
	dept_name VARCHAR UNIQUE
	);

CREATE TABLE employees
	(emp_no INT PRIMARY KEY NOT NULL,
	 birth_date DATE,
	 first_name VARCHAR,
	 last_name VARCHAR,
	 gender VARCHAR,
	 hire_date DATE
	);

CREATE TABLE titles
	(emp_no INTEGER,
	 title VARCHAR,
	 from_date DATE,
	 to_date DATE
	);

CREATE TABLE salaries
	(emp_no INT,
	 salary MONEY,
	 from_date DATE,
	 to_date DATE,
	 FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	 PRIMARY KEY (emp_no)
	);

CREATE TABLE department_managers
	(dept_no VARCHAR,
	 emp_no INTEGER,
	 from_date DATE,
	 to_date DATE
	);


CREATE TABLE department_employees
	(emp_no INT,
	 dept_no VARCHAR,
	 from_date DATE,
	 to_date DATE);
	

ALTER TABLE department_employees 
ADD CONSTRAINT emp_no FOREIGN KEY (emp_no) REFERENCES employees (emp_no);

ALTER TABLE department_managers 
ADD CONSTRAINT dept_no FOREIGN KEY (dept_no) REFERENCES departments (dept_no);
 
 
 --1. List each employee: employee number, last name, first name, gender, and salary.
SELECT emp_no, last_name, first_name, gender, salary 
FROM employees
NATURAL JOIN salaries;

---2. List employees who were hired in 1986.
SELECT * 
FROM employees 
WHERE EXTRACT (year FROM hire_date) = 1986;

--3. List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM departments d, department_managers dm, employees e
WHERE d.dept_no = dm.dept_no and dm.emp_no = e.emp_no;

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e, departments d, department_employees de
WHERE e.emp_no = de.emp_no and d.dept_no = de.dept_no;

--5. List all employees whose first name is "Hercules" 
--and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';


--6. List all employees in the Sales department, 
-- including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e, departments d, department_employees de
WHERE e.emp_no = de.emp_no and d.dept_no = de.dept_no and dept_name = 'Sales';


--7. List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e, departments d, department_employees de
WHERE e.emp_no = de.emp_no 
AND d.dept_no = de.dept_no AND dept_name IN ('Sales','Development');

--8. In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.
SELECT COUNT(last_name), last_name
FROM employees
GROUP BY last_name
ORDER BY count DESC;


--BONUS!