public class StudentDAOTest {

    public static void main(String[] args) {

        StudentDAO dao =
                new StudentDAO();

        dao.insertStudent(4,"Rahul");

        dao.updateStudent(
                4,
                "Rahul Sharma");
    }
}