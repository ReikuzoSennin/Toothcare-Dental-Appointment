<%@page import="bean.User"%>
<%@page import="bean.Dentist"%>
<%@page import="java.util.*"%>
<%
    if(session.getAttribute("dentist")==null) {
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Toothcare</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/4.5.6/css/ionicons.min.css">
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/tiny-slider.css">
    <link rel="stylesheet" href="css/glightbox.min.css">
    <link rel="stylesheet" href="css/aos.css">
    <link rel="stylesheet" href="css/datepicker.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/jquery-latest.min.js"></script>
</head>
<body>
    <jsp:include page="headeradmin.jsp"/>
    <section class="ftco-section ftco-no-pt ftco-no-pb">
        <div class="container-xl" id="appointment">
            <div class="row g-xl-5">
                <div class="col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100" data-aos-duration="1000">
                    <%
                        if(session.getAttribute("dentist")!=null) {
                            Dentist dentist = (Dentist)session.getAttribute("dentist");
                    %>
                    <form action="AppointmentServlet" class="appointment aside-stretch pe-lg-5 d-flex align-items-center" method="post">
                        <input type="hidden" name="operation" value="delete"/>
                            <div class="staff">
                                <div class="img-wrap d-flex align-items-stretch">
                                    <div class="img align-self-stretch" style="background-image: url(<%=dentist.getImage()%>);"></div>
                                </div>
                                <div class="text text-center">
                                    <h3 class="mb-2">Dr. <%=dentist.getName()%></h3>
                                    <span class="position mb-2" id="dentist_role"><%=dentist.getRole()%></span>
                                    <div class="faded">
                                        <ul class="ftco-social text-center">
                                            <li class="ftco-animate"><a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-twitter"></span></a></li>
                                            <li class="ftco-animate"><a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-facebook"></span></a></li>
                                            <li class="ftco-animate"><a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-google"></span></a></li>
                                            <li class="ftco-animate"><a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-instagram"></span></a></li>
                                        </ul>
                                        <p><%=dentist.getDescription()%></p>
                                    </div>
                                </div>
                            </div>
                    </form>
                    <% } %>
                </div>
                <div class="col-md-6 heading-section d-flex align-items-center" data-aos="fade-up" data-aos-delay="200" data-aos-duration="1000">
                    <div class="mt-0 my-lg-5 py-5">
                        <span class="subheading">Your Profile</span>
                        <%
                            List errorMsgs2 = (List) request.getAttribute("errorMsgsUser");
                            if(errorMsgs2!=null) {
                                Iterator items = errorMsgs2.iterator();
                                while(items.hasNext()) {
                                    String message = (String) items.next();
                        %>
                        <font color="red"><li><%=message%></li></font>
                        <%
                                }
                            }
                        %>
                        <div class="row mt-4 g-lg-2">
                            <%
                                if(session.getAttribute("user") != null) {
                                    User user = (User)session.getAttribute("user");
                            %>
                            <div class="col-lg-12 d-flex align-items-stretch services-wrap">
                                <div class="services d-flex">
                                    <div class="text">
                                        <h2>Name</h2>
                                        <p class="mb-0"><%=user.getName()%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 d-flex align-items-stretch services-wrap">
                                <div class="services d-flex">
                                    <div class="text">
                                        <h2>Email</h2>
                                        <p class="mb-0"><%=user.getEmail()%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 d-flex align-items-stretch services-wrap">
                                <div class="services d-flex">
                                    <div class="text">
                                        <h2>Phone Number</h2>
                                        <p class="mb-0"><%=user.getPhone()%></p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 d-flex align-items-stretch services-wrap">
                                <div class="services d-flex">
                                    <div class="text">
                                        <h2>Area</h2>
                                        <p class="mb-0">
                                        <%
                                                String area = user.getArea();
                                                String postcode = user.getPostcode();
                                                String postoffice = user.getPostoffice();
                                                String state = user.getState();
                                                String address = area+", "+postcode+" "+postoffice+", "+state;
                                        %>
                                        <%=address%>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12 d-flex align-items-center">
                                <div class="form-group">
                                    <a href="changePassword.jsp" class="btn btn-primary p-4 py-3">Change Password <span class="ion-ios-arrow-round-forward"></span></a>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <jsp:include page="footer.jsp"/>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/tiny-slider.js"></script>
    <script src="js/glightbox.min.js"></script>
    <script src="js/aos.js"></script>
    <script src="js/datepicker.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
