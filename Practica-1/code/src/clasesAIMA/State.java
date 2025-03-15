package clasesAIMA;
import IA.Red.Centro;
import IA.Red.Sensor;
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
    public static void setStatic(Sensores s, CentrosDatos c) {
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

        /**
         * Antes de llamarse debe haberse configurado el escenario con setStatic
         */
        public ConexionSensor(int i) {
            entrantes = new ArrayList<>();
            destino = Integer.MAX_VALUE;    // Sin asignar
            volumen = sensores.get(i).getCapacidad();   // Inicialmente transmite solo su propio tráfico de datos
        }
    }

    // Vector de las conexiones de cada sensor
    private ConexionSensor[] conexiones;
    // Vector de número de conexiones entrantes a cada centro
    private int[] contadorInputCentros;

    /**
     * Constructor de un estado
     * Se inicializan todas las conexiones vacías
     */
    public State() {
        int n = sensores.size();
        int m = centros.size();
        conexiones = new ConexionSensor[n];
        // El índice 0 en centros corresponde al índice 1 en contadorInputCentros (necesario para diferenciar el índice 0 de los sensores y de los centros
        contadorInputCentros = new int[m+1];  // Se inicializa a 0
        for (int i = 0; i < n; i++) {
            conexiones[i] = new ConexionSensor(i);
        }
    }

    /* ---------------------------- ÚTILES ---------------------------------- */

    /**
     * Accede al centro a través de su índice negativo
     * @param i identificador negativo del centro
     * @return Centro con identificador i
     */
    private Centro getCentro(int i) {
        return centros.get(-i - 1);
    }

    /**
     * Incrementa en 1 el número de conexiones que tiene el centro con índice i
     * @param i identificador negativo del centro
     */
    private void incrementaContadorCentros(int i) {
        contadorInputCentros[-i - 1]++;
    }


    /**
     * Calcula la distancia entre i y j
     * @param i apunta a j
     * @param j es apuntado por j
     * @return Distancia euclídea entre i y j
     */
    private double calcularDistancia(int i, int j) {
        int xi, yi, xj, yj; // Coordenadas

        Sensor s1 = sensores.get(i);
        xi = s1.getCoordX();
        yi = s1.getCoordY();

        if (j < 0) {    // Si j es un Centro
            Centro c = getCentro(j);
            xj = c.getCoordX();
            yj = c.getCoordY();
        }
        else {          // Si j es un Sensor
            Sensor s2 = sensores.get(j);
            xj = s2.getCoordX();
            yj = s2.getCoordY();
        }

        return Math.sqrt((xi - xj) * (xi - xj) + (yi - yj) * (yi - yj));
    }


    /**
     * Algoritmo DFS que devuelve si desde el nodo inicio se puede encontrar algún ciclo
     */
    private boolean dfs(int inicio, boolean[] visitadoGeneral) {
        Stack<Integer> stack = new Stack<>();
        stack.push(inicio);
        boolean[] visitadoActual = new boolean[sensores.size()];

        while(!stack.isEmpty()) {
            int nodo = stack.pop();

            if (visitadoActual[nodo]) { // Si ya lo he visitado en esta iteración entonces he encontrado un ciclo
                return true;
            }

            if (!visitadoGeneral[nodo]) {   // Si no lo he visitado en alguna iteración entonces lo visito
                visitadoGeneral[nodo] = true;
                visitadoActual[nodo] = true;

                // Añado en la pila el nodo al que apunta
                int destino = conexiones[nodo].destino;
                if (destino >= 0) {
                    stack.push(destino);
                }
            }
            else {  // Si ya lo he visitado en alguna iteración anterior significa que este camino ya lo he hecho y no había ciclos
                return false;
            }
        }
        return false;
    }


    /**
     * Encuentra si para la configuración actual existe algún ciclo en el grafo
     */
    public boolean encontrarCiclos() {
        int n = conexiones.length;

        boolean[] visitado = new boolean[n];    // Se inicializa en false

        for (int nodo = 0; nodo < n; nodo++) {
            if (!visitado[nodo] && dfs(nodo, visitado)) {
                return true;    // Ciclo encontrado
            }
        }
        return false;   // No hay ciclo en ninguna iteración
    }


    /**
     *  Comprueba si al sensor i se le puede añadir una conexión
     */
    public boolean sensorApuntable(int i) {
        return conexiones[i].entrantes.size() < 3;
    }


    /**
     *  Comprueba si al centro i se le puede añadir una conexión (i es un índice negativo)
     */
    public boolean centroApuntable(int i) {
        return contadorInputCentros[-i - 1] < 25;
    }


    /**
     * Devuelve el centro más cercano al sensor con id i
     * @param i id del sensor
     * @return Centro más cercano
     */
    private int getCentroMasCercano(int i) {
        int m = centros.size();
        int mejorCentro = -1;   // Lo pongo a -1 para evitar errores de Segmentación en otras funciones
        double minDistancia = Double.MAX_VALUE;

        for (int j = -1; j >= -m; j--) {   // Por cada centro    (Tienen ids negativas)
            double dist = calcularDistancia(i, j);
            if (dist < minDistancia) {
                minDistancia = dist;
                mejorCentro = j;
            }
        }

        return mejorCentro;
    }

    /** todo Esta función la he hecho muy rápido así que no he comprobado muy bien si está correctamente implementada
     * Conecta los sensores de la lista origen con los de la lista destino y devuelve aquellos que no ha podido conectar
     * @param origen ids de sensores origen
     * @param destino ids de sensores destino
     *
     *          todo: Se puede mejorar al juntar minimizando distancias, la versión actual es más sencilla
     */
    private List<Integer> conectarSensores(List<Integer> origen, List<Integer> destino) {
        List<Integer> sensoresNoConectados = new ArrayList<>();

        // Cuidado porque puede ser que origen y destino compartan índices lo que podría hacer que un sensor apunte a sí mismo
        boolean quedanAsignaciones = true;
        for (int s1 : origen) {
            if (quedanAsignaciones) {   // Si aún es posible asignar sensores a otros sensores se sigue
                boolean asignado = false;
                for (int s2 : destino) {
                    if (s1 != s2 && sensorApuntable(s2)) {
                        conexiones[s2].entrantes.add(s1);
                        conexiones[s1].destino = s2;
                        asignado = true;
                        break;
                    }
                }
                if (!asignado) quedanAsignaciones = false;
            }
            else {  // En caso contrario, añadimos todos los sensores no asignados a sensoresNoConectados para posteriormente devolverlos
                sensoresNoConectados.add(s1);
            }
        }
        return sensoresNoConectados;
    }


    /**
     * todo: Función para calcular el tráfico de datos de cada sensor y asignarselo recorriendo el grafo
     */
    public void calculateTraffic() {

    }


    /* ------------------ CREADORAS DE ESTADOS INICIALES -------------------- */


    /**
     * Este generador de estado inicial funciona de la siguiente forma: (Objetivo minimizar distancias, no tiene en cuenta costes ni tampoco apura en conseguir las mínimas distancias siempre)
     *      - Calcula las distancias de cada sensor al resto de centros.
     *      - Cada sensor es mapeado al centro que se encuentre más cercano
     *      - Asigna sensores a su centro sin llegar a sobrepasar el máximo de conexiones
     *      - El resto de sensores son asignados a sensores que estén conectados al centro al que estaban mapeados
     *
     * Pros:
     *  - Al conectar cercanos se minimizan las distancias en el cálculo del coste (estas se elevan al cuadrado lo que hace que minimizarlas sea aún más importante
     *  - Al organizarlo como clusters la probabilidad de que al final los elementos conectados sean los mismos que al inicio pero con un orden distinto es bastante elevada
     *  ...
     * Contras:
     *  - Al no tener en cuenta el volumen puede que los enchufes (sensores que conectan toda una estructura con un centro) formen un cuello de botella importante
     *  ...
     */
    public void generadorGreedyMinDist() {
        int n = sensores.size();
        int m = centros.size();

        // Mapeo de cada sensor al centro más cercano
        int[] centroAsignado = new int[n];      // Guarda el centro más cercano

        for (int i = 0; i < n; i++) {   // Por cada sensor
            centroAsignado[i] = getCentroMasCercano(i);
        }

        // Asignación de sensores a su centro más cercano respetando el máximo de conexiones
        List<Integer>[] sensoresPorCentro = new ArrayList[m];   // Esta estructura será útil para después poder conectar los sensores que se han quedado sin asignar a alguno que se haya conectado a su centro
        for (int i = 0; i < m; i++) {
            sensoresPorCentro[i] = new ArrayList<>();
        }

        for (int i = 0; i < n; i++) {
            int idCentro = centroAsignado[i];

            if (centroApuntable(idCentro)) {
                conexiones[i].destino = idCentro;
                incrementaContadorCentros(idCentro);
                sensoresPorCentro[idCentro].add(i);
            }
        }

        // Reasignamos los sensores que no han podido conectarse a su centro
        for (int i = 0; i < n; i++) {
            if (conexiones[i].destino == Integer.MAX_VALUE) {
                int idCentro = centroAsignado[i];

                // Buscamos a qué sensor conectarlo
                for (int sensor : sensoresPorCentro[idCentro]) {    // A la que encontramos uno al que nos podamos conectar lo hacemos y paramos (Es probable que se generen malas soluciones pero para empezar tenemos una aproximación
                    if (sensorApuntable(sensor)) {
                        conexiones[i].destino = sensor;
                        conexiones[sensor].entrantes.add(i);
                        break;
                    }
                }
            }
        }

        //todo llamar a una función que recorra el DAG calculando los volúmenes de datos que acaba enviando cada sensor
    }


    /**
     * Este generador de estado inicial funciona de la siguiente forma: (Objetivo reducir la pérdida de volumen por cuello de botella)
     * La idea es crear una estructura jerárquica donde los sensores con más capacidad de transmisión se encuentren en lo más bajo de la jerarquia mientras que al ir subiendo se disminuya el tráfico.
     *     - Separamos los sensores según la capacidad de transmisión que tengan (1/2/5 Mbps)
     *     - Los que tengan menos capacidad apuntan a los siguientes con menos capacidad y así hasta llega al final
     *     - Los sensores con mayor capacidad apuntan a los centros más cercanos minimizando así la distancia
     *
     * Pros:
     *  - Menos cuello de botella
     *  - Más ancho de banda
     *  ...
     * Contras:
     *  - Posibilidad de tener sensores de 5Mbps lejos de los centros generando rutas largas
     *  ...
     */
    public void generadorGreedyHierarchy() {
        int n = sensores.size();
        int m = centros.size();

        // Agrupamos los sensores por capacidad de transmisión
        List<Integer> sensores1 = new ArrayList<>();
        List<Integer> sensores2 = new ArrayList<>();
        List<Integer> sensores5 = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            double capacidad = sensores.get(i).getCapacidad();

            if (capacidad == 1.0) {
                sensores1.add(i);
            }
            else if (capacidad == 2.0) {
                sensores2.add(i);
            }
            else {
                sensores5.add(i);
            }
        }

        // Primero conectamos los de 5Mbps
        List<Integer> sensoresConectados5 = new ArrayList<>();
        List<Integer> sensoresNoConectados5 = new ArrayList<>();
        for (int sensor : sensores5) {
            int centroCercano = getCentroMasCercano(sensor);

            if (centroApuntable(centroCercano)) {
                conexiones[sensor].destino = centroCercano;
                incrementaContadorCentros(centroCercano);
                sensoresConectados5.add(sensor);
            }
            else sensoresNoConectados5.add(sensor);
        }

        // Conecto los distintos niveles de la jerarquia
        List<Integer> restantes = conectarSensores(sensoresNoConectados5, sensoresConectados5);
        // Intento conectar los sensores2 y los restantes a los sensores5
        sensores2.addAll(restantes);
        restantes = conectarSensores(sensores2, sensores5);
        // Intento conectar los sensores1 y los restantes a los sensores2
        sensores1.addAll(restantes);
        conectarSensores(sensores1, sensores2);
        // Conecto los sensores restantes a los sensores1
        conectarSensores(restantes, sensores1);

        //todo llamar a una función que recorra el DAG calculando los volúmenes de datos que acaba enviando cada sensor
    }

    /* --------------------------- OPERADORES ------------------------------- */



    /* --------------------------- HEURÍSTICAS ------------------------------ */



    /* ------------------------------ OTROS --------------------------------- */

    /**
     * La función de Goal en HC y SA siempre devuelve falso para seguir analizando
     */
    public boolean is_goal() {
        return false;
    }


    // Para depurar
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Estado:\n");
        for (int i = 0; i < conexiones.length; i++) {
            sb.append("Sensor ").append(i).append(" → ");
            if (conexiones[i].destino >= 0) {
                sb.append("Sensor ").append(conexiones[i].destino);
            } else {
                sb.append("Centro ").append(-conexiones[i].destino - 1);
            }
            sb.append(" (").append(conexiones[i].volumen).append(" Mw)\n");
        }
        return sb.toString();
    }
}
