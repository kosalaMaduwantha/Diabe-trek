##


activity_pools = {
    1:["Running","Jogging","Weight lifting","Mountain Climbing","Push ups","Hit ups","swimming","Cardio","sports"],
    2:["Running","Jogging","Weight lifting","cycling moderate speed","Yoga","Hit ups","swimming","Cardio","Tai Chi"],
    3:["Walking","Running","Jogging","Cycling <10 mph leisure bicycling","Yoga","Tai Chi","Climbing stairs","Rowing machine, moderate","dancing"],
    4:["Walking","Jogging","Cycling <10 mph leisure bicycling","Stationary cycling very light","Stationary cycling, light","Calisthenics light","Yoga","Tai Chi"]

}
print(activity_pools[2])

def selecting_pool(class_):
    
    if(class_==1):
        return activity_pools[1]
    elif(class_==2):
        return activity_pools[2]
    elif(class_==3):
        return activity_pools[3]
    elif(class_==4):
        return activity_pools[4]

print(selecting_pool(2))