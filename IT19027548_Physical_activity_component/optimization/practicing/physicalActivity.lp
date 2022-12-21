\* The_physical-activity_problem *\
Maximize
Total_calories_burn_per_day: 5 Bycicling_hours + 1.66666666667 Running_hours
 + 1.66666666667 walking_hours
Subject To
numberOfHours: Bycicling_hours + Running_hours + walking_hours = 60
totalCalPerday: 1.66666666667 Bycicling_hours + 1.66666666667 Running_hours
 + 5 walking_hours <= 2000
x1_should_be_greater_than_x3: - Bycicling_hours + walking_hours >= 0
Bounds
 1 <= Bycicling_hours
 1 <= Running_hours
 1 <= walking_hours
End
