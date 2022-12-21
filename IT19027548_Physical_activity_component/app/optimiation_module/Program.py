from Base import Base
from db_conn import DB_CONN

import pymysql as pymysql

# instance of the db connection



# defining the variables to the optimization problem
# new_routine_creator.variables_init()
# objective function
# new_routine_creator.objective_function()
# defining the constraints
# new_routine_creator.constraints()
# solve
# new_routine_creator.solve()
# print the routine
# new_routine_creator.print()
# defining the main attributes of the routine creation
new_routine_creator = Base(2, 3, 1, 600, 200)
routine = new_routine_creator.print()
print(routine)
