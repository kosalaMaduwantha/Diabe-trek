"""Simple solve."""
from ortools.sat.python import cp_model


def main():
    """Minimal CP-SAT example to showcase calling the solver."""
    # Creates the model.
    model = cp_model.CpModel()

    # Creates the variables.
    var_upper_bound = max(180, 180, 180)
    x = model.NewIntVar(10, var_upper_bound, 'x')
    y = model.NewIntVar(10, var_upper_bound, 'y')
    z = model.NewIntVar(10, var_upper_bound, 'z')

    # Creates the constraints.
    model.Add(x + y + z <= 185)
    model.Add(3 * x + 5 * y + 6 * z < 900)
    model.Add(x > 3 * y)
    model.Add(y > z)

    model.Maximize(3 * x + 5 * y + 6 * z)

    # Creates a solver and solves the model.
    solver = cp_model.CpSolver()
    status = solver.Solve(model)

    if status == cp_model.OPTIMAL or status == cp_model.FEASIBLE:
        print(f'Maximum of objective function: {solver.ObjectiveValue()}\n')
        print(f'x = {solver.Value(x)}')
        print(f'y = {solver.Value(y)}')
        print(f'z = {solver.Value(z)}')
    else:
        print('No solution found.')

    # Statistics.
    print('\nStatistics')
    print(f'  status   : {solver.StatusName(status)}')
    print(f'  conflicts: {solver.NumConflicts()}')
    print(f'  branches : {solver.NumBranches()}')
    print(f'  wall time: {solver.WallTime()} s')


if __name__ == '__main__':
    main()
