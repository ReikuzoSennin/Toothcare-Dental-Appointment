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
                <div class="heading-section d-flex align-items-center" data-aos="fade-up" data-aos-delay="200" data-aos-duration="1000">
                    <form class="input-group" action="ChangePassword" method="post">
                        <div class="mt-0 my-lg-5 py-5">
                            <span class="subheading">Change Password</span>
                            <%
                                List errorMsgs = (List) request.getAttribute("errorMsgs");
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
                            <div class="row mt-4 g-lg-2">
                                <%
                                    if(session.getAttribute("user") != null) {
                                        User user = (User)session.getAttribute("user");
                                %>
                                <input type="hidden" name="id" value="<%=user.getId()%>" />
                                <% } %>
                                <div class="input">
                                    <label for="oldpass">Old Password</label>
                                    <input id="oldpass" name="oldpass" type="password" class="form-control" placeholder="Old Password" required/>
                                </div>
                                <div class="input">
                                    <label for="newpass">New Password</label>
                                    <input id="newpass" name="newpass" type="password" class="form-control" placeholder="New Password" required/>
                                </div>
                                <div class="input">
                                    <label for="newpass2">Confirm New Password</label>
                                    <input id="newpass2" name="newpass2" type="password" class="form-control" placeholder="Confirm New Password" required/>
                                </div>
                                <div class="col-md-12 d-flex align-items-center">
                                    <div class="form-group">
                                        <input type="submit" value="Submit" class="btn btn-primary p-4 py-3">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
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
