import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCConnectionExample {

    public static void main(String[] args) {

        String url =
                "jdbc:mysql://localhost:3306/college";

        String user = "root";
        String password = "password";

        try {

            Connection conn =
                    DriverManager.getConnection(
                            url,
                            user,
                            password);

            Statement stmt =
                    conn.createStatement();

            ResultSet rs =
                    stmt.executeQuery(
                            "SELECT * FROM students");

            while (rs.next()) {

                System.out.println(
                        rs.getInt("id")
                                + " "
                                + rs.getString("name"));
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}