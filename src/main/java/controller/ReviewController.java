package controller;

import dbConn.ConnectionMaker;
import model.FilmDTO;
import model.ReviewDTO;

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
        System.out.println("insert Controller");
        System.out.println(reviewDTO.getScore());
        System.out.println(reviewDTO.getReview());
        System.out.println(reviewDTO.getNickname());
        System.out.println(reviewDTO.getWriter_id());
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
}
