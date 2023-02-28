package controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import model.CinemaDTO;
import model.TheaterDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "TheaterServlet", value = "/TheaterServlet")
public class TheaterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String cinemaNum = request.getParameter("id");

        System.out.println("cinemaNum : " + cinemaNum);
        response.getWriter().write(getJSON(cinemaNum));
    }

    public String getJSON(String cinemaNum) {
//        if (cityId == 0) { //잘못선택
//
//        }

        ConnectionMaker connectionMaker = new MysqlConnectionMaker();

        CinemaController cinemaController = new CinemaController(connectionMaker);
        ArrayList<TheaterDTO> list = cinemaController.selectCinema(Integer.parseInt(cinemaNum));
        System.out.println("list : " +list);
        JsonArray array = new JsonArray();

        for (int i = 0; i < list.size(); i++) {
            JsonObject object = new JsonObject();
            object.addProperty("id", list.get(i).getId());
            object.addProperty("cinemaId", list.get(i).getCinema_id());
            object.addProperty("scale", list.get(i).getScale());
            object.addProperty("number", list.get(i).getNumber());
            array.add(object);
        }

        JsonObject result = new JsonObject();

        result.addProperty("status", "200");
        result.addProperty("message", "success");
        result.addProperty("responseText", array.toString());
        System.out.println("==========result.toString : "+result.toString());
        return result.toString();
    }

}
