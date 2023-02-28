package controller;

import dbConn.ConnectionMaker;
import model.ActorDTO;
import model.Film_actorDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ActorController {
    private Connection connection;

    public ActorController(ConnectionMaker connectionMaker) {
        this.connection = connectionMaker.makeConnection();
    }


    public ArrayList<ActorDTO> actorList(int film_id) {
        ArrayList<ActorDTO> list = new ArrayList<>();
        String query = "SELECT * FROM actor ac join film_actor fa on fa.actor_id = ac.actor_id where fa.film_id = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, film_id);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                ActorDTO a = new ActorDTO();
                a.setActor_id(resultSet.getInt("actor_id"));
                a.setName(resultSet.getString("name"));
                a.setImage(resultSet.getString("image"));
                a.setCasting(resultSet.getString("casting"));
                list.add(a);

            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(list);
        return list;
    }


    public ArrayList<ActorDTO> selectActorList(String actor_name) {
        ArrayList<ActorDTO> list = new ArrayList<>();
        String query = "select * from actor where name like ?";
        try {

            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, actor_name + "%");
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                ActorDTO a = new ActorDTO();
                a.setActor_id(resultSet.getInt("actor_id"));
                a.setName(resultSet.getString("name"));
                list.add(a);
            }

            pstmt.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;

    }

    public void insert(ArrayList<Film_actorDTO> list) {
        String query = "insert into film_actor (actor_id, casting,film_id) values (?,?,?)";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            for (int i = 0; i < list.size(); i++) {


                pstmt.setInt(1, list.get(i).getActor_id());
                pstmt.setInt(2, list.get(i).getCasting());
                pstmt.setInt(3, list.get(i).getFilm_id());
                System.out.println(i + "번 insert 완료");

            }
            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
