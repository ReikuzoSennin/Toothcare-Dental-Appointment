package controller;

import com.google.gson.Gson;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.StatePostcodeDao;
import bean.State;
import bean.Postcode;
import bean.Area;
import java.util.List;

public class GetStatePostcodeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StatePostcodeDao dao = new StatePostcodeDao();
        try {
            String op = request.getParameter("operation");
            
            if (op.equals("state")) {
                List<State> slist = dao.getAllState();
                Gson json = new Gson();
                String stateList = json.toJson(slist);
                response.setContentType("text/html");
                response.getWriter().write(stateList);
            }

            if (op.equals("postcode")) {
                String state = request.getParameter("state");
                List<Postcode> plist = dao.getPostcodeByStateCode(state);
                Gson json = new Gson();
                String postcodeList = json.toJson(plist);
                response.setContentType("text/html");
                response.getWriter().write(postcodeList);
            }

            if (op.equals("area")) {
                String postcode = request.getParameter("postcode");
                List<Area> alist = dao.getAreaByPostcode(postcode);
                Gson json = new Gson();
                String areaList = json.toJson(alist);
                response.setContentType("text/html");
                response.getWriter().write(areaList);
            }
        } catch (RuntimeException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}