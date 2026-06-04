public class OperatorPrecedence {
    public static void main(String[] args) {

        int result1 = 10 + 5 * 2;
        int result2 = (10 + 5) * 2;
        int result3 = 20 / 2 + 3 * 4;
        int result4 = 100 - 20 / 5;

        System.out.println("10 + 5 * 2 = " + result1);
        System.out.println("(10 + 5) * 2 = " + result2);
        System.out.println("20 / 2 + 3 * 4 = " + result3);
        System.out.println("100 - 20 / 5 = " + result4);

        System.out.println("\nExplanation:");
        System.out.println("Multiplication and Division are evaluated before Addition and Subtraction.");
        System.out.println("Parentheses have the highest precedence.");
    }
}