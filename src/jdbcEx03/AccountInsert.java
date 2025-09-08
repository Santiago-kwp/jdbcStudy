package jdbcEx03;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBUtil;

public class AccountInsert {

  public static void main(String[] args) {
    // DB 연결 객체 받아오기
    Connection con = DBUtil.getConnection();

    // SQL 문 작성
    String sql = new StringBuilder()
        .append(" INSERT INTO ACCOUNTS(ano, owner, balance) ")
        .append(" VALUES (?, ?, ?) ").toString();

    // PreparedStatement 객체 생성하여 연결 객체에 sql 문 삽입
    try(PreparedStatement pstmt = con.prepareStatement(sql)) {

      // pstmt ? 인자 넣어주기
      pstmt.setString(1,"333-333-3333");
      pstmt.setString(2,"네스프레소");
      pstmt.setInt(3, 9999999);
      // insert 문 실행 후 결과 저장
      int rows = pstmt.executeUpdate();
      if (rows > 0) {
        System.out.println("삽입된 행의 수 : " + rows);
      } else {
        System.out.println("삽입 에러 발생");
      }

      // 저장된 데이터를 pstmt로 조회하기

      String sqlSelect = "SELECT * from accounts";
      ResultSet rs = pstmt.executeQuery(sqlSelect);

      while(rs.next()) {
        System.out.println("계좌번호: " + rs.getString(1));
        System.out.println("계좌주: " + rs.getString(2));
        System.out.println("계좌 총액: " + rs.getInt(3));
      }

    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

}
