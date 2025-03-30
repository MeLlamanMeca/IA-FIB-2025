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
import java.util.Scanner;

public class Main {
    public static int seed2 = 0;
    public static int seed1 = 0;
    public static int stateIni = 1;
    public static int algoritmo = 1;
    public static int h = 1;

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
        HeuristicFunc h1 = new HeuristicFunc();
        h1.setSelected(h);
        Problem p = new Problem(
                state,                      // Estado inicial
                new SuccesorFunctionHC(),   // Función de sucesores
                new GoalTestFunc(),         // Condición de parada
                h1         // Heurística de evaluación
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
        System.out.println("semilla: " + seed1);
        System.out.println("Megabytes: " + a.get(1) + ":" + a.get(0) + " Distancia : " + a.get(2) + " Coste : " + a.get(3));
        System.out.println("Tiempo de ejecución: " + estimatedTime + " ms");

    }

    private static void ejecutarSimulatedAnnealing(State state) throws Exception {

        // Establecer parámetros Simulated Annealing
        int steps = 85000;         // Número total de iteraciones del algoritmo
        int stiter = 250;           // Número de iteraciones por cada nivel de temperatura
        int k = 75;                // Factor de ajuste para la función de probabilidad de aceptación (cuanto mayor sea más tiempo aceptara soluciones peores)
        double lambda = 0.0005;     // Parámetro de enfriamiento
        HeuristicFunc h1 = new HeuristicFunc();
        h1.setSelected(h);

        Problem p = new Problem(
                state,                      // Estado inicial
                new SuccesorFunctionSA(),   // Función de sucesores
                new GoalTestFunc(),         // Condición de parada
                h1        // Heurística de evaluación
        );
        long startTime = System.currentTimeMillis();
        Search alg = new SimulatedAnnealingSearch(steps, stiter, k, lambda);
        SearchAgent agent = new SearchAgent(p, alg);
        // Imprimir todas las estadísticas
        long estimatedTime = System.currentTimeMillis() - startTime;
        //System.out.println("Tiempo de ejecución: " + estimatedTime + " ms");
        System.out.println("\nResultado Simulated Annealing:");
        printInstrumentation(agent.getInstrumentation());
        //System.out.println(alg.getGoalState());
        State goal = (State) alg.getGoalState();
        List<Double> a = goal.getInfo();
        System.out.println("semilla: " + seed1);
        System.out.println("Megabytes: " + a.get(1) + ":" + a.get(0) + " Distancia : " + a.get(2) + " Coste : " + a.get(3));
        System.out.println("Tiempo de ejecución: " + estimatedTime + " ms");
    }

    public static void main(String[] args) throws Exception{
        inicializar();
            // Inicializamos el contexto del problema

            Sensores s = new Sensores(100, seed1);       // número de sensores, semilla
            CentrosDatos c = new CentrosDatos(4, seed2); // número de centros de datos, semilla

            State.setEnvironment(s, c);


            // Establecemos el contexto en el estado
            State state = new State();
            state.inicializarMejorDistancia();
            //estado inicial
            if (stateIni == 1) state.generadorGreedyMinDist();
            else if (stateIni == 2) state.generadorGreedyHierarchy();
            else state.generadorRandom1();

            // Ejecutamos los dos algoritmos con el mismo estado inicial para poder comparar sus ejecuciones
            if (algoritmo == 1) {
                ejecutarHillClimbing(state);
            } else if (algoritmo == 2) {
                ejecutarSimulatedAnnealing(state);

            } else {
                ejecutarHillClimbing(state);
                ejecutarSimulatedAnnealing(state);
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

    private static void inicializar() {
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.print("Semilla sensores:");

            if (scanner.hasNextInt()) {
                seed1 = scanner.nextInt();
                break; // Opción válida, salimos del bucle

            } else scanner.next(); // Limpiar entrada inválida
        }

        while (true) {
            System.out.print("Semilla centros:");

            if (scanner.hasNextInt()) {
                seed2 = scanner.nextInt();
                break; // Opción válida, salimos del bucle

            } else scanner.next(); // Limpiar entrada inválida
        }



        while (true) {
            System.out.println("Que estado inicial deseas? (1-3)");
            System.out.println("Posibles respuestas:");
            System.out.println("1. Greedy de minima distancia.");
            System.out.println("2. Greedy jerarquico.");
            System.out.println("3. Random.");
            System.out.print("Selecciona una opción: ");

            if (scanner.hasNextInt()) {
                stateIni = scanner.nextInt();
                if (stateIni >= 1 && stateIni <= 3) {
                    break; // Opción válida, salimos del bucle
                }
            } else {
                scanner.next(); // Limpiar entrada inválida
            }
        }

        while (true) {
            System.out.println("Que algoritmo quieres ejecutar? (1-3)");
            System.out.println("Posibles respuestas:");
            System.out.println("1. HC");
            System.out.println("2. SA");
            System.out.println("3. HC+SA");
            System.out.print("Selecciona una opción: ");

            if (scanner.hasNextInt()) {
                algoritmo = scanner.nextInt();
                if (algoritmo >= 1 && algoritmo <= 3) {
                    break; // Opción válida, salimos del bucle
                }
            } else {
                scanner.next(); // Limpiar entrada inválida
            }
        }

        while (true) {
            System.out.println("Que heurística quieres ejecutar? (1-3)");
            System.out.println("Posibles respuestas:");
            System.out.println("1. Maximizar datos");
            System.out.println("2. Minimizar distancias");
            System.out.println("3. Datos entre distancia");
            System.out.println("4. Meca Heurística");
            System.out.print("Selecciona una opción: ");
            if (scanner.hasNextInt()) {
                h = scanner.nextInt();
                if (h >= 1 && h <= 4) {
                    break; // Opción válida, salimos del bucle
                }
            } else {
                scanner.next(); // Limpiar entrada inválida
            }
        }
        scanner.close();
    }
}
