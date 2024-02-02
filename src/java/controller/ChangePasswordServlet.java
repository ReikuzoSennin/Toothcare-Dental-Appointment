package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.LinkedList;
import bean.Password;
import dao.PasswordDao;

public class ChangePasswordServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        List<String> errorMsgs = new LinkedList();
        try {
            String oldpass = request.getParameter("oldpass");
            String newpass = request.getParameter("newpass");
            String newpass2 = request.getParameter("newpass2");
            int id = Integer.parseInt(request.getParameter("id"));
            
            if(oldpass==null || oldpass.trim().length()==0)
                errorMsgs.add("Please enter old password");
            if(newpass==null || newpass.trim().length()==0)
                errorMsgs.add("New password cannot be empty");
            else if(newpass2==null || newpass2.trim().length()==0)
                errorMsgs.add("Please confirm password");
            else if(!newpass2.equals(newpass))
                errorMsgs.add("Passwords does not match");
            
            Password pass = new Password(oldpass, newpass);
            PasswordDao dao = new PasswordDao();
            String authenticatePassword = dao.authenticatePassword(pass, id);
            if(authenticatePassword.equals("Incorrect Password"))
                errorMsgs.add(authenticatePassword);
            if(!errorMsgs.isEmpty()) {
                request.setAttribute("errorMsgs", errorMsgs);
                request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
                return;
            }
            
            String changePassword = dao.changePassword(pass, id);
            if(changePassword.equals("SUCCESS")) {
                errorMsgs.add("Password Changed");
                request.setAttribute("errorMsgsUser", errorMsgs);
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
            } else {
                errorMsgs.add("changePassword");
                request.setAttribute("errorMsgs", errorMsgs);
                request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
            }
        } catch (RuntimeException e) {
            errorMsgs.add("An unexpected error: "+e.getMessage());
            request.setAttribute("errorMsgs", errorMsgs);
            request.getRequestDispatcher("/changePassword.jsp").forward(request, response);
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
