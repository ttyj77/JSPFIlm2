package servlet;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import controller.FilmController;
import controller.RunningTimeController;
import controller.UserController;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import model.FilmDTO;
import model.TimeTableDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@WebServlet(name = "RunningTimeServlet", value = "/cinema/runningTime")
public class RunningTimeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();


        PrintWriter writer = response.getWriter();
        JsonObject object = new JsonObject();
        JsonObject RTObject = new JsonObject();

        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        RunningTimeController runningTimeController = new RunningTimeController(connectionMaker);

        String message = "";
        String nextPath = "";


        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String date = request.getParameter("date");

            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

            ArrayList<TimeTableDTO> timeTable = runningTimeController.selectDate(id, date);
            if (timeTable == null) {
                throw new NullPointerException();
            }

            JsonArray array = new JsonArray();
            for (TimeTableDTO t : timeTable) {
                JsonObject temp = new JsonObject();
                temp.addProperty("id", t.getFilm_id());
                temp.addProperty("title", t.getTitle());
                temp.addProperty("rating", t.getRating());
                temp.addProperty("scale", t.getScale());
                temp.addProperty("length", t.getLength());
                temp.addProperty("startTime", sdf.format(t.getStartTime()));
                temp.addProperty("endTime", sdf.format(t.getStartTime()));
                array.add(temp);
            }

            object.addProperty("status", "success");
            object.addProperty("list", array.toString());
        } catch (NullPointerException e) {
            System.out.println("error page");
            object.addProperty("status", "fail");
            object.addProperty("message", "1error");
            object.addProperty("nextPath", nextPath);

        } catch (Exception e) {
            //integet Parse int 못하거나 완전 다른 오류가 발생했을 때 빠질 수 있게
            message = "오류가 발생했습니다.";
            nextPath = "/index.jsp";
            object.addProperty("status", "fail");
            object.addProperty("message", "2error");
            object.addProperty("nextPath", nextPath);
        }
        writer.println(object);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
