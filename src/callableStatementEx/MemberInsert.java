package callableStatementEx;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import util.DBUtil;

public class MemberInsert {
  static Connection conn = DBUtil.getConnection();

  public static void main(String[] args) {
    String sql = "{CALL SP_MEMBER_INSERT(?,?,?,?,?)}"; // in-parameters 4개, out-parameter 1개

    String m_userid = "jenny";
    String m_pwd = "11112222";
    String m_email = "jenny@gmail.com";
    String m_hp = "020-202-2222";

    try(CallableStatement call = conn.prepareCall(sql))
    {
      // IN 파라미터 세팅
     call.setString(1, m_userid);
     call.setString(2, m_pwd);
     call.setString(3, m_email);
     call.setString(4, m_hp);

     // OUT 파라미터 세팅
      call.registerOutParameter(5, java.sql.Types.INTEGER);

      // 실행
      call.execute();

      int rtn = call.getInt(5);

      if(rtn == 100){
//        conn.rollback();
        System.out.println("이미 가입된 사용자입니다.");
      } else {
//        conn.commit();
        System.out.println("회원 가입이 되었습니다.");
      }

    } catch (SQLException e) {
      try {conn.rollback();} catch (SQLException e1){
        e1.printStackTrace();
      }
    }

  }

}
