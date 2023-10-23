select
    e.emp_no as ID,
    concat(e.first_name, ' ',e.last_name) as Name,
    t.title as Position,
    t.from_date as "From",
    t.to_date as "To",
#     if(t.to_date >= curdate(), 'now', t.to_date) as "To",
    if(e.gender='m', 'Male', 'Female') as Gender,
    e.hire_date as Hired
from employees e
    inner join titles t on e.emp_no = t.emp_no

where t.to_date = '9999/01/01'

order by ID;