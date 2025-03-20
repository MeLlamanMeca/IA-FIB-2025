package clasesAIMA;

import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;


public class SuccesorFunctionSA implements SuccessorFunction{


    public List getSuccessors(Object state) {
        List<Successor> retval = new ArrayList<>();
        State board = (State) state;
        State newBoard = board.copy();

        int numSensores = board.numSensores();
        int numCentros = board.numCentros();
        Random rand = new Random();

        double probMove = 0.5;  // Probabilidad de usar move
        double probSwap = 0.4;  // Probabilidad de usar swap
        double probCircularSwap = 0.1;  // Probabilidad de circularSwap

        double choice = rand.nextDouble();

        if (choice < probMove) {  // Intentar un move
            int i = rand.nextInt(numSensores);
            int destino = rand.nextBoolean() ? -rand.nextInt(numCentros) - 1 : rand.nextInt(numSensores);   // destino puede ser centro o sensor

            if (newBoard.checkMove(i, destino)) {
                newBoard.move(i,destino);
                String action = "Mover sensor " + i + " a " + (destino < 0 ? "centro " + destino : "sensor " + destino);
                retval.add(new Successor(action, newBoard));
            }

        } else if (choice < probMove + probSwap) {  // Intentar un swap
            int i = rand.nextInt(numSensores);
            int j = rand.nextInt(numSensores);
            while (i == j) { j = rand.nextInt(numSensores); }

            if (newBoard.checkSwap(i, j)) {
                newBoard.swap(i, j);
                String action = "Swapear sensores " + i + " y " + j;
                retval.add(new Successor(action, newBoard));
            }

        } else {  // Intentar un circularSwap
            List<Integer> indices = new ArrayList<>();
            while (indices.size() < 3) {
                int next = rand.nextInt(numSensores);
                if (!indices.contains(next)) indices.add(next);
            }

            if (newBoard.checkCircularSwap(indices)) {
                newBoard.circularSwap(indices);
                String action = "Circular swap sobre sensores " + indices;
                retval.add(new Successor(action, newBoard));
            }
        }

        return retval;
    }
}
