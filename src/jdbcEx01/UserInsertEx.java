package jdbcEx01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class UserInsertEx {
  public static void main(String[] args) {
    Connection connection = null;
    try {
      // 1. DB의 드라이버를 찾아서 로드해야 한다. => Mysql JDBC 드라이버 등록

      // 클래스를 이름으로 찾아서 쓰는 법 : 리플렉션
      Class.forName("com.mysql.cj.jdbc.Driver");
      System.out.println("Driver loaded successfully");



      // 2. 드라이버로드가 OK라면, 연결 Connection 객체를 생성함
      // 추가로 serverTimezone을 맞춰줘야 함
      connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/bookmarketdb?serverTimezone=Asia/Seoul","root","mysql1234");
      System.out.println("Connection established!" + connection);

      // 3. Connection 객체가 생성되었다면, 쿼리문을 담아 Statements 객체에 담아 DBMS에게 전송한다.
      String sql = " insert into users(userid, username, userpassword, userage, useremail) " +
                   " values('10','신세계','1234',20,'shin@gmail.com')";


      // 4. 전송한 결과를 받아서 처리한다.
      int result = connection.createStatement().executeUpdate(sql);
      if (result == 1) {
        System.out.println("Insert successful!");
      } else {
        System.out.println("Insert failed");
      }

    } catch (ClassNotFoundException e) {
      System.out.println("Driver loaded failed!");
    } catch (SQLException e) {
      throw new RuntimeException(e);
    } finally {
      // 5. 다 사용한 Statements와 Connection 객체를 닫는다.
      if (connection != null) {
        try {
          connection.close();
          System.out.println("Connection closed!");
        } catch (SQLException e) {
          throw new RuntimeException(e);
        }
      }
    }


  }
}
