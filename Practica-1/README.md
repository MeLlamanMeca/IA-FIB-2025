# IA - HILL CLIMBING Y SIMULATED ANNEALING

## Requisitos

Antes de comenzar, asegúrate de cumplir con los siguientes requisitos:

- **Java 17 o superior** instalado en tu máquina.
- Acceso a un **entorno de terminal o línea de comandos**.
- Archivos `.jar` de las clases **AIMA** y **RedSensores** incluidos en el classpath.

---

## Pasos para Ejecutar el Programa

### 1. Abre una Terminal o Línea de Comandos

### 2. Compila y Ejecuta el Programa

- Si tienes el archivo `.jar` compilado, utiliza el siguiente comando:

   ```bash
   java -jar IA-FIB-2025.jar
   ```

- Si trabajas con el código fuente, primero compílalo:

   ```bash
   javac Main.java
   ```

   Luego, ejecuta el programa con:

   ```bash
   java Main
   ```

---

## Interacción con el Programa

El programa te guiará paso a paso para ingresar los parámetros necesarios:

### 1. **Semilla de Sensores**

    Ingresa un número entero para la semilla de los sensores (por ejemplo, 123).

### 2. **Semilla de Centros**

    Ingresa un número entero para la semilla de los centros (por ejemplo, 456).

### 3. **Estado Inicial**

    Selecciona el tipo de estado inicial deseado:

    - 1: Greedy de mínima distancia.
    - 2: Greedy jerárquico.
    - 3: Random.

    Ingresa un número entre 1 y 3.

### 4. **Algoritmo a Ejecutar**

    Selecciona el algoritmo que deseas ejecutar:

    - 1: HC (Hill Climbing).
    - 2: SA (Simulated Annealing).
    - 3: HC+SA (Combinación de ambos).

    Ingresa un número entre 1 y 3.

### 5. **Heurística a Ejecutar**

    Selecciona la heurística que deseas utilizar:

    - 1: Maximizar datos.
    - 2: Minimizar distancias.
    - 3: Datos entre distancia.
    - 4: Meca Heurística.

    Ingresa un número entre 1 y 4.

---

## Cierre del Programa

Una vez que hayas ingresado todas las opciones, el programa ejecutará el algoritmo y la heurística seleccionados.

---
## Resultados y Salida del Programa

Al finalizar la ejecución, el programa mostrará los resultados en la terminal. Estos resultados incluirán:

- **Coste de la solución**: El coste total de la solución final.
- **Datos transferidos (mb obtenidos : mb totales)**: Cantidad total de datos transferidos y datos totales.
- **Tiempo de ejecución (ms)**: El tiempo total que tomó el programa para completar la ejecución.

Si deseas guardar los resultados, puedes redirigir la salida a un archivo utilizando el siguiente comando:

```bash
java -jar IA-FIB-2025.jar > resultados.txt
```

---

## Solución de Problemas

Si encuentras algún problema durante la ejecución, verifica lo siguiente:

1. **Versiones de Java**: Asegúrate de que estás utilizando Java 17 o superior.
2. **Classpath**: Confirma que los archivos `.jar` necesarios están correctamente incluidos en el classpath.
3. **Errores de compilación**: Si trabajas con el código fuente, revisa los mensajes de error al compilar y corrige cualquier problema en el código.

---

## Contribuciones

No se aceptan contribuciones en estos momentos.
