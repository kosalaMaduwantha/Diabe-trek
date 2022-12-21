# Function to detect infection and ischaemia ---------------------------------------------------------------------------
def infection_ischaemia(classification):
    condition = ''

    if classification[0] == 1:
        condition = 'none'
    elif classification[1] == 1:
        condition = 'infection'
    elif classification[2] == 1:
        condition = 'ischaemia'
    elif classification[3] == 1:
        condition = 'both'

    return condition


# Function to detect the wound score -----------------------------------------------------------------------------------
def wound_score(ischaemia, infection, new_area, old_area):
    score = 0

    if ischaemia:
        score = score + 1
    if infection:
        score = score + 1
    if new_area >= old_area:
        score = score + 1

    return score

# ----------------------------------------------------------------------------------------------------------------------


# Function to detect the wound stage -----------------------------------------------------------------------------------
def wound_stage(ischaemia, infection):
    stage = ''

    if ischaemia and infection:
        stage = 'D'
    elif ischaemia and not infection:
        stage = 'C'
    elif not ischaemia and infection:
        stage = 'B'
    elif not ischaemia and not infection:
        stage = 'A'

    return stage

# ----------------------------------------------------------------------------------------------------------------------


# Function to detect the wound stage -----------------------------------------------------------------------------------
def healing_prediction(old_stage, new_stage, old_score, new_score, old_state):
    state = ''

    if old_stage == new_stage:
        if new_score == old_score:
            state = old_state
        elif new_score < old_score:
            state = 'healing'
        elif new_score > old_score:
            state = 'aggravating'
    elif old_stage is 'A' and new_stage is 'B' or 'C' or 'D':
        state = 'aggravating'
    elif old_stage is 'D' and new_stage is 'A' or 'B' or 'C':
        state = 'healing'
    elif old_stage is 'B' or 'C' or 'D' and new_stage is 'A':
        state = 'healing'
    elif old_stage is 'B' or 'C' and new_stage is 'A':
        state = 'healing'
    elif old_stage is 'B' or 'C' and new_stage is 'D':
        state = 'aggravating'

    return state
