package jdbcEx03;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBUtil;

public class AccountSearch {

  public static void main(String[] args) {
    Connection con = DBUtil.getConnection();

    // SQL 문 작성
    String sql = new StringBuilder()
        .append(" Select owner, balance")
        .append(" from accounts where ano = ? ").toString();

    // PreparedStatement 작성
    String queryAno = "333-333-3333";
    try (PreparedStatement pstmt = con.prepareStatement(sql)) {
      pstmt.setString(1, queryAno);
      ResultSet rs = pstmt.executeQuery();

      while(rs.next()) {
        System.out.println("계좌주: " + rs.getString(1));
        System.out.println("계좌 총액: " + rs.getInt(2));
      }
    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

}
