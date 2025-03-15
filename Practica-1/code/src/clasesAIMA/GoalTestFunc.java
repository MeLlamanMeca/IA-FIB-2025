package clasesAIMA;

import aima.search.framework.GoalTest;

public class GoalTestFunc implements GoalTest {

    public boolean isGoalState(Object state){

        return((State) state).is_goal();
    }
}
