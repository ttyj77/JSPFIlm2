package controller;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import model.CinemaDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "hCinemaSearchServlet", value = "/CinemaSearchServlet")
public class CinemaSearchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String cityId = request.getParameter("cityId");

        System.out.println("cityId : " + cityId);
        response.getWriter().write(getJSON(cityId));
    }

    public String getJSON(String cityId) {
//        if (cityId == 0) { //잘못선택
//
//        }

        ConnectionMaker connectionMaker = new MysqlConnectionMaker();

        CinemaController cinemaController = new CinemaController(connectionMaker);
        ArrayList<CinemaDTO> list = cinemaController.selectCity(Integer.parseInt(cityId));
        JsonArray array = new JsonArray();

        for (int i = 0; i < list.size(); i++) {
            JsonObject object = new JsonObject();
            object.addProperty("id", list.get(i).getId());
            object.addProperty("name", list.get(i).getName());
            object.addProperty("number", list.get(i).getNumber());
            object.addProperty("location", list.get(i).getLocation());


            array.add(object);
        }

        JsonObject result = new JsonObject();

        result.addProperty("status", "200");
        result.addProperty("message", "success");
        result.addProperty("responseText", array.toString());

        return result.toString();
    }

}
