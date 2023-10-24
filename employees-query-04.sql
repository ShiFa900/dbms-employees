select
    e.emp_no as ID,
    concat(e.first_name, ' ',e.last_name) as Name,
    t.title as Position,
    t.from_date as "From",
    t.to_date as "To",
#     if(curdate() <= t.to_date, t.to_date, null),
    if(e.gender='m', 'Male', 'Female') as Gender,
    e.hire_date as Hired,
    d.dept_name as Department,
    de.from_date as "Assigned from",
    de.to_date as "Assigned to"

from employees e
    join dept_emp de on e.emp_no = de.emp_no
    inner join titles t on e.emp_no = t.emp_no
    right join departments d on d.dept_no = de.dept_no

where t.to_date >= curdate()


order by ID asc;