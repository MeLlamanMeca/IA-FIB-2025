package clasesAIMA;
import IA.Red.Sensores;
import IA.Red.CentrosDatos;

import java.util.*;

/**
 * Clase State que representa un DAG de conexiones
 */
public class State {
    // Todos los estados almacenan un estático de los sensores y laos centros para evitar información duplicada
    private static Sensores sensores;
    private static CentrosDatos centros;

    /**
     * Configura es escenario de la ejecución
     */
    public class setStatic(Sensores s, CentrosDatos c) {
        sensores = s;
        centros = c;
    }

    /**
     * Clase interna que representa la información de conexiones de un sensor en el estado
     * Similar a una struct en c++
     */
    public static class ConexionSensor {
        // Lista de los ID's de sensores que apuntan a este sensor (máximo 3)
        public List<Integer> entrantes;
        // Destino al que envía: Si es un sensor es su ID, si es un centro es su ID negativa
        public int destino;
        // Volumen de datos transmitido por el sensor (máximo 3 * volumen de datos que él envía)
        public double volumen;

        public ConexionSensor(int i) {
            entrantes = new ArrayList<>();
            destino = Integer.MAX_VALUE;    // Sin asignar
            volumen = sensores.get(i).getCapacidad();   // Inicialmente transmite solo su propio tráfico de datos
        }
    }

    // Vector de las conexiones de cada sensor
    private ConexionSensor[] conexiones;

    /**
     * Constructor de un estado
     * Se inicializan todas las conexiones vacías
     */
    public State() {
        int n = sensores.size();
        conexiones = new ConexionSensor[n];
        for (int i = 0; i < n; i++) {
            conexiones[i] = new ConexionSensor(i);
        }
    }

    /* ------------------ CREADORAS DE ESTADOS INICIALES -------------------- */



    /* --------------------------- OPERADORES ------------------------------- */



    /* --------------------------- HEURÍSTICAS ------------------------------ */



    /* --------------------------- OPERADORES ------------------------------- */



    /* ------------------------------ OTROS --------------------------------- */

    /**
     * La función de Goal en HC y SA siempre devuelve falso para seguir analizando
     */
    public boolean is_goal() {
        return false;
    }

    /**
     * Algoritmo DFS que devuelve si desde el nodo inicio se puede encontrar algún ciclo
     */
    private boolean dfs(int inicio, boolean[] visitado) {
        Stack<Integer> stack = new Stack<>();
        stack.push(inicio);

        while(!stack.isEmpty()) {
            int nodo = stack.pop();

            if (!visitado[nodo]) {
                visitado[nodo] = true;

                // Añado en la pila el nodo al que apunta
                stack.push(conexiones[nodo].destino);
            }
            else {  // Si ya lo había visitado entonces hay un ciclo
                return true;
            }
        }
        return false;   // No ha encontrado un ciclo en esta iteración
    }


    /**
     * Encuentra si para la configuración actual existe algún ciclo en el grafo
     */
    public boolean encontrarCiclos() {
        int n = conexiones.length;

        boolean visitado[] = new boolean[n];    // Se inicializa en false

        for (int nodo = 0; nodo < n; nodo++) {
            if (!visitado[nodo]) {
                if (dfs(nodo, visitado)) return true;    // Ciclo encontrado
            }
        }
        return false;   // No hay ciclo en ninguna iteración
    }
}
