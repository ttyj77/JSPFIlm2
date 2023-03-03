package servlet;

import com.google.gson.JsonObject;
import controller.FilmController;
import controller.LevelUpController;
import controller.UserController;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import model.LeverUpDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "levelUpCheckServlet", value = "/reply/checkRole")
public class levelUpCheckServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("checkRole");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();


        PrintWriter writer = response.getWriter();
        JsonObject object = new JsonObject();

        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        LevelUpController levelUpController = new LevelUpController(connectionMaker);

        String message = "";
        String nextPath = "";
        int requestRole = 0;
        try {
            UserDTO logIn = (UserDTO) session.getAttribute("logIn");
            int result = levelUpController.checkRequest(logIn.getId());
            System.out.println(result);
            if (result == 0) {
                message = "해당 등급으로 등업이 가능합니다.";
                object.addProperty("status", "success");
                object.addProperty("message", message);
                object.addProperty("result", result);
            } else if (result > 0) {
                requestRole = result;
                throw new NullPointerException();
            }

        } catch (Exception e) {
            object.addProperty("status", "fail");
            object.addProperty("message", message);
            object.addProperty("result", requestRole);
        }
        writer.println(object);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {

    }

}
