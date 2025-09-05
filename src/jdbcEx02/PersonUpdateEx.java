package jdbcEx02;

// UPDATE 테이블명 SET (필드 = '수정값') WHERE num = 1;
// String sql = "UPDATE person SET id = ? , name = ? WHERE num = ?";
// String sql = new StringBuilder()
//              .append("UPDATE person ")
//              .append(" SET id = ? ")
//              .append(", name = ? ")
//              .append("WHERE num = ?").toString();

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jdbcEx01.Person;
import util.DBUtil;

public class PersonUpdateEx {

  public static void main(String[] args) {

    Connection con = DBUtil.getConnection();

    // 매개변수화된 UPDATE SQL문 작성
    String sql = new StringBuilder()
        .append(" update person set ")
        .append("id = ? ,")
        .append("name = ? ")
        .append(" WHERE num = ?").toString();

    // PreparedStatement 객체 생성하고 값 지정
    try(PreparedStatement pstmt = con.prepareStatement(sql)) {

      pstmt.setInt(1, 150);
      pstmt.setString(2, "도우너");
      pstmt.setInt(3, 1);

      // sql문 실행
      int rows = pstmt.executeUpdate();
      System.out.println(rows + " rows updated!");

      String selectSql = "select id, name from person";
      ResultSet rs = pstmt.executeQuery(selectSql);

      while(rs.next()) {
        Person person = new Person();
        person.setId(rs.getInt(1));
        person.setName(rs.getString(2));
        System.out.println(person.toString());
      }



    } catch (SQLException e) {
      e.printStackTrace();
    }
  }





}
