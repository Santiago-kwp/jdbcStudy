package jdbcEx01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionTest {

  public static void main(String[] args) {
    String DriverName = "com.mysql.cj.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/bookmarketdb?serverTimezone=Asia/Seoul";
    String username = "root";
    String password = "mysql1234";

    try{
      Class.forName(DriverName);
      System.out.println("Driver loaded Ok!");
    } catch (Exception e) {
      System.out.println("Driver loaded failed");
    }

    try(Connection con = DriverManager.getConnection(url, username, password)) { // 도로 연결
      System.out.println("AutoCommit 상태: " + con.getAutoCommit());
      con.setAutoCommit(true);
      Statement stmt = con.createStatement(); // 자동차 만듦, but 일회성임
      int result = stmt.executeUpdate("INSERT INTO person(id, name) values (101,'강호동')");
      if (result == 1) {
        System.out.println("Insert successfully!");
      } else {
        System.out.println("Insert failed!");
      }
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }

  }

}
