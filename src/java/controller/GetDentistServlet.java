package controller;

import com.google.gson.Gson;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.DentistDao;
import bean.Dentist;
import java.util.List;

public class GetDentistServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DentistDao dao = new DentistDao();
        String clause = request.getParameter("clause");
        try {
            List<Dentist> list = dao.getDentistList(clause);
            Gson json = new Gson();
            String dentistList = json.toJson(list);
            response.setContentType("text/html");
            response.getWriter().write(dentistList);
        } catch (RuntimeException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
