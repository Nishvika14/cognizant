public class PatternMatchingSwitch {

    static void checkType(Object obj) {

        switch (obj) {

            case Integer i ->
                    System.out.println(
                            "Integer: " + i);

            case String s ->
                    System.out.println(
                            "String: " + s);

            case Double d ->
                    System.out.println(
                            "Double: " + d);

            case Long l ->
                    System.out.println(
                            "Long: " + l);

            case null ->
                    System.out.println(
                            "Null value");

            default ->
                    System.out.println(
                            "Unknown Type");
        }
    }

    public static void main(String[] args) {

        checkType(100);
        checkType("Java");
        checkType(99.99);
        checkType(123456789L);
        checkType(null);
    }
}