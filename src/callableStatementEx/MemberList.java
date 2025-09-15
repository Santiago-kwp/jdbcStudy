package callableStatementEx;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBUtil;

public class MemberList {

  public static void main(String[] args) {
    Connection conn = DBUtil.getConnection();
    String sql = "{CALL SP_MEMBER_LIST()}";
    try(CallableStatement call = conn.prepareCall(sql)) {

      ResultSet rs = call.executeQuery();

      if (!rs.next()) {
        System.out.println("결과가 없습니다.");
      }
      while (rs.next()) {
        System.out.println("m_seq    : " + rs.getInt(1));
        System.out.println("m_userid : " + rs.getString(2));
        System.out.println("m_pwd : " + rs.getString(3));
        System.out.println("m_email : " + rs.getString(4));
        System.out.println("m_hp : " + rs.getString(5));
        System.out.println("m_registdate : " + rs.getDate(6));
        System.out.println("m_point : " + rs.getInt(7));
      }

    } catch (SQLException e ) {
      e.printStackTrace();
    }
  }

}
