package jdbc_boards.vo;


import java.text.SimpleDateFormat;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Board {
  private int bno;
  private String btitle;
  private String bcontent;
  private String bwriter;
  private Date datetime;

  @Override
  public boolean equals(Object object) {
    Board other = (Board) object;
    return this.bno == other.bno;
  }

//  SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

  @Override
  public String toString() {
    return "글번호 : " + this.bno + ", 글 제목: " + this.btitle + " 작성자 : "
        + this.bwriter + " 작성일 : " + this.datetime;
  }

  public void setBdate(Date datetime) {
    this.datetime = datetime;
  }

  public Date getBdate() {
    return this.datetime;
  }






}
