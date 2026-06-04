import java.lang.reflect.Method;

public class ReflectionExample {

    public static void main(String[] args)
            throws Exception {

        Class<?> cls =
                Class.forName("Student");

        Object obj =
                cls.getDeclaredConstructor()
                        .newInstance();

        Method[] methods =
                cls.getDeclaredMethods();

        for(Method m : methods){
            System.out.println(
                    m.getName());
        }

        Method greet =
                cls.getDeclaredMethod(
                        "greet");

        greet.invoke(obj);
    }
}