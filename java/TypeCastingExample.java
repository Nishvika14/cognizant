public class TypeCastingExample {
    public static void main(String[] args) {

        double doubleValue = 99.99;

        int intValue = (int) doubleValue;

        System.out.println("Double Value: " + doubleValue);
        System.out.println("After Casting to int: " + intValue);

        int number = 50;

        double convertedDouble = number;

        System.out.println("Integer Value: " + number);
        System.out.println("After Casting to double: " + convertedDouble);
    }
}