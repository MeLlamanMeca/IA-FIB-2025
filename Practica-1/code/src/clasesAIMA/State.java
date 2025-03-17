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
    public static final int UNDEFINED = Integer.MAX_VALUE;




    /**
     * Clase interna que representa la información de conexiones de un sensor en el estado
     * Similar a una struct en c++
     */
    public static class ConexionSensor {
        // Lista de los ID's de sensores que apuntan a este sensor (máximo 3)
        public List<Integer> entrantes;
        // Destino al que envía: Si es un sensor es su ID, si es un centro es su ID negativa
        public int destino;
        // Volumen de datos que tiene el sensor en total, no tiene limite
        public double volumen;

        /**
         * Antes de llamarse debe haberse configurado el escenario con setStatic
         */
        public ConexionSensor(int i) {
            entrantes = new ArrayList<>();
            destino = UNDEFINED;    // Sin asignar
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
        contadorInputCentros = new int[m];  // Se inicializa a 0
        for (int i = 0; i < n; i++) {
            conexiones[i] = new ConexionSensor(i);
        }
    }

    public static void setEnvironment(Sensores s, CentrosDatos c) {
        sensores = s;
        centros = c;
    }

    /* ---------------------------- ÚTILES ---------------------------------- */

    /**
     * Añade la conexión i -> j
     * @param i sensor origen
     * @param j sensor destino
     */
    private void añadirConexion(int i, int j) {
        if (j >= 0) conexiones[j].entrantes.add(i);
        else incrementaContadorCentros(j);

        conexiones[i].destino = j;
    }

    /**
     * Elimina la conexión del sensor i
     *
     * @param i sensor origen
     */
    private void eliminarConexion(int i) {
        int j = conexiones[i].destino;

        if (j >= 0) conexiones[j].entrantes.remove(Integer.valueOf(i));
        else decrementaContadorCentros(j);

        conexiones[i].destino = UNDEFINED;
    }

    /**
     * Añade el volumen volumen al sensor destino de forma recursiva
     * @param destino sensor destino
     * @param volumen volumen a añadir
     */
    private void añadirVolumen(int destino, double volumen) {
        if(destino >= 0) {
            conexiones[destino].volumen += volumen;
            añadirVolumen(conexiones[destino].destino, volumen);
        }
        //todo: si queremos guardar el volumen en los centros hacerlo aquí
    }

    private void eliminarVolumen(int destino, double jvolumen) {
        if(destino >= 0) {
            conexiones[destino].volumen -= jvolumen;
            eliminarVolumen(conexiones[destino].destino, jvolumen);
        }
        //todo: si queremos guardar el volumen en los centros hacerlo aquí
    }


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
     * Decrementa en 1 el número de conexiones que tiene el centro con índice i
     * @param i identificador negativo del centro
     */
    private void decrementaContadorCentros(int i) {
        contadorInputCentros[-i - 1]--;
    }


    /**
     * Calcula la distancia entre i y j
     * @param i apunta a j
     * @param j es apuntado por i
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
     *  Comprueba si al sensor i se le puede añadir una conexión
     */
    public boolean sensorApuntable(int i) {return conexiones[i].entrantes.size() < 3;}


    /**
     *  Comprueba si al centro i se le puede añadir una conexión (i es un índice negativo)
     */
    public boolean centroApuntable(int i) {return contadorInputCentros[-i - 1] < 25;}


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
                    if (s1 != s2 && sensorApuntable(s2) && conexiones[s2].destino != UNDEFINED) {
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
     * Función para calcular el tráfico de datos de cada sensor y asignarselo recorriendo el grafo desde las hojas hasta los centros por niveles
     */
    private void calculateTraffic() {
        int n = conexiones.length;

        // Obtenemos las hojas del grafo original
        Queue<Integer> hojas = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (conexiones[i].entrantes.isEmpty()) {
                hojas.add(i);
            }
        }

        boolean[] visitado = new boolean[n];    // Uso un vector de visitados para evitar recalcular los costes de un mismo sensor al ser añadido dos veces por distintos sensores entrantes

        // Procesamos todas los sensores por niveles empezando desde las hojas (nivel 0)
        while(!hojas.isEmpty()) {
            int sensor = hojas.poll();

            if (!visitado[sensor]) {
                visitado[sensor] = true;

                double coste = 0.0;

                // Acumulamos la suma de volúmenes de todos los sensores entrantes al sensor actual
                for (int input : conexiones[sensor].entrantes) {
                    coste += datosTransmitidos(input);
                }

                // El nuevo volumen es el mínimo entre 3 veces su capacidad de transmisión y la suma de la transimisión de los sensores entrantes y su propia transmisión
                conexiones[sensor].volumen = sensores.get(sensor).getCapacidad() + coste;

                int output = conexiones[sensor].destino;
                if (output >= 0) {  // Si el destino es un sensor
                    // Añado el sensor a la cola
                    hojas.add(output);
                }
                else {  // Si el destino es un centro
                    // Podríamos guardar en algún lado el volumen que recibe cada centro ya que tiene un máximo de 150
                    // todo (si alguien lo ve una opción útil que lo implemente)
                }
            }
        }
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
     *  - Puede que sea asigne un sensor a un cluster cuando en realidad podría minimizar distancia uniendose a otro
     *  - Es posible que al asignar los sensores restantes dentro de un cluster apunten a sensores lejanos dentro del propio cluster
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
                sensoresPorCentro[-idCentro - 1].add(i);
            }
        }

        // Reasignamos los sensores que no han podido conectarse a su centro
        for (int i = 0; i < n; i++) {
            if (conexiones[i].destino == UNDEFINED) {
                int idCentro = centroAsignado[i];

                // Buscamos a qué sensor conectarlo
                for (int sensor : sensoresPorCentro[idCentro]) {    // A la que encontramos uno al que nos podamos conectar lo hacemos y paramos (Es probable que se generen malas soluciones pero para empezar tenemos una aproximación
                    if (sensorApuntable(sensor)) {
                        conexiones[i].destino = sensor;
                        conexiones[sensor].entrantes.add(i);
                        sensoresPorCentro[-idCentro - 1].add(i);
                        break;
                    }
                }
            }
        }

        // Recorremos al grafo para calcular los costes de cada sensor
        calculateTraffic();
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

        // todo ir restando conjuntos
        // Conecto los distintos niveles de la jerarquia
        List<Integer> restantes = conectarSensores(sensoresNoConectados5, sensoresConectados5);
        // Intento conectar los sensores2 y los restantes a los sensores5
        sensores2.addAll(restantes);
        restantes = conectarSensores(sensores2, sensores5);
        // Intento conectar los sensores1 y los restantes a los sensores2
        sensores1.addAll(restantes);
        restantes = conectarSensores(sensores1, sensores2);
        // Conecto los sensores restantes a los sensores1
        restantes = conectarSensores(restantes, sensores1);

        while (!restantes.isEmpty()) {
            restantes = conectarSensores(restantes, sensores1);
        }

        // Recorremos al grafo para calcular los costes de cada sensor
        calculateTraffic();
    }


    /**
     * Este generador de estado inicial funciona de la siguiente forma:
     *      - Para cada elemento del conjunto de sensores generamos una permutación aleatoria P
     *      - Tenemos una lista con el conjunto de sensores unión centros
     *      - Asignamos a cada elemento de P un indice aleatorio de la lista del conjunto de sensores y centros
     *      - Si dicho sensor o centro llega a su maximo grado de entrada, lo eliminamos de la lista
     *
     * Pros:
     *  - Coste lineal
     *  - Gran aleatoriedad
     *  - Nos permite ejecutarlo varias veces para no atascarnos en un minimo/maximo local
     *  ...
     * Contras:
     *  - No tiene en cuenta distancias
     *  - No tiene en cuenta velocidades
     *  - Puede generar cuellos de botella
     *  ...
     * Observación:
     *  - Es una solución inicial mala
     */
    public void generadorGreedyRandom() {
        int n = sensores.size();
        int m = centros.size();
        Random rand = new Random();

        // Crear un array con índices de sensores
        int[] sensoresArray = new int[n];
        for (int i = 0; i < n; i++) {
            sensoresArray[i] = i;
        }

        // Permutar sensoresArray usando Fisher-Yates
        for (int i = n - 1; i > 0; i--) {
            int j = rand.nextInt(i + 1);  // Número aleatorio entre 0 e i (inclusive)
            int temp = sensoresArray[i];
            sensoresArray[i] = sensoresArray[j];
            sensoresArray[j] = temp;
        }

        // Crear la lista SuC que contenga centros y sensores.
        ArrayList<Integer> SuC = new ArrayList<>();
        // Agregar centros (los representamos con números negativos: -1, -2, ..., -m)
        for (int i = 0; i < m; i++) {
            SuC.add(-(i + 1));
        }
        // Agregar sensores (números 0 a n-1)
        for (int i = 0; i < n; i++) {
            SuC.add(i);
        }

        // Para cada sensor se asigna un elemento aleatorio de SuC
        for (int i = 0; i < n; i++) {
            int randomIndex = rand.nextInt(SuC.size());
            int elegido = SuC.get(randomIndex); // Selecciona un elemento aleatorio de de SuC

            añadirConexion(sensoresArray[i], elegido); //TODO: funcion modificada, posible error AQUI. solucionar. La funcion ya no añade volumen al apuntado.

            if (elegido < 0) { // Es un centro
                if (!centroApuntable(elegido)) { // El centro ya no es apuntable
                    // Reemplazar el elemento en randomIndex con el último y eliminar el último (pop en tiempo constante)
                    int last = SuC.get(SuC.size() - 1);
                    SuC.set(randomIndex, last);
                    SuC.remove(SuC.size() - 1);
                }
            } else { // Es un sensor
                if (conexiones[elegido].entrantes.size() == 3) { // El sensor ya tiene 3 conexiones entrantes
                    int last = SuC.get(SuC.size() - 1);
                    SuC.set(randomIndex, last);
                    SuC.remove(SuC.size() - 1);
                }
            }
        }

        // Recorremos al grafo para calcular los costes de cada sensor
        calculateTraffic();
    }


    /* --------------------------- OPERADORES ------------------------------- */

    public boolean swap(int i, int j) {

        int jDestino = conexiones[j].destino;
        int iDestino = conexiones[i].destino;
        double jVolumen = conexiones[j].volumen;
        double iVolumen = conexiones[i].volumen;

        eliminarConexion(i);
        eliminarConexion(j);
        añadirConexion(i, jDestino);
        añadirConexion(j, iDestino);

        if(!confirmarCambios(List.of(i,j))) return false;

        eliminarVolumen(jDestino,jVolumen);
        eliminarVolumen(iDestino,iVolumen);
        añadirVolumen(jDestino, iVolumen);
        añadirVolumen(iDestino, jVolumen);

        return true;
    }



    public boolean move(int i, int j) {

        if(j >= 0){if(!sensorApuntable(j)) return false;}
        else if(!centroApuntable(j)) return false;

        int iDestino = conexiones[i].destino;
        double iVolumen = conexiones[i].volumen;

        eliminarConexion(i);
        añadirConexion(i, j);

        if(!confirmarCambios(Collections.singletonList(i))) return false;

        eliminarVolumen(iDestino,iVolumen);
        añadirVolumen(j, iVolumen);

        return true;
    }

    public boolean circularSwap(List<Integer> lista) {

        int n = lista.size();

        int i1Destino = conexiones[lista.get(0)].destino;
        for (int i = 0; i < n-1; i++) {if (!move(lista.get(i), conexiones[lista.get(i+1)].destino)) return false;}
        if (!move(lista.get(n-1), i1Destino)) return false;

        return true;
    }


    /* --------------------------- HEURÍSTICAS ------------------------------ */

    // No se muy bien como se conecta con el AIMA, pero hago unos ejemplos de un par de euristicas sencillas
    /**
     * Mientras mas datos se transmitan en las conexiones, la heuristica retorna un valor menor
     */
    public double heuristicaMaximizarDatos() {
        double volumenTotal = 0.0;
        for (int i = 0; i < conexiones.length; i++) {
            volumenTotal += datosTransmitidos(i);
        }
        return -volumenTotal; // Negativo para buscar los minimos con el hill climbing
    }


    /**
     * La heuristica retorna la distancia de todas las conexiones
     *
     *      Nota: esta heuristica parece muy mala. Si solo tenemos en cuenta las distancias, se eviatarà añadir nuevas aristas.
     */
    public double heuristicaMinimizarDistancias() {
        double distanciasTotales = 0.0;
        for (int i = 0; i < conexiones.length; i++) {
            distanciasTotales += calcularDistancia(i, conexiones[i].destino);
        }
        return distanciasTotales;
    }


    /**
     * Busca sacar el mayor partido posible a cada Mb/distancia
     */
    public double heuristicaDatosEntreDistancia() {
        double datosTotales = heuristicaMaximizarDatos();
        double distanciasTotales = heuristicaMinimizarDistancias();

        return datosTotales/distanciasTotales;
    }


    /**
     * Busca combinar la heuristica de datos y de distancias dandole un peso a cada una
     * - Alpha es el peso de las datos
     * - Beta es el peso de los distancias
     *
     *      Nota: Dejo como parametros alpha y beta porque podemos experimentar con estos valores.
     *      A priori, parece mas importante maximizar los datos por lo que: alpha > beta
     */
    public double heuristicaMaximizarDatosMinimizarDistancias(double alpha, double beta) {
        double heuristicaDatos = heuristicaMaximizarDatos();
        double heuristicaDistancias = heuristicaMinimizarDistancias();

        return alpha*heuristicaDatos + beta*heuristicaDistancias;
    }

    /**
     * Busca balancear la carga de datos para que se acerquen a la optima.
     * Asi evitamos cuellos de botella y no aprovechar la transferencia al maximo.
     * - Si no llega a la carga máxima, le sumamos lo que falte para llegar
     * - Si se pasa, sumamos lo que se pasa
     */
    public double heuristicaSobrecarga() {
        double diferencia = 0.0;

        for (int i = 0; i < conexiones.length; i++) {
            double capacidad = sensores.get(i).getCapacidad();  // Asegurar que getCapacidad() retorna double
            double volumenTransmitido = datosTransmitidos(i); // Asegurar que volumen también es double
            diferencia += Math.abs(capacidad*3 - volumenTransmitido);
        }

        return diferencia;
    }

    double[] mejorDistancia = new double[sensores.size()]; //variable global que solo utiliza mi funcion. En caso de no usar esta heuristica, no se inicializa.
    public double mecaHeuristica() {

        if (mejorDistancia[1] == 0.0) {
            for (int i = 0; i < sensores.size(); i++) {
                mejorDistancia[i] = UNDEFINED;
                for (int j = 0; j < sensores.size(); j++) {
                    if(j != i) mejorDistancia[i] = Math.min(mejorDistancia[i],calcularDistancia(i, j));
                }
                for(int j = 1; j <= centros.size(); j++) {
                    mejorDistancia[i] = Math.min(mejorDistancia[i],calcularDistancia(i, -j));
                }
            }
        }

        double load = 0.0;
        double distancia = 0.0;
        for (int i = 0; i < conexiones.length; i++) {



            if(sensores.get(i).getCapacidad()*3 >= conexiones[i].volumen) {
                load += sensores.get(i).getCapacidad();
                distancia += calcularDistancia(i, conexiones[i].destino) - mejorDistancia[i];
            }
            else {
                double penalizacion = (conexiones[i].volumen - sensores.get(i).getCapacidad()*3);
                load -= penalizacion * penalizacion;
                distancia += calcularDistancia(i, conexiones[i].destino) - mejorDistancia[i];
            }
        }

        return -load/(distancia*distancia);
    }


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
            sb.append(" (").append(datosTransmitidos(i) + ":" + conexiones[i].volumen).append(" Mb)\n");
        }
        return sb.toString();
    }

    public double datosTransmitidos(int i) {
        return Math.min(conexiones[i].volumen,sensores.get(i).getCapacidad()*3);
    }

    public int numSensores() {
        return sensores.size();
    }
    public int numCentros() {
        return centros.size();
    }

    public State copy() { //TODO checkear que sea correcto, generado automaticamente.
        State nuevo = new State();
        for (int i = 0; i < conexiones.length; i++) {
            nuevo.conexiones[i].destino = conexiones[i].destino;
            nuevo.conexiones[i].volumen = conexiones[i].volumen;
            for (int j = 0; j < conexiones[i].entrantes.size(); j++) {
                nuevo.conexiones[i].entrantes.add(conexiones[i].entrantes.get(j));
            }
        }
        for (int i = 0; i < contadorInputCentros.length; i++) {
            nuevo.contadorInputCentros[i] = contadorInputCentros[i];
        }
        return nuevo;
    }

    public boolean confirmarCambios(List<Integer> s) {
        int n = s.size();
        boolean[] finalizado = new boolean[n]; //se inicializa a false por defecto
        int[] posicion_actual = new int[n];
        for (int i = 0; i < n; i++) {posicion_actual[i] = s.get(i);}
        while (n > 0) {
            for (int i = 0; i < s.size(); ++i) {
                //mientras no sepamos que un sensor llega a un centro, continuamos mirando.
                if (!finalizado[i]) {
                    posicion_actual[i] = conexiones[posicion_actual[i]].destino;

                    //CICLO EN EL GRAFO
                    if (posicion_actual[i] == s.get(i)) {
                        return false;
                    }

                    //EL SENSOR APUNTA DIRECTAMENTE O INDIRECTAMENTE A UN CENTRO
                    if (posicion_actual[i] < 0) {
                        finalizado[i] = true;
                        --n;
                    }
                }
            }
        }

        return true;
    }
}
