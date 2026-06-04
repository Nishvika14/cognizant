import java.util.ArrayList;
import java.util.Scanner;

public class ArrayListExample {

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        ArrayList<String> students =
                new ArrayList<>();

        System.out.print(
                "How many names do you want to add? ");

        int count = sc.nextInt();
        sc.nextLine();

        for (int i = 1; i <= count; i++) {

            System.out.print(
                    "Enter student name " + i + ": ");

            students.add(sc.nextLine());
        }

        System.out.println("\nStudent Names:");

        for (String name : students) {
            System.out.println(name);
        }

        sc.close();
    }
}