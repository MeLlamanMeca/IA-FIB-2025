import IA.Red.CentrosDatos;
import IA.Red.Sensor;
import IA.Red.Sensores;
import aima.search.informed.HillClimbingSearch;
import aima.search.informed.SimulatedAnnealingSearch;
import clasesAIMA.State;
import clasesAIMA.GoalTestFunc;
import clasesAIMA.HeuristicFunc;
import clasesAIMA.SuccesorFunctionHC;
import clasesAIMA.SuccesorFunctionSA;
import aima.search.framework.GraphSearch;
import aima.search.framework.Problem;
import aima.search.framework.Search;
import aima.search.framework.SearchAgent;
import aima.search.informed.AStarSearch;
import aima.search.informed.IterativeDeepeningAStarSearch;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

public class Main {
    public static int seed = 2;

    private static State ejecutarHillClimbingSinImprimir(State state) throws Exception {
        // Creamos el problema para Hill Climbing
        Problem p = new Problem(
                state,                      // Estado inicial
                new SuccesorFunctionHC(),   // Función de sucesores
                new GoalTestFunc(),         // Condición de parada
                new HeuristicFunc()         // Heurística de evaluación
        );

        Search alg = new HillClimbingSearch();
        SearchAgent agent = new SearchAgent(p, alg);

        // Retornamos el estado meta obtenido
        return (State)alg.getGoalState();
    }

    private static void ejecutarHillClimbing(State state) throws Exception {

        // Creamos problema para Hill Climbing
        Problem p = new Problem(
                state,                      // Estado inicial
                new SuccesorFunctionHC(),   // Función de sucesores
                new GoalTestFunc(),         // Condición de parada
                new HeuristicFunc()         // Heurística de evaluación
        );


        long startTime = System.currentTimeMillis();

        Search alg = new HillClimbingSearch();
        SearchAgent agent = new SearchAgent(p, alg);

        // Imprimir todas las estadísticas
        long estimatedTime = System.currentTimeMillis() - startTime;
        //System.out.println("Tiempo de ejecución: " + estimatedTime + " ms");

        System.out.println("\nResultado Hill Climbing:");
        printInstrumentation(agent.getInstrumentation());
        //System.out.println(alg.getGoalState());
        State goal = (State) alg.getGoalState();
        List<Double> a = goal.getInfo();
        System.out.println("semilla: " + seed);
        System.out.println("Operadores: Move+Swap");
        System.out.println("Megabytes: " + a.get(1) + ":" + a.get(0) + " Distancia : " + a.get(2) + " Coste : " + a.get(3));
        System.out.println("Tiempo de ejecución: " + estimatedTime + " ms");

    }

    private static void ejecutarSimulatedAnnealing(State state) throws Exception {

        // Establecer parámetros Simulated Annealing
        int steps = 1000000;         // Número total de iteraciones del algoritmo
        int stiter = 100;           // Número de iteraciones por cada nivel de temperatura
        int k = 125;                // Factor de ajuste para la función de probabilidad de aceptación (cuanto mayor sea más tiempo aceptara soluciones peores)
        double lambda = 0.0001;     // Parámetro de enfriamiento

        long startTime = System.currentTimeMillis();

        // Creamos problema para Simulated Annealing
        Problem p = new Problem(
                state,                      // Estado inicial
                new SuccesorFunctionSA(),   // Función de sucesores
                new GoalTestFunc(),         // Condición de parada
                new HeuristicFunc()         // Heurística de evaluación
        );

        Search alg = new SimulatedAnnealingSearch(steps, stiter, k, lambda);
        SearchAgent agent = new SearchAgent(p, alg);

        // Imprimir todas las estadísticas
        long estimatedTime = System.currentTimeMillis() - startTime;
        System.out.println("Tiempo de ejecución: " + estimatedTime + " ms");

        System.out.println("\nResultado Simulated Annealing:");
        printInstrumentation(agent.getInstrumentation());
        System.out.println(alg.getGoalState());
        State goal = (State) alg.getGoalState();
        List<Double> a = goal.getInfo();
        System.out.println("semilla: " + seed);
        System.out.println("Operadores: Move+Swap");
        System.out.println("Megabytes: " + a.get(1) + ":" + a.get(0) + " Distancia : " + a.get(2) + " Coste : " + a.get(3));
        System.out.println("Tiempo de ejecución: " + estimatedTime + " ms");
    }

    public static void main(String[] args) throws Exception{
        for(int i = 0; i < 10; ++i) {
            seed = i;
            // Inicializamos el contexto del problema
            Sensores s = new Sensores(250, seed);       // número de sensores, semilla
            CentrosDatos c = new CentrosDatos(10, seed); // número de centros de datos, semilla

            State.setEnvironment(s, c);

            // Establecemos el contexto en el estado
            State state = new State();
            state.inicializarMejorDistancia();
            // Seleccionamos estado inicial
            state.generadorGreedyMinDist();
            //state.generadorGreedyHierarchy();
            // state.generadorRandom1();
            // state.generadorGreedyHierarchy();

            // Generar 1000 randoms y probar una heuristica:
/*
        State bestState = null;
        double bestHeuristic = Double.POSITIVE_INFINITY; // Suponiendo que una heurística menor es mejor
        int iterations = 10;

        for (int i = 0; i < iterations; i++) {
            System.out.println("Iteracion: " + i + " ejecutandose");
            // Generamos un estado inicial; puedes elegir el método que prefieras
            State initialState = new State();
            initialState.generadorRandom1(); // Usamos el generador Random1

            // Ejecutamos Hill Climbing y obtenemos el estado resultado
            State resultState = ejecutarHillClimbingSinImprimir(initialState);

            // Evaluamos la solución con la función heurística
            double heuristicValue = new HeuristicFunc().getHeuristicValue(resultState);
            if (heuristicValue < bestHeuristic) {
                bestHeuristic = heuristicValue;
                bestState = resultState;
            }
        }
        System.out.println("Mejor solución encontrada tras " + iterations + " ejecuciones:");
        System.out.println("Heurística: " + bestHeuristic);
        System.out.println(bestState);



 */


            // Ejecutamos los dos algoritmos con el mismo estado inicial para poder comparar sus ejecuciones
            ejecutarHillClimbing(state);
            //ejecutarSimulatedAnnealing(state);
        }
    }

    private static void printInstrumentation(Properties properties) {
        Iterator keys = properties.keySet().iterator();
        while (keys.hasNext()) {
            String key = (String) keys.next();
            String property = properties.getProperty(key);
            System.out.println(key + " : " + property);
        }
    }
    
    private static void printActions(List actions) {
        for (int i = 0; i < actions.size(); i++) {
            String action = (String) actions.get(i);
            System.out.println(action);
        }
    }
}
