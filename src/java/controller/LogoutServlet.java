package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.LinkedList;
import javax.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List errorMsgs = new LinkedList();
        HttpSession session = request.getSession(false);

        if(session != null) {
            session.invalidate();
            errorMsgs.add("You have logged out successfully");
            request.setAttribute("errorMsgs", errorMsgs);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            System.out.println("Logged out");
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
