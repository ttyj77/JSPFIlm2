package servlet;

import com.google.gson.JsonObject;
import controller.ReviewController;
import controller.UserController;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import model.ReviewDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ReplyServlet", value = "/reply/insert")
public class ReplyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("replyServlet !!!");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO logIn = (UserDTO) session.getAttribute("logIn");
        ConnectionMaker connectionMaker = new MysqlConnectionMaker();
        ReviewController reviewController = new ReviewController(connectionMaker);
        UserController userController = new UserController(connectionMaker);
        JsonObject object = new JsonObject();

        String message = "";
        String nextPath = "";

        try {
            int filmId = Integer.parseInt(request.getParameter("filmId"));
            if (logIn == null) { //f로그인을 안했거나 유효하지 않은 번호로 들어오거나 관리자가 아닌경우
                System.out.println("login error");
                message = "로그인을 해주세요.";
                nextPath = "/user/login.jsp";

            }
            int writerId = logIn.getId();
            String review = request.getParameter("review");
            int score = Integer.parseInt(request.getParameter("score"));
            String nickname = userController.selectOne(writerId).getNickname();

            ReviewDTO r = new ReviewDTO();
            r.setWriter_id(writerId);
            r.setFilm_id(filmId);
            r.setReview(review);
            r.setNickname(nickname);
            r.setScore(score);

            reviewController.insert(r);
            System.out.println("insert End");
            object.addProperty("status", "success");
        } catch (NullPointerException e) {
            System.out.println("error page");
            object.addProperty("status", "fail");
            object.addProperty("message", message);
            object.addProperty("nextPath", nextPath);
        }
        PrintWriter writer = response.getWriter();
        writer.println(object);
    }
}
