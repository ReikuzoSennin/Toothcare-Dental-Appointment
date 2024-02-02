package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.LinkedList;
import bean.Appointment;
import dao.AppointmentDao;
import java.time.*;
import javax.servlet.http.HttpSession;

public class AppointmentServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List errorMsgs = new LinkedList();
        
        try {
            String op = request.getParameter("operation");
            
            if(op.equals("insert")) {
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String phone = request.getParameter("tel");
                int doctor = Integer.parseInt(request.getParameter("doctor"));
                String message = request.getParameter("message");
                String date = request.getParameter("date");
                String time = request.getParameter("time");

                int id = Integer.parseInt(request.getParameter("id"));
                
                if(name==null || name.trim().length()==0) {
                    errorMsgs.add("Please enter name");
                }
                if(email==null || email.trim().length()==0) {
                    errorMsgs.add("Please enter email");
                }
                if(phone==null || phone.trim().length()==0) {
                    errorMsgs.add("Please enter phone");
                }
                if(time==null) {
                    errorMsgs.add("Please enter time");
                }
                if(date==null) {
                    errorMsgs.add("Please enter date");
                }
                if(!errorMsgs.isEmpty()) {
                    request.setAttribute("errorMsgsApp", errorMsgs);
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
                    return;
                }

                Appointment app = new Appointment(name, email, phone, doctor, message, date, time);
                AppointmentDao dao = new AppointmentDao();
                String insertAppointment = dao.insertAppointment(app,id);
                
                if(insertAppointment.equals("SUCCESS")) {
                    errorMsgs.add("Appointment Added");
                    HttpSession session = request.getSession();
                    session.setAttribute("userAppointment", app);
                    request.setAttribute("errorMsgsApp", errorMsgs);
                    request.getRequestDispatcher("/profile.jsp").forward(request, response);
                } else {
                    errorMsgs.add(insertAppointment);
                    request.setAttribute("errorMsgsApp", errorMsgs);
                    request.getRequestDispatcher("/profile.jsp").forward(request, response);
                }
            } else if (op.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                
                AppointmentDao dao = new AppointmentDao();
                String deleteAppointment = dao.deleteAppointment(id);
                if(deleteAppointment.equals("SUCCESS")) {
                    errorMsgs.add("Appointment Removed");
                    HttpSession session = request.getSession();
                    session.removeAttribute("userAppointment");
                    request.setAttribute("errorMsgsApp", errorMsgs);
                    request.getRequestDispatcher("/profile.jsp").forward(request, response);
                } else {
                    errorMsgs.add(deleteAppointment);
                    request.setAttribute("errorMsgsApp", errorMsgs);
                    request.getRequestDispatcher("/profile.jsp").forward(request, response);
                }
            }
        } catch (RuntimeException e) {
            errorMsgs.add("An unexpected error: "+e.getMessage());
            request.setAttribute("errorMsgsApp",errorMsgs);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
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
