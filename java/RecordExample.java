import java.util.List;

record Person(String name, int age) {}

public class RecordExample {

    public static void main(String[] args) {

        Person p1 =
                new Person("John", 25);

        Person p2 =
                new Person("Alice", 17);

        Person p3 =
                new Person("David", 30);

        List<Person> persons =
                List.of(p1, p2, p3);

        System.out.println("All Persons:");

        persons.forEach(System.out::println);

        System.out.println(
                "\nAge >= 18");

        persons.stream()
                .filter(p -> p.age() >= 18)
                .forEach(System.out::println);
    }
}