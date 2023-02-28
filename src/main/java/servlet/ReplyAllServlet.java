package servlet;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import controller.ReviewController;
import dbConn.ConnectionMaker;
import dbConn.MysqlConnectionMaker;
import model.ReviewDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

@WebServlet(name = "ReplyAllServlet", value = "/reply/selectAll")
public class ReplyAllServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        JsonObject object = new JsonObject();

        try {
            int filmId = Integer.parseInt(request.getParameter("filmId"));
            ConnectionMaker connectionMaker = new MysqlConnectionMaker();
            ReviewController reviewController = new ReviewController(connectionMaker);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH:mm:ss");

            HttpSession session = request.getSession();
            UserDTO logIn = (UserDTO) session.getAttribute("logIn");


            ArrayList<ReviewDTO> list = reviewController.selectOneReviewList(filmId);
            JsonArray array = new JsonArray();
            for (ReviewDTO r : list) {
                JsonObject temp = new JsonObject();

                temp.addProperty("id", r.getId());
                temp.addProperty("review", r.getReview());
                temp.addProperty("nickname", r.getNickname());
                temp.addProperty("score", r.getScore());
                try {
                    temp.addProperty("isOwned", logIn.getId() == r.getWriter_id());
                } catch (NullPointerException e) {
                    temp.addProperty("isOwned", "false");
                }
                try {
                    if (!r.getReview().isEmpty()) {
                        temp.addProperty("exist", "true");
                    } else {
                        temp.addProperty("exist", "false");
                    }
                } catch (Exception e) {
                    temp.addProperty("exist", "false");
                }

                array.add(temp);
            }
            object.addProperty("status", "success");
            object.addProperty("list", array.toString());
        } catch (Exception e) {
            object.addProperty("status", "fail");
        }

        PrintWriter writer = response.getWriter();
        writer.println(object);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
