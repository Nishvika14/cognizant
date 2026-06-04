import java.sql.*;

public class StudentDAO {

    private final String url =
            "jdbc:mysql://localhost:3306/college";

    private final String user = "root";
    private final String password = "password";

    public void insertStudent(
            int id,
            String name) {

        try {

            Connection conn =
                    DriverManager.getConnection(
                            url,
                            user,
                            password);

            PreparedStatement ps =
                    conn.prepareStatement(
                            "INSERT INTO students VALUES (?,?)");

            ps.setInt(1, id);
            ps.setString(2, name);

            ps.executeUpdate();

            conn.close();

            System.out.println("Student Added");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void updateStudent(
            int id,
            String name) {

        try {

            Connection conn =
                    DriverManager.getConnection(
                            url,
                            user,
                            password);

            PreparedStatement ps =
                    conn.prepareStatement(
                            "UPDATE students SET name=? WHERE id=?");

            ps.setString(1, name);
            ps.setInt(2, id);

            ps.executeUpdate();

            conn.close();

            System.out.println("Student Updated");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}