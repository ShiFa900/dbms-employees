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
              where tit.to_date in (select MAX(tit.to_date))
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


SELECT e.emp_no                                 as ID,
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
#
       concat(dm.first_name, ' ', em.last_name) as Manager,
       s.salary                                 as Salary
FROM employees e

         JOIN (SELECT emp_no,
                      max(titles.to_date) as titles_max_to_date
               FROM titles
               GROUP BY emp_no) last_title ON last_title.emp_no = e.emp_no
         JOIN titles t ON t.emp_no = e.emp_no AND t.to_date = last_title.titles_max_to_date

         JOIN dept_emp de on e.emp_no = de.emp_no

         JOIN departments d on de.dept_no = d.dept_no
         JOIN (SELECT emp_no,
                      max(dept_manager.to_date) as dept_manager_latest
               FROM dept_manager
               GROUP BY emp_no) as latest_manager ON latest_manager.emp_no = e.emp_no
         JOIN dept_manager dm on dm.emp_no = e.emp_no AND dm.to_date = latest_manager.dept_manager_latest

         JOIN (SELECT emp_no,
                      max(salaries.to_date) as salary_max_to_date
               FROM salaries
               GROUP BY emp_no) last_salary ON last_salary.emp_no = e.emp_no
         JOIN salaries s on e.emp_no = s.emp_no AND s.to_date = last_salary.salary_max_to_date;


SELECT COUNT(*)
FROM employees;

