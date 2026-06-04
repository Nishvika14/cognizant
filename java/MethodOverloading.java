public class MethodOverloading {

    static int add(int a, int b) {
        return a + b;
    }

    static double add(double a, double b) {
        return a + b;
    }

    static int add(int a, int b, int c) {
        return a + b + c;
    }

    public static void main(String[] args) {

        System.out.println("Two Integers: " + add(10, 20));
        System.out.println("Two Doubles: " + add(10.5, 20.7));
        System.out.println("Three Integers: " + add(10, 20, 30));
    }
}