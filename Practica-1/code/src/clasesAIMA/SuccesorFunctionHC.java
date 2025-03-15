package clasesAIMA;

import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by bejar on 17/01/17
 */
public class SuccesorFunctionHC implements SuccessorFunction{

    public List getSuccessors(Object state){
        ArrayList retval = new ArrayList();
        ProbIA5Board board = (ProbIA5Board) state;

        // Some code here
        // (flip all the consecutive pairs of coins and generate new states
        // Add the states to retval as Succesor("flip i j", new_state)
        // new_state has to be a copy of state

        for (int i = 0; i < board.getBoard().length - 1; ++i) {
            ProbIA5Board newBoard = board.copy();
            newBoard.flip_it(i);

            // Generar descripción del movimiento
            String action = "Flip coins at positions " + i + " and " + (i + 1);

            // Agregar nuevo estado a la lista de sucesores
            retval.add(new Successor(action, newBoard));
        }

        return retval;

    }

}
