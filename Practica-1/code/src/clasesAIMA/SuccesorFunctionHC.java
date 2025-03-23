package clasesAIMA;

import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;

import java.util.*;
import java.util.logging.Logger;
import java.util.logging.Level;


public class SuccesorFunctionHC implements SuccessorFunction {

    // Logger para la clase
    private static final Logger logger = Logger.getLogger(SuccesorFunctionHC.class.getName());
    private Set<List<Integer>> uniqueStates = new HashSet<>();

    private static List<Integer> normalizeSwap(int i, int j, int k) {
        // Generar las 3 rotaciones posibles
        if(i < j && i < k) {return Arrays.asList(i, j, k);}
        if(j < i && j < k) {return Arrays.asList(j, k, i);}
        return Arrays.asList(k, i, j);

    }


    public List getSuccessors(Object state) {
        int a,b,c,av,bv,cv;
        a = b = c = av = bv = cv = 0;

        ArrayList retval = new ArrayList();
        State board = (State) state;



/*
        if(uniqueStates.isEmpty()) {
            for (int i = 0; i < board.numSensores(); i++) {
                for (int j = 0; j < board.numSensores(); j++) {
                    for (int k = 0; k < board.numSensores(); k++) {
                        if (i != j && j != k && k != i) { // Evitar tripletas con valores repetidos
                            uniqueStates.add(normalizeSwap(i, j, k));
                        }
                    }
                }
            }
        }


 */

        //logger.info("Obteniendo sucesores para el estado: " + state);

        for (int i = 0; i < board.numSensores() - 1; ++i) {

            // Moves hacia centros
            for (int j = 1; j <= board.numCentros(); ++j) {
                //logger.fine("Moviendo el puntero del sensor " + i + " al centro " + -j);
                ++a;
                if (board.checkMove(i, -j)) {
                    State newBoard = board.copy();
                    newBoard.move(i, -j);
                    ++av;
                    String action = "Move sensor pointer " + i + " to center " + -j;
                    retval.add(new Successor(action, newBoard));
                }
            }

            // Moves y swaps hacia sensores
            for (int j = 0; j < board.numSensores(); ++j) {
                //logger.fine("Moviendo el puntero del sensor " + i + " al sensor " + j);
                ++a;

                if (i != j && board.checkMove(i, j)) {
                    State newBoard = board.copy();
                    newBoard.move(i, j);
                    ++av;
                    String action = "Move sensor pointer " + i + " to sensor " + j;
                    retval.add(new Successor(action, newBoard));
                }



                if (j > i) {

                    //logger.fine("Intercambiando los punteros de los sensores " + i + " y " + j);
                    ++b;
                    if (board.checkSwap(i, j)) {
                        State newBoard = board.copy();
                        newBoard.swap(i, j);
                        ++bv;
                        String action = "Swap sensors pointers " + i + " and " + j;
                        retval.add(new Successor(action, newBoard));
                    }
                }
            }
        }






/*
        for (List<Integer> swap : uniqueStates) {

            //logger.fine("Intercambiando los punteros de los sensores " + swap.get(0) + ", " + swap.get(1) + " y " + swap.get(2));
            ++c;
            if (board.checkCircularSwap(swap)) {
                State newBoard = board.copy();
                newBoard.circularSwap(swap);
                ++cv;
                String action = "Circular swap sensors pointers " + swap.get(0) + ", " + swap.get(1) + " and " + swap.get(2);
                retval.add(new Successor(action, newBoard));
            }
        }
*/
        //logger.info("Se han obtenido " + retval.size() + " sucesores.");
        //logger.info("Se han obtenido " + av + ":" + a + " movimientos de sensores.");
        //logger.info("Se han obtenido " + bv + ":" + b + " intercambios de punteros de sensores.");
        //logger.info("Se han obtenido " + cv + ":" + c + " intercambios circulares de punteros de sensores.");
        return retval;
    }
}
