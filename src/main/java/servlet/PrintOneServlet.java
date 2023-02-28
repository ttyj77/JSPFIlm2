package servlet;

import com.google.gson.JsonObject;
import controller.FilmController;
import controller.UserController;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import model.FilmDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

@WebServlet(name = "PrintOneServlet", value = "/film/printOne")
public class PrintOneServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();


        PrintWriter writer = response.getWriter();
        JsonObject object = new JsonObject();
        JsonObject filmJson = new JsonObject();

        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        FilmController filmController = new FilmController(connectionMaker);
        UserController userController = new UserController(connectionMaker);

        String message = "";
        String nextPath = "";


        try {

            UserDTO logIn = (UserDTO) session.getAttribute("logIn");


            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println(id);

            FilmDTO filmDTO = filmController.selectOne(id);
            System.out.println(filmDTO);
            System.out.println(filmDTO.getLength());
            if (filmDTO == null) {
                message = "유효하지 않는 영화 입니다.";
                nextPath = "/index.jsp";
                throw new NullPointerException();
            }
//            if (logIn != null) {
//                filmJson.addProperty("role", userController.selectOne(logIn.getId()).getRole());
//            } else if (logIn == null) {
//                filmJson.addProperty("role", 0); // 1: 일반 2:관리자 3; 평론가 0: error
//            }
            try {

                if (logIn == null) {
                    filmJson.addProperty("role", 0); // 1: 일반 2:관리자 3; 평론가 0: error
                } else {
                    filmJson.addProperty("role", userController.selectOne(logIn.getId()).getRole());
                }
                System.out.println("role : " + userController.selectOne(logIn.getId()).getRole());
            } catch (Exception e) {
                message = "유효하지 않는 영화 입니다.";
                nextPath = "/index.jsp";
                object.addProperty("status", "fail");
                object.addProperty("message", message);
                object.addProperty("nextPath", nextPath);
            }


            filmJson.addProperty("id", filmDTO.getId());
            filmJson.addProperty("title", filmDTO.getTitle());
            filmJson.addProperty("english_title", filmDTO.getEnglish_title());
            filmJson.addProperty("summary", filmDTO.getSummary());
            filmJson.addProperty("poster", filmDTO.getPoster_image());

            object.addProperty("status", "success");
            object.addProperty("data", filmJson.toString());
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
