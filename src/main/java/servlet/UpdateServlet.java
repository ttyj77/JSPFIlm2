package servlet;

import com.google.gson.JsonObject;
import controller.UserController;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "UpdateServlet", value = "/user/update")
public class UpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String status = "";
        String nextpath = "";
        String message = "";
        JsonObject object = new JsonObject();
        PrintWriter printWriter = response.getWriter();
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        System.out.println("update");
        try {

            HttpSession session = request.getSession();
            UserDTO logIn = (UserDTO) session.getAttribute("logIn");

            int id = Integer.parseInt(request.getParameter("id"));

            ConnectionMaker connectionMaker = new MysqlConnectionMaker();
            UserController userController = new UserController(connectionMaker);
            UserDTO u = userController.selectOne(id);
            if (u == null || u.getId() != logIn.getId()) {
                throw new NullPointerException();

            }
            u.setUsername(request.getParameter("username"));
            u.setNickname(request.getParameter("nickname"));
            System.out.println("username : " + request.getParameter("username"));
            System.out.println("nickname : " + request.getParameter("nickname"));


            userController.update(u);

            status = "success";
            nextpath = "/user/mypage.jsp";
            message = "update success";

        } catch (Exception e) {
            status = "error";
            nextpath = "/user/mypage.jsp";
            message = "오류가 발생했습니다.";
        }

        object.addProperty("status", status);
        object.addProperty("nextPath", nextpath);
        object.addProperty("message", message);

        printWriter.println(object);
    }
}

