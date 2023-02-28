package controller;

import dbConn.ConnectionMaker;
import model.CinemaDTO;
import model.FilmDTO;
import model.TheaterDTO;
import model.UserDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CinemaController {

    private Connection connection;

    public CinemaController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }

    public void insert(CinemaDTO cinemaDTO) {
        System.out.println(cinemaDTO.getNumber());
        System.out.println(cinemaDTO.getCity_id());
        System.out.println(cinemaDTO.getArea());
        System.out.println(cinemaDTO.getName());
        String query = "insert into cinema (name, location, cinemaRoom,roomScale,information,information2,number,city_id,area) values (?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, cinemaDTO.getName());
            pstmt.setString(2, cinemaDTO.getLocation());
            pstmt.setString(3, cinemaDTO.getCinemaRoom());
            pstmt.setString(4, cinemaDTO.getRoomScale());
            pstmt.setString(5, cinemaDTO.getInformation());
            pstmt.setString(6, cinemaDTO.getInformation2());
            pstmt.setString(7, cinemaDTO.getNumber());
            pstmt.setInt(8, cinemaDTO.getCity_id());
            pstmt.setString(9, cinemaDTO.getArea());

            pstmt.executeUpdate();
            pstmt.close();

        } catch (SQLException e) {
            System.out.println("영화관 입력 오류");
        }
    }


    public ArrayList<CinemaDTO> selectAll() {
        ArrayList<CinemaDTO> list = new ArrayList<>();
        String query = "SELECT * FROM cinema";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                CinemaDTO t = new CinemaDTO();
                t.setId(resultSet.getInt("id"));
                t.setName(resultSet.getString("name"));
                t.setLocation(resultSet.getString("location"));
                t.setInformation(resultSet.getString("information"));
                t.setInformation2(resultSet.getString("information2"));
                t.setCinemaRoom(resultSet.getString("cinemaRoom"));
                t.setRoomScale(resultSet.getString("roomScale"));
                t.setArea(resultSet.getString("area"));
                list.add(t);
            }

            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<CinemaDTO> selectCity(int city_id) {
        ArrayList<CinemaDTO> list = new ArrayList<>();
        String query = "SELECT * FROM cinema where city_id = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, city_id);
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                CinemaDTO t = new CinemaDTO();
                t.setId(resultSet.getInt("id"));
                t.setName(resultSet.getString("name"));
                t.setLocation(resultSet.getString("location"));
                t.setNumber(resultSet.getString("number"));
                t.setInformation(resultSet.getString("information"));
                t.setInformation2(resultSet.getString("information2"));
                t.setCinemaRoom(resultSet.getString("cinemaRoom"));
                t.setRoomScale(resultSet.getString("roomScale"));
                t.setArea(resultSet.getString("area"));
                list.add(t);
            }

            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public CinemaDTO selectOne(int id) {
        CinemaDTO t = null;
        String query = "select * from cinema where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                t = new CinemaDTO();
                t.setId(resultSet.getInt("id"));
                t.setName(resultSet.getString("name"));
                t.setLocation(resultSet.getString("location"));
                t.setNumber(resultSet.getString("number"));
                t.setInformation(resultSet.getString("information"));
                t.setInformation2(resultSet.getString("information2"));
                t.setCinemaRoom(resultSet.getString("cinemaRoom"));
                t.setRoomScale(resultSet.getString("roomScale"));
                t.setArea(resultSet.getString("area"));

                return t;
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return t;
    }


    public ArrayList<TheaterDTO> selectCinema(int id) {
        ArrayList<TheaterDTO> list = new ArrayList<>();
        String query = "select t.id,t.cinemaId,t.scale,t.number from cinema ci join theater t on t.cinemaId = ci.id where ci.id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                TheaterDTO t = new TheaterDTO();
                t.setId(resultSet.getInt("id"));
                t.setCinema_id(resultSet.getInt("cinemaId"));
                t.setScale(resultSet.getInt("scale"));
                t.setNumber(resultSet.getInt("number")); //1관 2관
                list.add(t);
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    public Boolean delete(int id) {
        String query = "delete from cinema where id = ?";

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

    public Boolean update(CinemaDTO cinemaDTO) {
        String query = "update cinema set name = ?, number = ?, location = ? where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, cinemaDTO.getName());
            pstmt.setString(2, cinemaDTO.getNumber());
            pstmt.setString(3, cinemaDTO.getLocation());
            pstmt.setInt(4, cinemaDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
