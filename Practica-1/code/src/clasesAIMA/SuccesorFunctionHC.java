package clasesAIMA;

import aima.search.framework.SuccessorFunction;
import aima.search.framework.Successor;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * Created by bejar on 17/01/17
 */
public class SuccesorFunctionHC implements SuccessorFunction {

    // Logger para la clase
    private static final Logger logger = Logger.getLogger(SuccesorFunctionHC.class.getName());

    public List getSuccessors(Object state) {
        ArrayList retval = new ArrayList();
        State board = (State) state;

        logger.info("Obteniendo sucesores para el estado: " + state);

        for (int i = 0; i < board.numSensores() - 1; ++i) {

            // Moves hacia centros
            for (int j = 1; j <= board.numCentros(); ++j) {
                if (board.centroApuntable(-j)) {
                    State newBoard = board.copy();
                    newBoard.move(i, -j);
                    // Log cuando se mueve un sensor a un centro
                    logger.fine("Moviendo el puntero del sensor " + i + " al centro " + j);
                    String action = "Move sensor pointer " + i + " to center " + j;
                    retval.add(new Successor(action, newBoard));
                }
            }

            // Moves y swaps hacia sensores
            for (int j = 0; j < board.numSensores(); ++j) {
                if (board.sensorApuntable(j) && i != j) {
                    State newBoard = board.copy();
                    newBoard.move(i, j);
                    if (newBoard.confirmarCambios(Collections.singletonList(i))) {
                        logger.fine("Moviendo el puntero del sensor " + i + " al sensor " + j);
                        String action = "Move sensor pointer " + i + " to sensor " + j;
                        retval.add(new Successor(action, newBoard));
                    }
                }

                if (j > i) {
                    State newBoard = board.copy();
                    newBoard.swap(i, j);
                    if (newBoard.confirmarCambios(List.of(i, j))) {
                        logger.fine("Intercambiando los punteros de los sensores " + i + " y " + j);
                        String action = "Swap sensors pointers " + i + " and " + j;
                        retval.add(new Successor(action, newBoard));
                    }
                }
            }

            // Circular swaps y linear moves hacia sensores de grado 3
            for (int j = 0; j < board.numSensores(); ++j) {
                for (int k = 0; k < board.numSensores(); ++k) {
                    if (i != j && i != k && j != k) {
                        // Circular swap
                        State newBoard = board.copy();
                        newBoard.circularSwap(List.of(i, j, k));
                        if (newBoard.confirmarCambios(List.of(i, j, k))) {
                            logger.fine("Intercambio circular de punteros de sensores " + i + ", " + j + " y " + k);
                            String action = "Circular swap sensors pointers " + i + ", " + j + " and " + k;
                            retval.add(new Successor(action, newBoard));
                        }

                        // Linear move
                        if (board.sensorApuntable(j) && board.sensorApuntable(k)) {
                            newBoard = board.copy();
                            newBoard.linearMove(List.of(i, j, k));
                            if (newBoard.confirmarCambios(List.of(i, j))) {
                                logger.fine("Movimiento lineal del puntero del sensor " + i + " hacia los sensores " + j + " y " + k);
                                String action = "Linear move sensor pointer " + i + " to sensors " + j + " and " + k;
                                retval.add(new Successor(action, newBoard));
                            }
                        }
                    }
                }
            }
        }

        logger.info("Se han obtenido " + retval.size() + " sucesores.");
        return retval;
    }
}
