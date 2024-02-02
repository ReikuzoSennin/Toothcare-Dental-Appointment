package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.LinkedList;
import bean.Login;
import bean.User;
import bean.Appointment;
import bean.Dentist;
import dao.LoginDao;
import dao.AppointmentDao;
import dao.DentistDao;

public class LoginServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> errorMsgs = new LinkedList<>();
        try {
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            if(email==null || email.trim().length()==0)
                errorMsgs.add("Please enter email");
            if(password==null || password.trim().length()==0)
                errorMsgs.add("Please enter password");
            if(!errorMsgs.isEmpty()) {
                request.setAttribute("errorMsgsLogin", errorMsgs);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            
            Login bean = new Login(email, password);
            LoginDao dao = new LoginDao();
            String userValidate = dao.authenticateUser(bean);
            
            if(userValidate.equals("SUCCESS")) {
                User user = dao.getUser(bean);
                int id = user.getId();
                if(user.getUserType().equals("User")) {
                    AppointmentDao appdao = new AppointmentDao();
                    Appointment app = appdao.hasAppointment(user);

                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    if(!app.getName().equals(""))
                        session.setAttribute("userAppointment", app);
                    request.getRequestDispatcher("/index.jsp").forward(request, response);
                } else if(user.getUserType().equals("Dentist")) {
                    DentistDao dentistdao = new DentistDao();
                    Dentist dentist = dentistdao.getDentist(user);
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user);
                    session.setAttribute("dentist", dentist);
                    request.getRequestDispatcher("/admin.jsp").forward(request, response);
                }
            } else {
                errorMsgs.add(userValidate);
                request.setAttribute("errorMsgsLogin", errorMsgs);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (RuntimeException e) {
            errorMsgs.add("An unexpected error: "+e.getMessage());
            request.setAttribute("errorMsgsLogin", errorMsgs);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
