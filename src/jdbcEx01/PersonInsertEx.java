package jdbcEx01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class PersonInsertEx {
  public static void main(String[] args) {

    try {
      // 1. DB의 드라이버를 찾아서 로드해야 한다. => Mysql JDBC 드라이버 등록
      Class.forName("com.mysql.cj.jdbc.Driver");
      System.out.println("Driver loaded successfully");
    }
    catch (ClassNotFoundException e) {
      System.out.println("Driver loaded failed!");
    }

    try(Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookmarketdb?serverTimezone=Asia/Seoul","root","mysql1234")) {
      System.out.println("Connection established!" + connection);


      // 3. Connection 객체가 생성되었다면, 쿼리문을 담아 Statements 객체에 담아 DBMS에게 전송한다.
      String sql = " insert into person(id, name) " +
                   " values(100,'홍길동')";

      // 4. 전송한 결과를 받아서 처리한다.
      int result = connection.createStatement().executeUpdate(sql);
      if (result == 1) {
        System.out.println("Insert successful!");
      } else {
        System.out.println("Insert failed");
      }

    } catch (SQLException e) {
      throw new RuntimeException(e);
    }


  }
}
