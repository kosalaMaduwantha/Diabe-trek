import pandas as pd
import numpy as np
from optimiation_module.Base import Base

new_routine = Base(1, 2, 3, 2000, 300)
routine = new_routine.print()
df = pd.DataFrame(routine.items(), columns=['activity', 'no_min'])
df.at[0,'activity'] = 'cales'

for index, row in df.iterrows():
    print(row['activity'], row['no_min'])


