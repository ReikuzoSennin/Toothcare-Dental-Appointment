<%@page import="bean.User"%>
<%@page import="bean.Appointment"%>
<%@page import="java.util.*"%>
<%
    if(session.getAttribute("user")==null) {
        response.sendRedirect("login.jsp");
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
<script type="text/javascript">
    $(document).ready(function() {
        var appointed = '${userAppointment}';
        $.ajax({
            url: "GetDentistServlet",
            method: "GET",
            data: {
                operation: "list",
                clause: ""
            },
            success: function (data, textStatus, jqXHR) {
                let obj = $.parseJSON(data);
                $.each(obj, function (key, value) {
                    var dr = "Dr. "+value.name;
                    if(appointed==="")
                        $('#doctor').append('<option value="'+value.id+'">'+dr+'</option>');
                    else {
                        var selected = parseInt('${userAppointment.getDoctor()}');
                        if(value.id===selected)
                            $('#doctor').val(dr);
                    }
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                if(appointed!==null)
                    $('#doctor').append('<option>No Doctors Available</option>');
            },
            cache: false
        });
    });
</script>
<body>
    <jsp:include page="header.jsp"/>
    <section class="ftco-section ftco-no-pt ftco-no-pb">
        <div class="container-xl" id="appointment">
            <div class="row g-xl-5">
                <div class="col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100" data-aos-duration="1000">
                    <%
                        if(session.getAttribute("userAppointment")!=null) {
                            User user = (User)session.getAttribute("user");
                            Appointment app = (Appointment)session.getAttribute("userAppointment");
                    %>
                    <form action="AppointmentServlet" class="appointment aside-stretch pe-lg-5 d-flex align-items-center" method="post">
                        <input type="hidden" name="operation" value="delete"/>
                        <div>
                            <span class="subheading">We Are Here For You</span>
                            <h2 class="mb-5 appointment-head">You Have A Scheduled Appointment</h2>
                            <%
                                List errorMsgs = (List) request.getAttribute("errorMsgsApp");
                                if(errorMsgs!=null) {
                                    Iterator items = errorMsgs.iterator();
                                    while(items.hasNext()) {
                                        String message = (String) items.next();
                            %>
                            <font color="red"><li><%=message%></li></font>
                            <%
                                    }
                                }
                            %>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="name">Your Full Name</label>
                                        <input type="text" id="name" name="name" class="form-control" value="<%=user.getName()%>" placeholder="Your Full Name" disabled/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email">Email Address</label>
                                        <input id="email" name="email" type="email" class="form-control" value="<%=user.getEmail()%>" placeholder="Email" disabled>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tel">Phone Number</label>
                                        <input type="text" id="tel" name="tel" class="form-control" value="<%=user.getPhone()%>" placeholder="Your Phone Number" disabled>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="date">Appointment Date</label>
                                        <input id="date" name="date" type="date" class="form-control arrival_date" placeholder="Appointment Date" value="<%=app.getDate()%>" disabled/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="time">Appointment Time</label>
                                        <input type="time" id="time" name="time" class="form-control" placeholder="Appointment Time" value="<%=app.getTime()%>" disabled/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="doctor">Select A Doctor</label>
                                        <input type="text" id="doctor" name="doctor" class="form-control" disabled/>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="message">Message</label>
                                        <textarea name="message" id="message" cols="0" rows="5" class="form-control" placeholder="Message" disabled><%=app.getMessage()%></textarea>
                                    </div>
                                </div>
                                <input type="hidden" name="id" value="<%=user.getId()%>" />
                                <div class="col-md-12 d-flex align-items-center">
                                    <div class="form-group">
                                        <input type="submit" value="Cancel Appointment" class="btn btn-white py-3 d-block rounded" style="background-color:red !important; border: 1px solid red !important; color: #fff !important;">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <% } else if(session.getAttribute("user") != null) { 
                        User user = (User)session.getAttribute("user");
                    %>
                    <form action="AppointmentServlet" class="appointment aside-stretch pe-lg-5 d-flex align-items-center" method="post">
                        <input type="hidden" name="operation" value="insert"/>
                        <div>
                            <span class="subheading">We Are Here For You</span>
                            <h2 class="mb-5 appointment-head">Make An Appointment</h2>
                            <%
                                List errorMsgs = (List) request.getAttribute("errorMsgsApp");
                                if(errorMsgs!=null) {
                                    Iterator items = errorMsgs.iterator();
                                    while(items.hasNext()) {
                                        String message = (String) items.next();
                            %>
                            <font color="red"><li><%=message%></li></font>
                            <%
                                    }
                                }
                            %>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="name">Your Full Name</label>
                                        <input type="text" id="name" name="name" class="form-control" value="<%=user.getName()%>" readonly placeholder="Your Full Name" required/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email">Email Address</label>
                                        <input id="email" name="email" type="email" class="form-control" value="<%=user.getEmail()%>" readonly placeholder="Email" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tel">Phone Number</label>
                                        <input type="text" id="tel" name="tel" class="form-control" value="<%=user.getPhone()%>" readonly placeholder="Your Phone Number" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="date">Appointment Date</label>
                                        <input id="date" name="date" type="date" class="form-control arrival_date" placeholder="Appointment Date" required/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="time">Appointment Time</label>
                                        <input type="time" id="time" name="time" class="form-control" placeholder="Appointment Time" required/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="doctor">Select A Doctor</label>
                                        <div class="select-wrap">
                                            <select id="doctor" name="doctor" class="form-control"></select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="message">Message</label>
                                        <textarea name="message" id="message" cols="0" rows="5" class="form-control" placeholder="Message"></textarea>
                                    </div>
                                </div>
                                <input type="hidden" name="id" value="<%=user.getId()%>" />
                                <div class="col-md-12 d-flex align-items-center">
                                    <div class="form-group">
                                        <input type="submit" value="Book Appointment" class="btn btn-white py-3 d-block rounded">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <%  }  %>
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
