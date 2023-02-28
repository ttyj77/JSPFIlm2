package controller;

import dbConn.ConnectionMaker;
import model.FilmDTO;
import model.UserDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FilmController {
    private Connection connection;

    public FilmController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }


    public ArrayList<FilmDTO> selectAll() {
        ArrayList<FilmDTO> list = new ArrayList<>();
        String query = "select * from film order by id";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                FilmDTO f = new FilmDTO();
                f.setId(resultSet.getInt("id"));
                f.setTitle(resultSet.getString("title"));
                f.setRating(resultSet.getString("rating"));
                f.setCountry(resultSet.getString("country"));
                f.setShowing(resultSet.getInt("showing"));
                f.setEnglish_title(resultSet.getString("english_title"));
                f.setSummary(resultSet.getString("summary"));
                f.setPoster_image(resultSet.getString("poster_image"));

                list.add(f);
            }

            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<FilmDTO> selectShow_0() {
        ArrayList<FilmDTO> list = new ArrayList<>();
        String query = "select * from film  where showing = 0 order by id";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                FilmDTO f = new FilmDTO();
                f.setId(resultSet.getInt("id"));
                f.setTitle(resultSet.getString("title"));
                f.setRating(resultSet.getString("rating"));
                f.setCountry(resultSet.getString("country"));
                f.setShowing(resultSet.getInt("showing"));
                f.setEnglish_title(resultSet.getString("english_title"));
                f.setSummary(resultSet.getString("summary"));
                f.setPoster_image(resultSet.getString("poster_image"));

                list.add(f);
            }

            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<FilmDTO> selectShow_1() {
        ArrayList<FilmDTO> list = new ArrayList<>();
        String query = "select * from film  where showing = 1 order by id";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                FilmDTO f = new FilmDTO();
                f.setId(resultSet.getInt("id"));
                f.setTitle(resultSet.getString("title"));
                f.setRating(resultSet.getString("rating"));
                f.setCountry(resultSet.getString("country"));
                f.setShowing(resultSet.getInt("showing"));
                f.setEnglish_title(resultSet.getString("english_title"));
                f.setSummary(resultSet.getString("summary"));
                f.setPoster_image(resultSet.getString("poster_image"));

                list.add(f);
            }

            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    public FilmDTO selectOne(int id) {
        FilmDTO f = null;
        String query = "select * from film where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                f = new FilmDTO();
                f.setId(resultSet.getInt("id"));
                f.setTitle(resultSet.getString("title"));
                f.setRating(resultSet.getString("rating"));
                f.setCountry(resultSet.getString("country"));
                f.setShowing(resultSet.getInt("showing"));
                f.setEnglish_title(resultSet.getString("english_title"));
                f.setSummary(resultSet.getString("summary"));
                f.setPoster_image(resultSet.getString("poster_image"));
                return f;
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }

    public void insert(FilmDTO f) {
        String query = "insert into film (title, summary,english_title,country,poster_image,showing,rating) values (?,?,?,?,?,?,?)";
        try {
            System.out.println("-------------------" + f.getTitle());
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, f.getTitle());
            pstmt.setString(2, f.getSummary());
            pstmt.setString(3, f.getEnglish_title());
            pstmt.setString(4, f.getCountry());
            pstmt.setString(5, f.getPoster_image());
            pstmt.setInt(6, f.getShowing());
            pstmt.setString(7, f.getRating());

            pstmt.executeUpdate();
            pstmt.close();

        } catch (SQLException e) {
            System.out.println("영화 입력오류.");
        }
    }

    //마지막 index값 구하기
    public int findLastIndex() {
        int index = 0;
        String query = "select id from film order by id desc limit 0,1;";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                index = resultSet.getInt(1);
                System.out.println("마지막 인덱스 값 : " + index);
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return index;
    }

    public Boolean delete(int id) {
        String query = "delete from film where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            pstmt.close();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Boolean update(FilmDTO filmDTO) {
        String query = "update film set title = ?, summary = ? where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, filmDTO.getTitle());
            pstmt.setString(2, filmDTO.getSummary());
            pstmt.setInt(3, filmDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

