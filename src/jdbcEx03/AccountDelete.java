package jdbcEx03;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBUtil;

public class AccountDelete {

  public static void main(String[] args) {
    Connection con = DBUtil.getConnection();

    // SQL 문 작성
    String sql = new StringBuilder()
        .append(" DELETE FROM accounts where ano = ? ").toString();

    String queryAno = "333-333-3333";
    // PreparedStatement 작성
    try(PreparedStatement pstmt = con.prepareStatement(sql)) {
      pstmt.setString(1, queryAno);
      int rows = pstmt.executeUpdate();

      if (rows > 0 ) {
        System.out.println("삭제된 행의 수 : " + rows);
      } else {
        System.out.println("삭제 중 문제 발생함");
      }

      String sqlSelect = "SELECT * from accounts";

      ResultSet rs = pstmt.executeQuery(sqlSelect);
      while(rs.next()) {
        System.out.println("계좌번호 : " + rs.getString(1));
        System.out.println("계좌주 : " + rs.getString(2));
        System.out.println("계좌금액 : " + rs.getInt(3));
      }

    } catch (SQLException e) {
      e.printStackTrace();
    }

  }

}
