package jdbcEx01;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import util.DBUtil;

public class ConnectionDBUtilTest {

  public static void main(String[] args) {
    try {

      Connection con = DBUtil.getConnection(); // 도로 연결

      Statement stmt = con.createStatement(); // 자동차 ~ 일회성
      int result = stmt.executeUpdate("INSERT into person(id, name) values (102,'walker')");

      if (result == 1) {
        System.out.println("Insert successful!");
      }

      String selectSql = "select id, name from person";
      ResultSet rs = stmt.executeQuery(selectSql);

      while(rs.next()) {
        Person person = new Person();
        person.setId(rs.getInt(1));
        person.setName(rs.getString(2));
        System.out.println(person.toString());
      }



    } catch (Exception e) {
      throw new RuntimeException(e);
    }
  }

}
