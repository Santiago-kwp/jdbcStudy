package callableStatementEx;

import java.lang.reflect.Member;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBUtil;

public class MemberDAO {
  Connection conn = DBUtil.getConnection();

  public static void main(String[] args) {
    MemberDAO memberDAO = new MemberDAO();

    MemberVO member1 = new MemberVO("Caroll","1111","caroll@test.com","010-2222-3333");

//    memberDAO.createMember(member1);
//    memberDAO.showMemberList();
    memberDAO.showMember(member1);

  }

  public void editInfoMember(MemberVO memberVO, int choice) {
    String sql = "{CALL SP_MEMBER_UPDATE(?,?,?)}";

    try(CallableStatement call = conn.prepareCall(sql)) {
//      call.setString(memberVO.getM_userid());
//      call.setInt(choice);
//      switch (choice) {
//        1 -> {call.setString(memberVO.getM);}
//
//      }


    } catch (SQLException e) {
      e.printStackTrace();
    }

  }


  public void showMember(MemberVO memberVO) {
    String sql = "{CALL SP_MEMBER_SHOW(?)}";

    try(CallableStatement call = conn.prepareCall(sql)) {
      call.setString(1, memberVO.getM_userid());

      ResultSet rs = call.executeQuery();

      if (!rs.next()) {
        System.out.println("없는 회원 정보입니다.");
      } else {
        System.out.println("m_seq    : " + rs.getInt(1));
        System.out.println("m_userid : " + rs.getString(2));
        System.out.println("m_pwd : " + rs.getString(3));
        System.out.println("m_email : " + rs.getString(4));
        System.out.println("m_hp : " + rs.getString(5));
        System.out.println("m_registdate : " + rs.getDate(6));
        System.out.println("m_point : " + rs.getInt(7));
      }



    } catch (SQLException e) {
      e.printStackTrace();
    }
  }

  public void showMemberList() {
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


  public void createMember(MemberVO memberVO) {
    String sql = "{CALL SP_MEMBER_INSERT(?,?,?,?,?)}"; // in-parameters 4개, out-parameter 1개


    try(
        CallableStatement call = conn.prepareCall(sql))
    {
      // IN 파라미터 세팅
      call.setString(1, memberVO.getM_userid());
      call.setString(2, memberVO.getM_pwd());
      call.setString(3, memberVO.getM_email());
      call.setString(4, memberVO.getM_hp());

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

    } catch (
        SQLException e) {
      try {conn.rollback();} catch (SQLException e1){
        e1.printStackTrace();
      }
    }

  }







}

/*
회원 수정 (비밀번호)를 수정할지 이메일을 수정할지 연락처를 수정할지를 선택해서 다중분기로 처리하기
회원 삭제(탈퇴하기)
*/
