package callableStatementEx;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@ToString
@NoArgsConstructor
@Getter
@Setter
public class MemberVO {
  private int m_seq;
  private String m_userid;
  private String m_pwd;
  private String m_email;
  private String m_hp;
  private Date m_registdate;
  private int m_point;

  // 생성자 하나 더 만들기
  public MemberVO(String m_userid, String m_pwd, String m_email, String m_hp) {
    this.m_userid = m_userid;
    this.m_pwd = m_pwd;
    this.m_email = m_email;
    this.m_hp = m_hp;
  }

}
