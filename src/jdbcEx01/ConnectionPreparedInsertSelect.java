package jdbcEx01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ConnectionPreparedInsertSelect {

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

      // 매개변수화된 SQL 문 ~ Mysql server 안에 캐시가 존재하고, 이 캐시안에 insert문을 저장하여 매개변수를 빠르게 처리
      String sqlInsert = "INSERT INTO users(userid, username, userpassword, userage, useremail) values (?,?,?,?,?)";

      // PreparedStatement 얻기
      PreparedStatement pstmt = con.prepareStatement(sqlInsert);

      // 값 지정
      pstmt.setString(1, "test01");
      pstmt.setString(2, "신호등");
      pstmt.setString(3, "123456");
      pstmt.setString(5, "test01@gmail.com");
      pstmt.setInt(4, 20);


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
