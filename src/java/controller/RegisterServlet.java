package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.LinkedList;
import bean.Register;
import dao.RegisterDao;

public class RegisterServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> errorMsgs = new LinkedList<>();
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String phone = request.getParameter("phone");
            int areaid = Integer.parseInt(request.getParameter("area"));
            
            if(name==null || name.trim().length()==0) {
                errorMsgs.add("Name cannot be empty");
            }
            if(email==null || email.trim().length()==0) {
                errorMsgs.add("Email cannot be empty");
            }
            if(password==null || password.trim().length()==0) {
                errorMsgs.add("Password cannot be empty");
            }
            if(phone==null || phone.trim().length()==0) {
                errorMsgs.add("Phone Number cannot be empty");
            }     
            if(!errorMsgs.isEmpty()) {
                request.setAttribute("errorMsgsRegister", errorMsgs);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            
            RegisterDao dao = new RegisterDao();
            String existUser = dao.existUser(email);
            if(existUser.equals("SUCCESS")) {
                errorMsgs.add("Email Already Exist!");
                request.setAttribute("errorMsgsRegister", errorMsgs);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else {
                Register bean = new Register(name, email, password, phone, areaid);
                String registerUser = dao.registerUser(bean);

                if(registerUser.equals("SUCCESS")) {
                    errorMsgs.add("Registration Successful!");
                    request.setAttribute("errorMsgsRegister", errorMsgs);
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                } else {
                    errorMsgs.add(registerUser);
                    request.setAttribute("errorMsgsRegister", errorMsgs);
                    request.getRequestDispatcher("/login.jsp").forward(request, response);
                }
            }
        } catch (RuntimeException e) {
            errorMsgs.add("An unexpected error: "+e.getMessage());
            request.setAttribute("errorMsgsRegister", errorMsgs);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
