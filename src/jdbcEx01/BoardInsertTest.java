package jdbcEx01;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class BoardInsertTest {

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
      String sqlInsert = "INSERT INTO boards(btitle, bcontent, bwriter, bdate, bfilename, bfiledata) values (?,?,?,now(),?,?)";

      // PreparedStatement 얻기  + 자동 증가되는 bno 값을 보고 싶을 때
      PreparedStatement pstmt = con.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS);

      // 값 지정
      pstmt.setString(1, "spring");
      pstmt.setString(2, "봄입니다. 꽃이 동산에 가득하네요");
      pstmt.setString(3, "사진작가");
      pstmt.setString(4, "spring.jpg");
      pstmt.setBlob(5, new FileInputStream("C:/Temp/spring.jpg"));


      // SQL 문 실행
      int result = pstmt.executeUpdate();
      System.out.println("저장된 행의 수 " + result);

      // bno 값 확인
      int bno = 0;

      if (result == 1) {
        ResultSet rs = pstmt.getGeneratedKeys();
        if (rs.next()) {
          bno = rs.getInt(1);
          System.out.println("bno = " + bno);
        }
        rs.close();
      }

      // 자료가 잘 들어갔는지 확인

      if (bno != -1) {
        String selectsql = "SELECT bno, btitle, bcontent, bwriter, bdate, bfilename" +
            " FROM boards WHERE bno = ?";
        try(PreparedStatement selectpstmt = con.prepareStatement(selectsql)){
          selectpstmt.setInt(1, bno);

          try (ResultSet rs = selectpstmt.executeQuery()) {

            while (rs.next()){
              bno = rs.getInt(1);
              System.out.println("bno = " + bno);
              System.out.println("btitle = " + rs.getString(2));
              System.out.println("bcontent = " + rs.getString(3));
              System.out.println("bwriter = " + rs.getString(4));
              System.out.println("bdate = " + rs.getTimestamp(5));
              System.out.println("bfilename = " + rs.getString(6));
            }
          }
        } catch (Exception e){
          e.printStackTrace();
        }
      }



    } catch (SQLException e) {
      throw new RuntimeException(e);
    } catch (FileNotFoundException e) {
      throw new RuntimeException(e);
    }

  }

}
