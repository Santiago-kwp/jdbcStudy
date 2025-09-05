package jdbcEx01;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AccountInsertTest {

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
      String sqlInsert = "INSERT INTO accounts(ano, owner, balance) values (?,?,?)";

      String sqlAlter = "ALTER TABLE mytable ADD PRIMARY KEY (id)";

      // PreparedStatement 얻기
      PreparedStatement pstmt = con.prepareStatement(sqlInsert);

      // 값 지정
      pstmt.setString(1, "1111-1212-3232-12121");
      pstmt.setString(2, "홍길동");
      pstmt.setInt(3, 100000);



      // SQL 문 실행
      int result = pstmt.executeUpdate();
      System.out.println("저장된 행의 수 " + result);



      // 자료가 잘 들어갔는지 확인
      String selectsql = "SELECT ano, owner, balance" +
            " FROM accounts WHERE owner = ?";
      try(PreparedStatement selectpstmt = con.prepareStatement(selectsql)){
         selectpstmt.setString(1, "홍길동");

          try (ResultSet rs = selectpstmt.executeQuery()) {

            while (rs.next()){
              System.out.println("계좌번호 :" + rs.getString(1));
              System.out.println("계좌주 :" + rs.getString(2));
              System.out.println("계좌총액 :" + rs.getInt(3));

            }
          }
        } catch (Exception e){
          e.printStackTrace();
        }


    } catch (SQLException e) {
      throw new RuntimeException(e);
    }

  }

}
