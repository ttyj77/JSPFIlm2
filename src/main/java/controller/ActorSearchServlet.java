package controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import model.ActorDTO;
import model.CinemaDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "ActorSearchServlet", value = "/ActorSearchServlet")
public class ActorSearchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String actorName = request.getParameter("actorName");

        response.getWriter().write(getJSON(actorName));
    }

    public String getJSON(String actorName) {
//        if (cityId == 0) { //잘못선택
//
//        }

        ConnectionMaker connectionMaker = new MysqlConnectionMaker();

        ActorController actorController = new ActorController(connectionMaker);
        ArrayList<ActorDTO> list = actorController.selectActorList(actorName);
        JsonArray array = new JsonArray();

        for (int i = 0; i < list.size(); i++) {
            JsonObject object = new JsonObject();
            object.addProperty("id", list.get(i).getActor_id());
            object.addProperty("name", list.get(i).getName());
            array.add(object);
        }

        JsonObject result = new JsonObject();

        result.addProperty("status", "200");
        result.addProperty("message", "success");
        result.addProperty("responseText", array.toString());
        return result.toString();
    }

}
