package jdbc_boards.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import jdbc_boards.util.DBUtil;
import jdbc_boards.vo.Board;

public class BoardDAO {
  private Connection conn;
  protected List<Board> boardList = new ArrayList<>();


  public boolean createBoard(Board board) {
    //1. Connection 필요
    conn = util.DBUtil.getConnection();
    // SQL 문 작성
    String sql = "Insert into boardtable(btitle, bcontent, bwriter, bdate) values(?,?,?, now())";

    try (PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)){

      pstmt.setString(1, board.getBtitle());
      pstmt.setString(2, board.getBcontent());
      pstmt.setString(3, board.getBwriter());


      int result = pstmt.executeUpdate();
      boolean ok = result > 0;

      int bno;

      // 생성된 PK를 Board 객체에 반영
      try (ResultSet rs = pstmt.getGeneratedKeys()) {
        if (rs.next()) {
          bno = rs.getInt(1);
          System.out.println("bno = " + bno);
//          board.setDatetime();
          board.setBno(bno);
          boardList.add(board);
        }
      }

      return ok;



    } catch (SQLException e) {
      e.printStackTrace();
      return false;
    }

  }

  /*** 전체 글 조회 (최신순으로 정렬)*/
  public List<Board> selectAll(){
    conn = DBUtil.getConnection();
    List<Board> boardList = new ArrayList<>();
    String sql = "SELECT bno, btitle, bcontent, bwriter, bdate FROM boardTable ORDER BY bno DESC";
    try(PreparedStatement pstmt = conn.prepareStatement(sql)){
      ResultSet rs = pstmt.executeQuery();
      while(rs.next()){
        Board board = new Board();
        board.setBno(rs.getInt("bno"));
        board.setBtitle(rs.getString("btitle"));
        board.setBcontent(rs.getString("bcontent"));
        board.setBwriter(rs.getString("bwriter"));
        board.setBdate(rs.getDate("bdate"));
        boardList.add(board);
      }

    } catch (Exception e) {
      e.printStackTrace();
    }
    return boardList;
  }

  // 글 수정 (제목, 내용만 수정)
  public boolean updateBoard(Board board) {
    conn = util.DBUtil.getConnection();
    String sql = "UPDATE boardTable SET btitle = ? , bcontent = ? WHERE bno = ? ";
    try(PreparedStatement pstmt = conn.prepareStatement(sql)){
      pstmt.setString(1, board.getBtitle());
      pstmt.setString(2, board.getBcontent());
      pstmt.setInt(3, board.getBno());
      int ack =  pstmt.executeUpdate();
      if (ack > 0)  return true;

    } catch (Exception e) {
      e.printStackTrace();
    }
    return false;
  }

  // 글 삭제

  public boolean deleteBoard(int bno) {
    conn = util.DBUtil.getConnection();
    String sql = "DELETE FROM boardTable WHERE bno = ?";
    try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
      pstmt.setInt(1, bno);
      int ack = pstmt.executeUpdate();
      if (ack > 0)  return true;
    }catch (Exception e) {
      e.printStackTrace();
    }
    return false;
  }



  /**
   * 데이터베이스 연결 및 게시글 데이터 읽어오기
   * DB에서 `boardtable` 테이블의 데이터를 읽어와 `boardList` 리스트에 저장합니다.
   */
  private void connect() {
    String sql = " select * from boardtable ";
    try(PreparedStatement pstmt = conn.prepareStatement(sql)) {
      ResultSet rs = pstmt.executeQuery();

      while (rs.next()) {
        Board board = new Board(rs.getInt("bno"),
            rs.getString("btitle"),
            rs.getString("bcontent"),
            rs.getString("bwriter"),
            rs.getDate("bdate"));

        boardList.add(board);

      }


    } catch (SQLException e) {
      e.printStackTrace();
    }

  }

  /** 글 한건 조회 */
  public Board selectOne(int bno){
    conn = util.DBUtil.getConnection();
    String sql = "select * from boardTable where bno = ?";
    try(PreparedStatement pstmt = conn.prepareStatement(sql)){
      pstmt.setInt(1, bno);
      try(ResultSet rs = pstmt.executeQuery()) {

        if (rs.next()) {
          Board board = new Board();
          board.setBno(rs.getInt("bno"));
          board.setBtitle(rs.getString("btitle"));
          board.setBcontent(rs.getString("bcontent"));
          board.setBwriter(rs.getString("bwriter"));
          board.setBdate(rs.getDate("bdate"));
          return board;
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }

}
