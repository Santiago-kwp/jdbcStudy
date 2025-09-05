package jdbcEx03;

import com.mysql.cj.x.protobuf.MysqlxPrepare.Prepare;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jdbcEx01.Person;
import util.DBUtil;

public class AccountAlter {

  public static void main(String[] args) {

    Connection con = DBUtil.getConnection();

    // SQL 문 작성
    String sql = new StringBuilder()
        .append("ALTER TABLE accounts ")
        .append("ADD column account_id ")
        .append("int auto_increment primary key").toString();

    try(PreparedStatement pstmt = con.prepareStatement(sql)) {

      int rows = pstmt.executeUpdate();
      if (rows > 0) {
        System.out.println("업데이트된 행의 수 " + rows);
      } else {
        System.out.println("업데이트 오류");
      }

      String selectSql = "select ano, owner, balance, account_id from accounts";
      ResultSet rs = pstmt.executeQuery(selectSql);

      while(rs.next()) {
        System.out.println(rs.getString(1));
        System.out.println(rs.getString(2));
        System.out.println(rs.getInt(3));
        System.out.println(rs.getInt(4));
      }

    } catch (SQLException e) {
      e.printStackTrace();
    }

  }

}
