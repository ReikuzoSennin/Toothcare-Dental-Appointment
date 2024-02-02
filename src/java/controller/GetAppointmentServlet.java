package controller;

import com.google.gson.Gson;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.AppointmentDao;
import bean.Appointment;
import java.util.List;

public class GetAppointmentServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AppointmentDao dao = new AppointmentDao();
        try  {
            int id = Integer.parseInt(request.getParameter("id"));
            List<Appointment> list = dao.getAppointmentList(id);
            Gson json = new Gson();
            String appointmentList = json.toJson(list);
            response.setContentType("text/html");
            response.getWriter().write(appointmentList);
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
