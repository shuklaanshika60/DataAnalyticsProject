-- Creating the departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);

-- Creating the employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    department_id INT,
    hire_date DATE NOT NULL,
    position VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Creating the performance_reviews table
CREATE TABLE performance_reviews (
    review_id INT PRIMARY KEY,
    employee_id INT,
    review_date DATE NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 10),
    comments TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Creating the tasks table
CREATE TABLE tasks (
    task_id INT PRIMARY KEY,
    employee_id INT,
    task_description TEXT NOT NULL,
    assigned_date DATE NOT NULL,
    due_date DATE NOT NULL,
    status VARCHAR(50) NOT NULL CHECK (status IN ('Completed', 'In Progress', 'Overdue')),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Creating the attendance table
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    employee_id INT,
    date DATE NOT NULL,
    status VARCHAR(50) NOT NULL CHECK (status IN ('Present', 'Absent', 'Late', 'On Leave')),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Creating the goals table
CREATE TABLE goals (
    goal_id INT PRIMARY KEY,
    employee_id INT,
    goal_description TEXT NOT NULL,
    set_date DATE NOT NULL,
    due_date DATE NOT NULL,
    completion_status VARCHAR(50) NOT NULL CHECK (completion_status IN ('Achieved', 'Not Achieved', 'In Progress')),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Inserting into departments table
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Engineering'),
(4, 'Marketing');

-- Inserting into employees table
INSERT INTO employees (employee_id, first_name, last_name, department_id, hire_date, position, status) VALUES
(1, 'Alice', 'Johnson', 1, '2021-03-01', 'HR Specialist', 'Active'),
(2, 'Bob', 'Smith', 2, '2020-05-15', 'Accountant', 'Active'),
(3, 'Charlie', 'Davis', 3, '2019-09-10', 'Software Engineer', 'Active'),
(4, 'Diana', 'Garcia', 4, '2022-01-20', 'Marketing Manager', 'Active'),
(5, 'Eve', 'Martinez', 3, '2018-11-30', 'Senior Developer', 'Active'),
(6, 'Frank', 'Thomas', 2, '2017-07-18', 'Financial Analyst', 'Active'),
(7, 'Grace', 'Williams', 1, '2022-03-22', 'HR Assistant', 'Active'),
(8, 'Henry', 'Brown', 3, '2016-11-05', 'DevOps Engineer', 'Active'),
(9, 'Isabella', 'Wilson', 4, '2021-08-30', 'Content Strategist', 'Active'),
(10, 'Jack', 'Taylor', 3, '2019-02-12', 'Frontend Developer', 'Active');

-- Add 10 more entries for a total of 15 employees

-- Inserting into performance_reviews table
INSERT INTO performance_reviews (review_id, employee_id, review_date, rating, comments) VALUES
(1, 1, '2023-07-01', 8, 'Consistently meets expectations'),
(2, 2, '2023-06-15', 6, 'Needs improvement in time management'),
(3, 3, '2023-05-25', 9, 'Exceeds expectations in project delivery');

-- Inserting into tasks table
INSERT INTO tasks (task_id, employee_id, task_description, assigned_date, due_date, status) VALUES
(1, 1, 'Complete recruitment process for new hires', '2023-09-01', '2023-09-15', 'Completed'),
(2, 2, 'Prepare monthly financial report', '2023-09-05', '2023-09-25', 'In Progress'),
(3, 3, 'Develop new software feature', '2023-08-20', '2023-09-10', 'Overdue');

-- Inserting into attendance table
INSERT INTO attendance (attendance_id, employee_id, date, status) VALUES
(1, 1, '2023-09-01', 'Present'),
(2, 2, '2023-09-01', 'Late'),
(3, 3, '2023-09-01', 'Present');

-- Inserting into goals table
INSERT INTO goals (goal_id, employee_id, goal_description, set_date, due_date, completion_status) VALUES
(1, 1, 'Reduce employee turnover by 10%', '2023-01-01', '2023-12-31', 'In Progress'),
(2, 2, 'Achieve 5% increase in quarterly revenue', '2023-04-01', '2023-09-30', 'Achieved'),
(3, 3, 'Deliver the new software release on time', '2023-06-01', '2023-09-01', 'Not Achieved');


SELECT COUNT(*) AS total_employees FROM employees;

SELECT AVG(rating) AS average_rating FROM performance_reviews;

SELECT status, COUNT(*) AS count
FROM tasks
GROUP BY status;

SELECT e.first_name, e.last_name, COUNT(t.task_id) AS completed_tasks
FROM employees e
JOIN tasks t ON e.employee_id = t.employee_id
WHERE t.status = 'Completed'
GROUP BY e.first_name, e.last_name
ORDER BY completed_tasks DESC;

SELECT completion_status, COUNT(*) AS count
FROM goals
GROUP BY completion_status;


SELECT e.first_name, e.last_name
FROM employees e
JOIN goals g ON e.employee_id = g.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
HAVING SUM(CASE WHEN g.completion_status = 'Achieved' THEN 1 ELSE 0 END) = COUNT(g.goal_id);


SELECT position, AVG(pr.rating) AS avg_rating
FROM employees e
JOIN performance_reviews pr ON e.employee_id = pr.employee_id
GROUP BY position
ORDER BY avg_rating DESC;

SELECT d.department_name, AVG(pr.rating) AS avg_rating
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN performance_reviews pr ON e.employee_id = pr.employee_id
GROUP BY d.department_name
ORDER BY avg_rating DESC;

SELECT e.first_name, e.last_name, COUNT(t.task_id) AS overdue_tasks
FROM employees e
JOIN tasks t ON e.employee_id = t.employee_id
WHERE t.status = 'Overdue'
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY overdue_tasks DESC;

SELECT d.department_name, COUNT(t.task_id) AS completed_tasks
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN tasks t ON e.employee_id = t.employee_id
WHERE t.status = 'Completed'
GROUP BY d.department_name
ORDER BY completed_tasks DESC;

SELECT d.department_name,
    COUNT(t.task_id) AS total_tasks,
    SUM(CASE WHEN t.status = 'Completed' THEN 1 ELSE 0 END) AS completed_tasks,
    ROUND((SUM(CASE WHEN t.status = 'Completed' THEN 1 ELSE 0 END) / COUNT(t.task_id)) * 100, 2) AS completion_rate
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN tasks t ON e.employee_id = t.employee_id
GROUP BY d.department_name
ORDER BY completion_rate DESC;


