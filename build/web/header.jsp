<%@page import="bean.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <div class="top-wrap">
            <div class="container">
                <div class="row">
                    <div class="col-md col-xl-4 d-flex align-items-center mb-4 mb-md-0">
                        <a class="navbar-brand align-items-center" href="index.jsp">
                            Toothcare
                            <span>Dental Clinic Services</span>
                        </a>
                    </div>
                    <div class="col-md d-flex align-items-center mb-2 mb-md-0">
                        <div class="con d-flex">
                            <div class="icon"><span class="flaticon-clock"></span></div>
                            <div class="text">
                                <span>Monday - Friday</span>
                                <strong>8:00AM - 8:00PM</strong>
                            </div>
                        </div>
                    </div>
                    <div class="col-md d-flex align-items-center mb-2 mb-md-0">
                        <div class="con d-flex">
                            <div class="icon"><span class="flaticon-telephone"></span></div>
                            <div class="text">
                                <span>Call Us</span>
                                <strong>+60 178065501</strong>
                            </div>
                        </div>
                    </div>
                    <div class="col-md d-flex align-items-center mb-2 mb-md-0">
                        <div class="con d-flex">
                            <div class="icon"><span class="flaticon-pin"></span></div>
                            <div class="text">
                                <span>Location</span>
                                <strong>UiTM Shah Alam, Selangor, Malaysia</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <nav class="navbar navbar-expand-lg  ftco-navbar-light">
            <div class="container-xl">
                <%
                    if(session.getAttribute("user")!=null) {
                %>
                <a href="LogoutServlet" class="btn-custom order-lg-last" style="background-color:red !important; border: 1px solid red !important; color: #fff !important;">Logout</a>
                <% } else { %>
                <a href="login.jsp" class="btn-custom order-lg-last">Connect With Us</a>
                <% } %>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="fa fa-bars"></span> Menu
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item"><a class="nav-link ps-lg-0" href="index.jsp">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="dentist.jsp">Dentist</a></li>
                        <li class="nav-item"><a class="nav-link" href="about.jsp">About</a></li>
                        <li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
                        <li class="nav-item"><a class="nav-link" href="pricing.jsp">Pricing</a></li>
                        <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact</a></li>
                        <%
                            if(session.getAttribute("user")!=null) {
                                User user = (User)session.getAttribute("user");
                                String name = user.getName();
                                name = name.trim();
                                int i = name.indexOf(' ');
                                if(i>0)
                                    name = name.substring(0, i); 
                        %>
                        <li class="nav-item"><a class="nav-link" href="profile.jsp">Welcome, <%=name%></a></li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </nav>
    </body>
</html>
