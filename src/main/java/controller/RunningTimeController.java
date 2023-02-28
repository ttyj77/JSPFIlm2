package controller;

import dbConn.ConnectionMaker;
import model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class RunningTimeController {

    private Connection connection;

    public RunningTimeController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }

    public void insert(RunningTimeDTO runningTimeDTO) {
        String query = "insert into runningTime (film_id, theater_id, time) values (?,?,?)";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, runningTimeDTO.getFilm_id());
            pstmt.setInt(2, runningTimeDTO.getTheater_id());
            pstmt.setTimestamp(3, runningTimeDTO.getTime());
            pstmt.executeUpdate();

            pstmt.close();

        } catch (SQLException e) {
            System.out.println("runningTime insert error.");
        }
    }

    public ArrayList<TimeTableDTO> selectRunningTable(int id) {
        //상영정보를 보여줄건데 해당 상영관 id + 해당 날짜 에 맞춰서 보여줘야 된다.
        //일단은 날짜 신경안쓰고 뽑자
        //뽑아야 되는 정보들 1,영화제목 상영시간 몇관인지 좌석 수 영화 시간 등급
        ArrayList<TimeTableDTO> list = new ArrayList<>();
        System.out.println("RT controller : " + id);
        String query = "select * from runningTime ru join theater th on th.id = ru.theater_id join cinema ci on ci.id = th.cinemaId join film f on f.id = ru.film_id where cinemaId = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                System.out.println("1111");
                TimeTableDTO t = new TimeTableDTO();
                t.setTitle(resultSet.getString("title"));
                t.setLength(resultSet.getInt("length"));
                t.setRating(resultSet.getString("rating"));
                t.setNumber(resultSet.getInt("number"));
                t.setScale(resultSet.getInt("scale"));
                t.setTime(resultSet.getTimestamp("time"));
                System.out.println("22222");
                list.add(t);


            }
            resultSet.close();
            pstmt.close();

        } catch (SQLException e) {
            System.out.println("runningTime select error.");
        }
        return list;
    }

}
