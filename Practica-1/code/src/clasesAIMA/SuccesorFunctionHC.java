package clasesAIMA;

import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;

import java.util.*;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Created by bejar on 17/01/17
 */
public class SuccesorFunctionHC implements SuccessorFunction {

    // Logger para la clase
    //private static final Logger logger = Logger.getLogger(SuccesorFunctionHC.class.getName());
    private Set<List<Integer>> uniqueStates = new HashSet<>();

    private static List<Integer> normalizeSwap(int i, int j, int k) {
        // Generar las 3 rotaciones posibles
        if(i < j && i < k) {return Arrays.asList(i, j, k);}
        if(j < i && j < k) {return Arrays.asList(j, k, i);}
        return Arrays.asList(k, i, j);

    }


    public List getSuccessors(Object state) {
        int a,b,c,d,av,bv,cv,dv;
        a = b = c = d = av = bv = cv = dv = 0;



        ArrayList retval = new ArrayList();
        State board = (State) state;

        /* Para operadores del meca

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
                State newBoard = board.copy();
                //logger.fine("Moviendo el puntero del sensor " + i + " al centro " + -j);
                //++a;
                if (newBoard.move(i, -j)) {
                    //++av;
                    String action = "Move sensor pointer " + i + " to center " + -j;
                    retval.add(new Successor(action, newBoard));
                }
            }

            // Moves y swaps hacia sensores
            for (int j = 0; j < board.numSensores(); ++j) {
                State newBoard = board.copy();
                //logger.fine("Moviendo el puntero del sensor " + i + " al sensor " + j);
                //++a;
                if (i != j && newBoard.move(i, j)) {
                    //++av;
                    String action = "Move sensor pointer " + i + " to sensor " + j;
                    retval.add(new Successor(action, newBoard));
                }

                if (j > i) {
                    newBoard = board.copy();
                    //logger.fine("Intercambiando los punteros de los sensores " + i + " y " + j);
                    //++b;
                    if (newBoard.swap(i, j)) {
                        //++bv;
                        String action = "Swap sensors pointers " + i + " and " + j;
                        retval.add(new Successor(action, newBoard));
                    }
                }
            }
        }

        /*
        for (List<Integer> swap : uniqueStates) {
            State newBoard = board.copy();
            //logger.fine("Intercambiando los punteros de los sensores " + swap.get(0) + ", " + swap.get(1) + " y " + swap.get(2));
            //++c;
            if (newBoard.circularSwap(swap)) {
                //++cv;
                String action = "Circular swap sensors pointers " + swap.get(0) + ", " + swap.get(1) + " and " + swap.get(2);
                retval.add(new Successor(action, newBoard));
            /*
            // Circular swaps y linear moves hacia sensores de grado 3
            for (int j = 0; j < board.numSensores(); ++j) {
                for (int k = 0; k < board.numSensores(); ++k) {
                    if (i != j && i != k && j != k) {
                        // Circular swap
                        State newBoard = board.copy();
                        logger.fine("Intercambio circular de punteros de sensores " + i + ", " + j + " y " + k);
                        ++c;
                        if (newBoard.circularSwap(List.of(i, j, k))) {
                            ++cv;
                            String action = "Circular swap sensors pointers " + i + ", " + j + " and " + k;
                            retval.add(new Successor(action, newBoard));
                        }

                        // Linear move
                        newBoard = board.copy();
                        logger.fine("Movimiento lineal del puntero del sensor " + i + " hacia los sensores " + j + " y " + k);
                        ++d;
                        if (newBoard.linearMove(List.of(i, j, k))) {
                            ++dv;
                            String action = "Linear move sensor pointer " + i + " to sensors " + j + " and " + k;
                            retval.add(new Successor(action, newBoard));
                        }
                    }
                }


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
