import java.sql.*;

public class TransactionExample {

    public static void main(String[] args) {

        String url =
                "jdbc:mysql://localhost:3306/college";

        String user = "root";
        String password = "password";

        try {

            Connection conn =
                    DriverManager.getConnection(
                            url,user,password);

            conn.setAutoCommit(false);

            try {

                PreparedStatement debit =
                        conn.prepareStatement(
                                "UPDATE accounts SET balance = balance - ? WHERE id=?");

                debit.setDouble(1,1000);
                debit.setInt(2,1);
                debit.executeUpdate();

                PreparedStatement credit =
                        conn.prepareStatement(
                                "UPDATE accounts SET balance = balance + ? WHERE id=?");

                credit.setDouble(1,1000);
                credit.setInt(2,2);
                credit.executeUpdate();

                conn.commit();

                System.out.println(
                        "Transfer Successful");

            } catch(Exception e){

                conn.rollback();

                System.out.println(
                        "Transaction Failed");
            }

            conn.close();

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}