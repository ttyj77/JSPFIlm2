package controller;

import dbConn.ConnectionMaker;
import model.FilmDTO;
import model.ReviewDTO;
import model.UserDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReviewController {

    private Connection connection;

    public ReviewController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }

    public int reviewCount(int filmId) {
        int num = 0;

        String query = "select count(*) from review re join film f on re.film_id = f.id where f.id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, filmId);
            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                num = resultSet.getInt(1); //총 리뷰개수
            }
            pstmt.close();
            resultSet.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return num;
    }


    public ArrayList<ReviewDTO> selectOneReviewList(int film_id) {
        ArrayList<ReviewDTO> list = new ArrayList<>();
        String query = "SELECT * FROM film.review where film_id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, film_id);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                ReviewDTO r = new ReviewDTO();
                r.setId(resultSet.getInt("id"));
                r.setScore(resultSet.getInt("score"));
                r.setReview(resultSet.getString("review"));
                r.setNickname(resultSet.getString("nickname"));
                r.setWriter_id(resultSet.getInt("writer_id"));
                list.add(r);
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public double avgReview(int film_id) {
        double average = (double) 0;
        String query = "select sum(score),count(*) from review where film_id =?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, film_id);
            ResultSet resultSet = pstmt.executeQuery();
            int reviewSum = 0;
            int count = 0;
            if (resultSet.next()) {
                reviewSum = resultSet.getInt(1); //리뷰 총 점수합계
                count = resultSet.getInt(2); //총 리뷰 개수

            }
            try {
                average = (double) reviewSum / count;
            } catch (Exception e) {
                System.out.println("아직 리뷰가 존재하지 않음");
            }
            pstmt.close();
            resultSet.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return average;
    }

    public void insert(ReviewDTO reviewDTO) {
        String query = "insert into review (review, film_id,writer_id, nickname,score) values ( ?,?,?,?,?)";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, reviewDTO.getReview());
            pstmt.setInt(2, reviewDTO.getFilm_id());
            pstmt.setInt(3, reviewDTO.getWriter_id());
            pstmt.setString(4, reviewDTO.getNickname());
            pstmt.setInt(5, reviewDTO.getScore());
            System.out.println("end");
            pstmt.executeUpdate();
            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //중복해서 리뷰등록 못하게 막기 평론 empty 여부로 일반회원일때 달았는지 평론가였을때 달았는지 체크
    public boolean doubleCheck(int filmId, UserDTO logIn) {
        System.out.println("doubleCheck ");
        String query = "select * from review re join user u on u.id = re.writer_id join film f on f.id = re.film_id where film_id = ? and u.id = ?";

        int customer_score = 0;
        int reviewer_score = 0;
        //일반회원이였다가 평론가로 등업하거나 반대의 경우에는 해당 쿼리문의 결과가 두개이다.
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, filmId);
            pstmt.setInt(2, logIn.getId());
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                int score = resultSet.getInt("score");
                String review = resultSet.getString("review");
                if (score == 0 && review.isEmpty()) { //리뷰를 작성하지 않은 경우
                    return true; //근데 이 경우면 와일문으로 안나오지 않나 ... 나오나?
                } else if (score > 0 && review.isEmpty()) { //score는 있지만 review는 없는 경우 - 일반인 평점만 달았던 경우
                    customer_score++;
                } else if (!review.isEmpty()) { //리뷰가 작성되있는 경우 -평론가
                    reviewer_score++;
                }
                System.out.println("while 문");
            }

            System.out.println(reviewer_score + "----" + customer_score);
            if (customer_score == 0 && reviewer_score == 0) {
                return true;
            } else if (customer_score > 0 && logIn.getRole() == 3 && reviewer_score == 0) { //일반 회원일 때 작성한 경우
                return true;
            } else if (reviewer_score > 0 && logIn.getRole() == 1 && customer_score == 0) { //평론가로써 작성한 적은 있지만 일반회원으로는 없을 때
                return true;
            } else { // 둘 다 작성한 경우
                return false;
            }

        } catch (Exception e) {
            System.out.println("doubleCheck error");
        }
        return false;
    }
}
