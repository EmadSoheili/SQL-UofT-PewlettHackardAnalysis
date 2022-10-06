-- Create retirement eligibility table

SELECT
	emp_no,
	first_name,
	last_name
INTO
	retirement_info
FROM
	employees
WHERE
	(birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND
	(hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Check the table
	
SELECT * FROM retirement_info;


-- Sample Join
SELECT
	d.dept_name,
	mg.emp_no,
	mg.from_date,
	mg.to_date
FROM
	departments AS d
	INNER Join
	managers AS mg
	ON
	d.dept_no = mg.dept_no;
	

-- Join retirement_info and dept_emp tables
SELECT 
	r.emp_no,
	r.first_name,
	r.last_name,
	d.to_date
INTO
	current_emp
FROM
	retirement_info AS r
	LEFT JOIN
	dept_emp AS d
	ON
	r.emp_no = d.emp_no
WHERE
	d.to_date = '9999-01-01';
	
	
-- Check the table
SELECT * FROM current_emp;


-- Count employees grouped by departments
SELECT
	de.dept_no,
	COUNT(ce.emp_no)
INTO
	emp_count
FROM
	current_emp as ce
	LEFT JOIN
	dept_emp as de
	ON
	ce.emp_no = de.emp_no
GROUP BY
	de.dept_no
ORDER BY
	de.dept_no;
	
	
-- Create List 1: emp_info
SELECT
	e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO
	emp_info
FROM
	employees AS e
	INNER JOIN
	salaries AS s
	ON
	e.emp_no = s.emp_no
	INNER JOIN
	dept_emp AS de
	ON
	e.emp_no = de.emp_no
WHERE
	(e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND
	(e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND
	(de.to_date	= '9999-01-01');


-- Create List 2: manager_info
SELECT
	dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.first_name,
	ce.last_name,
	dm.from_date,
	dm.to_date
INTO
	manager_info
FROM
	managers as dm
	INNER JOIN
	departments as d
	ON
	dm.dept_no = d.dept_no
	INNER JOIN
	current_emp AS ce
	ON
	dm.emp_no = ce.emp_no;
	

-- Create List 3: dept_info
SELECT
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
-- INTO
-- 	dept_info
FROM
	current_emp AS ce
	INNER JOIN
	dept_emp AS de
	ON
	ce.emp_no = de.emp_no
	INNER JOIN
	departments AS d
	ON
	de.dept_no = d.dept_no;