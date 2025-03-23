package clasesAIMA;


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
            default:
                return ((State) n).mecaHeuristica();
        }
    }

    public void setSelected(int new_selected) {
        selected = new_selected;
    }
}
