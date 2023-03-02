package controller;

import dbConn.ConnectionMaker;
import model.LeverUpDTO;
import model.ReviewDTO;
import model.UserDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserController {
    private Connection connection;

    public UserController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }

    public boolean insert(UserDTO userDTO) {
        String query = "insert into user (username, password, nickname,name) values (?,?,?,?)";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, userDTO.getUsername());
            pstmt.setString(2, userDTO.getPassword());
            pstmt.setString(3, userDTO.getNickname());
            pstmt.setString(4, userDTO.getName());

            pstmt.executeUpdate();

            pstmt.close();

        } catch (SQLException e) {
            System.out.println("중복된 아이디로 가입할 수 없습니다.");
            return false;
        }
        return true;
    }


    public UserDTO auth(String username, String password) {
        String query = "select * from user where username = ? and password = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password);


            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                UserDTO userDTO = new UserDTO();
                userDTO.setId(resultSet.getInt("id"));
                userDTO.setUsername(resultSet.getString("username"));
                userDTO.setNickname(resultSet.getString("nickname"));
                userDTO.setRole(resultSet.getInt("role"));
//                userDTO.setPassword(resultSet.getString("password")); // 보안상으로 매우 취약하다

                return userDTO;
            }

            resultSet.close();
            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public void update(UserDTO userDTO) {
        String query = "update user set  nickname = ? ,name=? where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, userDTO.getNickname());
            pstmt.setString(2, userDTO.getName());
            pstmt.setInt(3, userDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void delete(int id) {
        String query = "delete from user where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public UserDTO selectOne(int id) {
        UserDTO u = null;
        String query = "select * from user where id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                u = new UserDTO();
                u.setId(resultSet.getInt("id"));
                u.setNickname(resultSet.getString("nickname"));
                u.setUsername(resultSet.getString("username"));
                u.setName(resultSet.getString("name"));
                u.setRole(resultSet.getInt("role"));
                return u;
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    public Boolean levelUp(LeverUpDTO leverUpDTO) {
        String query = "insert into levelUp (user_id, oldRole,newRole) values (?,?,?)";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, leverUpDTO.getUser_id());
            pstmt.setInt(2, leverUpDTO.getOldRole());
            pstmt.setInt(3, leverUpDTO.getNewRole());

            pstmt.executeUpdate();
            pstmt.close();
            return true;
        } catch (SQLException e) {
            System.out.println("등업신청 오류.");

        }
        return false;
    }

    public ArrayList<LeverUpDTO> selectRequestAll() {
        ArrayList<LeverUpDTO> list = new ArrayList<>();
        String query = "SELECT * FROM levelUp";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                LeverUpDTO l = new LeverUpDTO();
                l.setId(resultSet.getInt("id"));
                l.setUser_id(resultSet.getInt("user_id"));
                l.setOldRole(resultSet.getInt("oldRole"));
                l.setNewRole(resultSet.getInt("newRole"));
                l.setEntry_date(resultSet.getTimestamp("entry_date"));
                list.add(l);
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }


    public Boolean levelUpConfirm(int id) {

        int userId = 0;
        int newRole = 0;

        //회원 아이디 및 변경 등급알아내기
        String query = "select user_id,newRole from levelUp where id = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                userId = resultSet.getInt("user_id");
                newRole = resultSet.getInt("newRole");
                resultSet.close();
                pstmt.close();
            }
            System.out.println("1 번 쿼리 ");
            System.out.println("userID : " + userId);
            System.out.println("newRole : " + newRole);

        } catch (SQLException e) {
            e.printStackTrace();
        }

//1. 레벨업테이블의 해당 로우를 삭제한다.
        query = "delete from levelUp where id = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("error");
        }
        System.out.println("2 번 쿼리 ");
        //2. 해당 회원을 찾아서 회원테이블의 role을 요청한 등급으로 봐꾼다.

        String query2 = "update user set role = ? where id = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query2);
            pstmt.setInt(1, newRole);
            pstmt.setInt(2, userId);

            pstmt.executeUpdate();
            pstmt.close();
            System.out.println("3 번 쿼리 ");
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }


    //반려
    public void levelUpRefer(int id) {
//1. 레벨업테이블의 해당 로우를 삭제한다.
        String query = "delete from levelUp where id = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("error");
        }
    }
}
