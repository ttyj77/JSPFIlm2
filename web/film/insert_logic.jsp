<%@ page import="model.FilmDTO" %>
<%@ page import="model.UserDTO" %>
<%@ page import="dbConn.ConnectionMaker" %>
<%@ page import="dbConn.MysqlConnectionMaker" %>
<%@ page import="controller.FilmController" %>

<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="model.ActorDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.ActorController" %>
<%@ page import="model.Film_actorDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>film_insert</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    UserDTO logIn = (UserDTO) session.getAttribute("logIn");
    if (logIn == null) {
        response.sendRedirect("/index.jsp");
    }

    ConnectionMaker connectionMaker = new MysqlConnectionMaker();
    FilmController filmController = new FilmController(connectionMaker);
    ActorController actorController = new ActorController(connectionMaker);
    FilmDTO f = new FilmDTO();

    //배우와 감독을 넣기 위해서는 영화아이디가 필요한데 그러기 위해서는 현재 디비의 가장 마지막 film_id가 필요하다
    int index = filmController.findLastIndex();

    String imgUrl = request.getParameter("poster_image");
    String filename = "";

    int sizeLimit = 15 * 1024 * 1024; // 한번에 올릴 수 있는 파일 용량 : 15M로 제한


    //	상대경로를 절대경로로 가져와야
    String realPath = "C:/Users/ttyj7/IdeaProjects/JSPFIlm2/web/assets/images/poster";
    System.out.println(realPath);

    //upload 폴더가 없는 경우 폴더를 만들어라
    File dir = new File(realPath);
    if (!dir.exists()) dir.mkdirs();

    MultipartRequest multpartRequest = new MultipartRequest(request, realPath,
            sizeLimit, "utf-8", new DefaultFileRenamePolicy());
    // request,파일저장경로,용량,인코딩타입,중복파일명에 대한 기본 정책
    filename = multpartRequest.getFilesystemName("poster_image");

    f.setPoster_image("/assets/images/poster/" + filename);
    // form내의 input name="photo" 인 요소의 값을 가져옴
    f.setTitle(multpartRequest.getParameter("title"));
    f.setSummary(multpartRequest.getParameter("summary"));
    f.setRating(multpartRequest.getParameter("rating"));
    f.setEnglish_title(multpartRequest.getParameter("english_title"));

    f.setShowing(0); //등록하면 일단 상영중으로 처리
    f.setCountry(multpartRequest.getParameter("country"));

    String[] actorId = multpartRequest.getParameterValues("actor_id");
    String[] directorId = multpartRequest.getParameterValues("director_id");

    String[] casting = multpartRequest.getParameterValues("casting");

    int film_id = index + 1;

    ArrayList<Film_actorDTO> directorList = new ArrayList<>();
    ArrayList<Film_actorDTO> actorList = new ArrayList<>();
    //넘겨야 되는게 배우이름 리스트 감독이름리스트 영화번호 casting

    for (int i = 0; i < directorId.length; i++) {
        Film_actorDTO film_actorDTO = new Film_actorDTO();
        film_actorDTO.setActor_id(Integer.parseInt(actorId[i]));
        film_actorDTO.setCasting(Integer.parseInt(casting[i]));
        film_actorDTO.setFilm_id(film_id);
        directorList.add(film_actorDTO);
    }

    for (int i = 0; i < actorId.length; i++) {
        Film_actorDTO film_actorDTO = new Film_actorDTO();
        film_actorDTO.setActor_id(Integer.parseInt(actorId[i]));
        film_actorDTO.setCasting(1); //배우
        film_actorDTO.setFilm_id(film_id);
        actorList.add(film_actorDTO);
    }

    directorList.addAll(actorList);

    //감독도 똑같이 넣는데 감독은 casting = "감독" 넣기
    filmController.insert(f);
    actorController.insert(directorList);


%>
</body>
</html>
