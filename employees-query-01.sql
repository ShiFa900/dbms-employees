select
emp_no as ID,
concat(first_name, ' ',last_name) as Name,
if(gender='m', 'Male', 'Female') as Gender,
hire_date as Hired
from employees

# urutan dari yang terlama ke yang terbaru
# redundan
order by Hired asc;

# urutan yang terbaru ke yang terlama
# order by Hired desc;



# select gender
# if(gender='m', 'Male', 'Female')
# conditional dalam mysql query
# from employees;