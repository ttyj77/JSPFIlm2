package controller;

import dbConn.ConnectionMaker;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LevelUpController {
    private Connection connection;

    public LevelUpController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }

    //요청을 보냈을 때 이미 요청을 보내 대기중인지 확인
    public int checkRequest(int id) {
        int requestRole = 0;
        String query = "select newRole from levelUp where user_id =?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                requestRole = resultSet.getInt(1); //여기에 값이 담긴다는건 등업을 요청했고 해당 값은 등업을 요청한 등급의 숫자다.
            }

            pstmt.close();
            resultSet.close();
            return requestRole;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requestRole;
    }
}
