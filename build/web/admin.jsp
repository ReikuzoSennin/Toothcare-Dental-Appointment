<%@page import="bean.User"%>
<%@page import="bean.Appointment"%>
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
<script type="text/javascript">
    $(document).ready(function() {
        var dentistname = '${dentist.getName()}';
        console.log(dentistname);
        var id = parseInt('${user.getId()}');
        console.log(id);
        $.ajax({
            url: "GetAppointmentServlet",
            method: "GET",
            data: {
                id: id
            },
            success: function (data, textStatus, jqXHR) {
                let obj = $.parseJSON(data);
                $.each(obj, function (key, value) {
                    var appointment = `<div class="col-md-6 col-lg-30" data-aos="flip-right" data-aos-delay="100" data-aos-duration="1000">
                        <div class="staff">
                            <div class="text text-center">
                                <h3 class="mb-2">`+value.name+`</h3>
                                <span class="position mb-2" id="dentist_role">`+value.email+`</span>
                                <span class="position mb-2" id="dentist_role">`+value.phone+`</span>
                                <span class="position mb-2" id="dentist_role">DATE: `+value.date+`</span>
                                <span class="position mb-2" id="dentist_role">TIME: `+value.time+`</span>
                                <div class="faded">
                                    <p>`+value.message+`</p>
                                </div>
                            </div>
                        </div>
                    </div>`;
                    $('#appointment').append(appointment);
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $('#appointment').append('<h3 class="mb-2">No Appointments Available</h3>');
            },
            cache: false
        });
    });
</script>
<body>
    <jsp:include page="headeradmin.jsp"/>
    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_2.jpg');">
        <div class="overlay"></div>
        <div class="container">
            <div class="row no-gutters slider-text align-items-end justify-content-center">
                <div class="col-md-9 text-center mb-5">
                    <p class="breadcrumbs"><span class="me-2"><a href="index.jsp">Home <i class="fa fa-chevron-right"></i></a></span> <span>Dentist <i class="fa fa-chevron-right"></i></span></p>
                    <h1 class="mb-0 bread">Your Appointments</h1>
                </div>
            </div>
        </div>
    </section>
    <section class="ftco-section">
        <div class="container">
            <div class="row" id="appointment"></div>
        </div>
    </section>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/tiny-slider.js"></script>
    <script src="js/glightbox.min.js"></script>
    <script src="js/aos.js"></script>
    <script src="js/datepicker.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
