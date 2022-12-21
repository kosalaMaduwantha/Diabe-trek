# base class
from ortools.sat.python import cp_model


class Base:
    # states
    activity01 = ""
    coef01 = None
    activity02 = ""
    coef02 = None
    activity03 = ""
    coef03 = None
    lowerBound = None
    upperBound = None
    solver = None
    status = None
    target_cal = None
    no_min = None

    model = cp_model.CpModel()

    # constructor
    def __init__(self, coef01, coef02, coef03, target_cal, no_min):
        self.coef01 = coef01
        self.coef02 = coef02
        self.coef03 = coef03
        self.lowerBound = 10
        self.upperBound = 180
        self.target_cal = target_cal
        self.no_min = no_min

        # calling the methods
        self.variables_init()
        self.objective_function()
        self.constraints()
        self.solve()

    # method that defines the optimization variables
    def variables_init(self):
        self.activity01 = self.model.NewIntVar(self.lowerBound, self.upperBound, 'activity01')
        self.activity02 = self.model.NewIntVar(self.lowerBound, self.upperBound, 'activity02')
        self.activity03 = self.model.NewIntVar(self.lowerBound, self.upperBound, 'activity03')

    # defining the objective function
    def objective_function(self):
        self.model.Maximize(
            self.coef01 * self.activity01 + self.coef02 * self.activity02 + self.coef03 * self.activity03)

    # defining constraints
    def constraints(self):
        self.model.Add(self.activity01 + self.activity02 + self.activity03 <= self.no_min)
        self.model.Add(
            self.coef01 * self.activity01 + self.coef02 * self.activity02 + self.coef03 * self.activity03 < self.target_cal)
        # self.model.Add(self.activity01 > self.coef02 * self.activity02)
        # self.model.Add(self.activity02 > self.activity03)
        if self.coef01 < self.coef02 < self.coef03:
            self.model.Add(self.activity01 > self.activity02 * self.coef02)
            self.model.Add(self.activity02 > self.activity03 * self.coef02)
        elif self.coef01 > self.coef02 > self.coef03:
            self.model.Add(self.activity01 * self.coef01 < self.activity02)
            self.model.Add(self.activity02 * self.coef02 < self.activity03)
        elif self.coef01 < self.coef03 < self.coef02:
            self.model.Add(self.activity03 * self.coef03 < self.activity01)
            self.model.Add(self.activity02 * self.coef02 < self.activity03)
        elif self.coef02 < self.coef03 < self.coef01:
            self.model.Add(self.activity03 * self.coef03 < self.activity02)
            self.model.Add(self.activity01 * self.coef01 < self.activity03)
        elif self.coef03 < self.coef01 < self.coef02:
            self.model.Add(self.activity03 > self.coef01 * self.activity01)
            self.model.Add(self.activity01 > self.coef02 * self.activity02)

    def solve(self):
        self.solver = cp_model.CpSolver()
        self.status = self.solver.Solve(self.model)

    def print(self):
        if self.status == cp_model.OPTIMAL or self.status == cp_model.FEASIBLE:
            print(f'Maximum of objective function: {self.solver.ObjectiveValue()}\n')
            print(f'x = {self.solver.Value(self.activity01)}')
            print(f'y = {self.solver.Value(self.activity02)}')
            print(f'z = {self.solver.Value(self.activity03)}')

            dictionary = {
                "activity01": self.solver.Value(self.activity01),
                "activity02": self.solver.Value(self.activity02),
                "activity03": self.solver.Value(self.activity03)
            }

        else:
            dictionary = no_result(self.coef01, self.coef02, self.coef03, self.no_min)

        return dictionary


def no_result(cof01, cof02, cof03, no_min):
    activity01 = cof01 / (cof01 + cof02 + cof03) * no_min
    activity02 = cof02 / (cof01 + cof02 + cof03) * no_min
    activity03 = cof03 / (cof01 + cof02 + cof03) * no_min

    print(f'x = {activity01}')
    print(f'y = {activity02}')
    print(f'z = {activity03}')

    dictionary = {
        "activity01": activity01,
        "activity02": activity02,
        "activity03": activity03
    }

    return dictionary
