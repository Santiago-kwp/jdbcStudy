package jdbcEx01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnectionPreparedInsert {

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

      // 매개변수화된 SQL 문
      String sql = "INSERT INTO person(id, name) values (?,?)";

      // PreparedStatement 얻기
      PreparedStatement pstmt = con.prepareStatement(sql);

      // 값 지정
      pstmt.setInt(1, 100);
      pstmt.setString(2, "신길동"); // java쪽에서 넘기므로 문자열은 " "

      // SQL 문 실행
      int result = pstmt.executeUpdate();
      System.out.println("저장된 행의 수 " + result);

      if (result == 1) {
        System.out.println("insert successful!");
      }



    } catch (SQLException e) {
      throw new RuntimeException(e);
    }

  }

}
