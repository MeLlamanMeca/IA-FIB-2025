package IA.ProbIA5;

/**
 * Created by bejar on 17/01/17.
 */
public class ProbIA5Board {
    /* Class independent from AIMA classes
       - It has to implement the state of the problem and its operators
     *

    /* State data structure
        vector with the parity of the coins (we can assume 0 = heads, 1 = tails
     */

    private int [] board;
    private static int [] solution;

    /* Constructor */
    public ProbIA5Board(int []init, int[] goal) {

        board = new int[init.length];
        solution = new int[init.length];

        for (int i = 0; i< init.length; i++) {
            board[i] = init[i];
            solution[i] = goal[i];
        }

    }

    /* Operator */
    public void flip_it(int i){
        if (i < 0 || i >= board.length - 1) return;
        board[i] = 1 - board[i];
        board[i+1] = 1 - board[i+1];
    }

    /* Heuristic function */
    public double heuristic(){
        // compute the number of coins out of place respect to solution
        int misplaced = 0;
        for (int i = 0; i < board.length; i++) {
            if (board[i] != solution[i]) misplaced++;
        }
        return misplaced;
    }

     /* Goal test */
     public boolean is_goal(){
         return java.util.Arrays.equals(board, solution);
     }

     /* auxiliary functions */

     /* Crea una copia del estado */
     public ProbIA5Board copy() {
         return new ProbIA5Board(board, solution);
     }

    /* Devuelve el estado actual como String */
    public String toString() {
        return java.util.Arrays.toString(board);
    }

    public int[] getBoard() {
        return board;
    }

}
