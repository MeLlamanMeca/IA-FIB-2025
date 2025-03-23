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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Main {
    public static int seed = 2;


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
        System.out.println("Operadores: Move + Swap");
        System.out.println("Megabytes: " + a.get(1) + ":" + a.get(0) + " Distancia : " + a.get(2) + " Coste : " + a.get(3));
        System.out.println("Tiempo de ejecución: " + estimatedTime + " ms");

    }

    public class Experiment {

        // Clase para almacenar los resultados de cada ejecución
        public static class Result {
            public int seed;
            public double lambda;
            public double megabyte1;
            public double megabyte2;
            public double distance;
            public double cost;
            public long executionTime;

            public Result(int seed, double lambda, double megabyte1, double megabyte2, double distance, double cost, long executionTime) {
                this.seed = seed;
                this.lambda = lambda;
                this.megabyte1 = megabyte1;
                this.megabyte2 = megabyte2;
                this.distance = distance;
                this.cost = cost;
                this.executionTime = executionTime;
            }
        }

        // Método modificado para devolver un objeto Result en lugar de imprimir directamente
        public static Result ejecutarSimulatedAnnealing(State state, int seed, int steps, int stiter, int k, double lambda) throws Exception {
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

            long estimatedTime = System.currentTimeMillis() - startTime;

            // Obtenemos la información del estado meta
            State goal = (State) alg.getGoalState();
            List<Double> a = goal.getInfo();
            // Se asume: a.get(1) y a.get(0) representan dos valores de "Megabytes",
            // a.get(2) la Distancia y a.get(3) el Coste.
            double mb1 = a.get(1);
            double mb2 = a.get(0);
            double distance = a.get(2);
            double cost = a.get(3);

            // Retornamos un objeto Result con los datos obtenidos
            return new Result(seed, lambda, mb1, mb2, distance, cost, estimatedTime);
        }

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

        public static Map<String, Double> runHillClimbingExperiments() throws Exception {
            Map<String, Double> averageTimes = new HashMap<>();

            int numSensores = 100;
            int numCentros = 4;
            for (int i = 0; i < 10; ++i) {
                System.out.println("=== Probando con sensores: " + numSensores + " == y centros: " + numCentros + " ===");
                long totalTime = 0;

                for (int seed = 0; seed < 3; seed++) {
                    System.out.println("\n--- Semilla: " + seed + " ---");
                    Sensores s = new Sensores(numSensores, seed);
                    CentrosDatos c = new CentrosDatos(numCentros, seed);

                    State.setEnvironment(s, c);

                    // Creamos el estado y definimos el contexto
                    State state = new State();
                    state.inicializarMejorDistancia();

                    // Seleccionamos estado inicial
                    state.generadorGreedyMinDist();
                    // Alternativamente:
                    // state.generadorRandom1();
                    // state.generadorGreedyHierarchy();

                    long startTime = System.currentTimeMillis();
                    ejecutarHillClimbing(state);
                    long elapsedTime = System.currentTimeMillis() - startTime;

                    totalTime += elapsedTime;
                }
                double avgTime = totalTime / 10.0;
                String configKey = "Sensores: " + numSensores + ", Centros: " + numCentros;
                averageTimes.put(configKey, avgTime);

                numCentros += 2;
                numSensores += 50;
            }


            return averageTimes;
        }

        // Método para ejecutar todo el experimento, devolviendo un mapa con los resultados agrupados por lambda
        public static Map<Double, List<Result>> runExperiments() throws Exception {
            double[] lambdas = {
                    0.00001,   // enfriamiento muy lento
                    0.000025,
                    0.00005,
                    0.000075,
                    0.0001,    // valor base
                    0.00025,
                    0.0005,
                    0.001,
                    0.005,
                    0.01       // enfriamiento rápido
            };

            Map<Double, List<Result>> resultsByLambda = new HashMap<>();

            // Ejecutar experimentos (3) para cada valor de lambda y cada semilla
            for (double lambda : lambdas) {
                List<Result> resultsForLambda = new ArrayList<>();
                System.out.println("=== Probando con lambda = " + lambda + " ===");

                for (int i = 0; i < 10; ++i) {
                    int seed = i;
                    System.out.println("\n--- Semilla: " + seed + " ---");

                    // Inicializamos el contexto del problema
                    Sensores s = new Sensores(100, seed);       // número de sensores, semilla
                    CentrosDatos c = new CentrosDatos(4, seed);   // número de centros de datos, semilla

                    State.setEnvironment(s, c);

                    // Creamos el estado y definimos el contexto
                    State state = new State();
                    state.inicializarMejorDistancia();

                    // Seleccionamos estado inicial
                    state.generadorGreedyMinDist();
                    // Alternativamente:
                    // state.generadorRandom1();
                    // state.generadorGreedyHierarchy();

                    // Ejecutamos Simulated Annealing y recogemos el resultado
                    Result res = ejecutarSimulatedAnnealing(state, seed, 100000, 100, 125, lambda);
                    resultsForLambda.add(res);
                }
                resultsByLambda.put(lambda, resultsForLambda);
            }

            return resultsByLambda;
        }

        // Método para calcular y mostrar los promedios
        public static void printAverages(Map<Double, List<Result>> resultsByLambda, double[] lambdas) {
            System.out.println("\n=== Promedios por lambda ===");
            for (double lambda : lambdas) {
                List<Result> resList = resultsByLambda.get(lambda);
                double sumMb1 = 0, sumMb2 = 0, sumDistance = 0, sumCost = 0;
                long sumTime = 0;
                for (Result r : resList) {
                    sumMb1 += r.megabyte1;
                    sumMb2 += r.megabyte2;
                    sumDistance += r.distance;
                    sumCost += r.cost;
                    sumTime += r.executionTime;
                }
                int count = resList.size();
                double avgMb1 = sumMb1 / count;
                double avgMb2 = sumMb2 / count;
                double avgDistance = sumDistance / count;
                double avgCost = sumCost / count;
                double avgTime = (double) sumTime / count;

                System.out.println("Lambda: " + lambda);
                System.out.println("Promedio Megabytes: " + avgMb1 + " : " + avgMb2);
                System.out.println("Promedio Distancia: " + avgDistance);
                System.out.println("Promedio Coste: " + avgCost);
                System.out.println("Promedio Tiempo de ejecución: " + avgTime + " ms\n");
            }
        }
    }

    public static void main(String[] args) throws Exception {
        /* Experimento 3
        Map<Double, List<Experiment.Result>> resultsByLambda = Experiment.runExperiments();

        // Valores de lambda utilizados en el experimento
        double[] lambdas = {
                0.00001,
                0.000025,
                0.00005,
                0.000075,
                0.0001,
                0.00025,
                0.0005,
                0.001,
                0.005,
                0.01
        };

        // Imprime los promedios para cada lambda
        Experiment.printAverages(resultsByLambda, lambdas);
         */


        // Experimento 4

        Map<String, Double> averageTimes = Experiment.runHillClimbingExperiments();

        System.out.println("=== Resultados promedio Hill Climbing ===");
        for (Map.Entry<String, Double> entry : averageTimes.entrySet()) {
            System.out.println(entry.getKey() + " -> Tiempo promedio: " + entry.getValue() + " ms");
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
