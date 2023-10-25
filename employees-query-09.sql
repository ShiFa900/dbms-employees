select e.emp_no                                 as ID,
       concat(e.first_name, ' ', e.last_name)   as Name,
       t.title                                  as Position,
       t.from_date                              as "From",
       t.to_date                                as "To",
       if(e.gender = 'm', 'Male', 'Female')     as Gender,
       e.hire_date                              as Hired,
       d.dept_name                              as Department,
       d.dept_no                                as "Department no",
       de.from_date                             as "Assigned from",
       de.to_date                               as "Assigned to",

       concat(em.first_name, ' ', em.last_name) as Manager,
       s.salary                                 as Salary

from employees e

         join(select tit.emp_no, MAX(tit.to_date) as max_title_to_date
              from titles tit
              group by tit.emp_no) as tit on tit.emp_no = e.emp_no


         join titles t on e.emp_no = t.emp_no
         join dept_emp de on de.emp_no = e.emp_no
         join departments d on d.dept_no = de.dept_no
         join dept_manager dm on d.dept_no = dm.dept_no
         join employees em on em.emp_no = dm.emp_no
         join salaries s on e.emp_no = s.emp_no


where (
                  t.to_date >= curdate() AND
                  de.to_date >= curdate() AND
                  dm.to_date >= curdate() AND
                  s.to_date >= curdate())

order by ID;


SELECT e.emp_no                               AS ID,
       concat(e.first_name, ' ', e.last_name) AS Name,
       t.title                                AS Position,
       t.from_date                            AS "From",
       t.to_date                              AS "To",
       if(e.gender = 'm', 'Male', 'Female')   AS Gender,
       e.hire_date                            AS Hired,
       d.dept_name                            AS Department,
       d.dept_no                              AS "Department no",
       de.from_date                           AS "Assigned from",
       de.to_date                             AS "Assigned to",
#
       concat(em.first_name, ' ', em.last_name) as Manager,
       s.salary                               AS Salary
FROM employees e

         JOIN (SELECT emp_no,
                      max(titles.to_date) AS titles_max_to_date
               FROM titles
               GROUP BY emp_no) last_title ON last_title.emp_no = e.emp_no
         JOIN titles t ON t.emp_no = e.emp_no AND t.to_date = last_title.titles_max_to_date

         JOIN dept_emp de ON e.emp_no = de.emp_no

         JOIN departments d ON de.dept_no = d.dept_no
    #     Bagaimana menentukan employee A  dengan manager B?
         JOIN (SELECT dept_no,
                      max(dept_manager.to_date) as manager_max_to_date
               FROM dept_manager
               GROUP BY dept_no) last_manager ON last_manager.dept_no = d.dept_no
         JOIN dept_manager dm
              ON dm.dept_no = d.dept_no AND dm.to_date = last_manager.manager_max_to_date
         JOIN employees em ON em.emp_no = dm.emp_no

         JOIN (SELECT emp_no,
                      max(salaries.to_date) AS sallary_max_to_date
               FROM salaries
               GROUP BY emp_no) last_sallary ON last_sallary.emp_no = e.emp_no
         JOIN salaries s ON s.emp_no = e.emp_no AND s.to_date = last_sallary.sallary_max_to_date

LIMIT 20;


SELECT COUNT(*)
FROM employees;

