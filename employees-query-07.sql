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
    de.to_date as "Assigned to",

    concat(em.first_name, ' ', em.last_name) as Manager


from employees e
    join dept_emp de on de.emp_no = e.emp_no
    join titles t on e.emp_no = t.emp_no
    join departments d on d.dept_no = de.dept_no
    join dept_manager dm on d.dept_no = dm.dept_no
    join employees em on em.emp_no = dm.emp_no


where (t.to_date > curdate() AND de.to_date > curdate() AND dm.to_date > curdate())

order by ID asc ;
