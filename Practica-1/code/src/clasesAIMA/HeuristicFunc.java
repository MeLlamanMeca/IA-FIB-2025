package clasesAIMA;

/**
 * Created by bejar on 17/01/17.
 */

import aima.search.framework.HeuristicFunction;

public class HeuristicFunc implements HeuristicFunction {
    int selected = 4;

    public double getHeuristicValue(Object n){
        switch (selected) {
            case 0:
                return ((State) n).heuristicaMaximizarDatos();
            case 1:
                return ((State) n).heuristicaMinimizarDistancias();
            case 2:
                return ((State) n).heuristicaDatosEntreDistancia();
            case 3:
                return ((State) n).heuristicaSobrecarga(0.5);
            case 4:
                return ((State) n).mecaHeuristica();
            case 5:
                return ((State) n).heuristicaSobrecargaEntropiaCruzada();
            case 6:
                return ((State) n).heuristicaEnunciado();
            case 7:
                return ((State) n).heuristicaEnunciadoMejorada();
            default:
                return ((State) n).heuristicaMaximizarDatos();
        }
    }

    public void setSelected(int new_selected) {
        selected = new_selected;
    }
}
