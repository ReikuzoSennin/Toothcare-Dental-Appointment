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
                    var dentist = `<div class="col-md-6 col-lg-3" data-aos="flip-right" data-aos-delay="100" data-aos-duration="1000">
                        <div class="staff">
                            <div class="img-wrap d-flex align-items-stretch">
                                <div class="img align-self-stretch" style="background-image: url(`+value.image+`);"></div>
                            </div>
                            <div class="text text-center">
                                <h3 class="mb-2">`+dr+`</h3>
                                <span class="position mb-2" id="dentist_role">`+value.role+`</span>
                                <div class="faded">
                                    <ul class="ftco-social text-center">
                                        <li class="ftco-animate"><a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-twitter"></span></a></li>
                                        <li class="ftco-animate"><a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-facebook"></span></a></li>
                                        <li class="ftco-animate"><a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-google"></span></a></li>
                                        <li class="ftco-animate"><a href="#" class="d-flex align-items-center justify-content-center"><span class="fa fa-instagram"></span></a></li>
                                    </ul>
                                    <p>`+value.description+`</p>
                                </div>
                            </div>
                        </div>
                    </div>`;
                    $('#team').append(dentist);
                });
            },
            error: function (jqXHR, textStatus, errorThrown) {
                $('#team').append('<h3 class="mb-2">No Doctors Available</h3>');
            },
            cache: false
        });
    });
</script>
<body>
    <jsp:include page="header.jsp"/>
    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_2.jpg');">
        <div class="overlay"></div>
        <div class="container">
            <div class="row no-gutters slider-text align-items-end justify-content-center">
                <div class="col-md-9 text-center mb-5">
                    <p class="breadcrumbs"><span class="me-2"><a href="index.jsp">Home <i class="fa fa-chevron-right"></i></a></span> <span>Dentist <i class="fa fa-chevron-right"></i></span></p>
                    <h1 class="mb-0 bread">Qualified Doctors</h1>
                </div>
            </div>
        </div>
    </section>
    <section class="ftco-intro-2 img" style="background-image: url(images/bg_1.jpg);">
        <div class="overlay"></div>
        <div class="container-xl">
            <div class="row justify-content-center">
                <div class="col-lg-10 col-xl-10">
                    <div class="row" data-aos="fade-up" data-aos-duration="1000">
                        <div class="col-md-8 d-flex align-items-center">
                            <div>
                                <span class="subheading">Book your appointment</span>
                                <h1 class="mb-md-0 mb-4">Dont wait make an appointment today!</h1>
                            </div>
                        </div>
                        <div class="col-md-4 d-flex align-items-center">
                            <p class="mb-0"><a href="login.jsp" class="btn btn-white py-md-4 py-3 px-md-5 px-4">Make An Appointment</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="ftco-section">
        <div class="container">
            <div class="row" id="team"></div>
        </div>
    </section>
    <section class="ftco-section ftco-no-pb bg-light">
        <div class="container-xl-fluid">
            <div class="row justify-content-center mb-5">
                <div class="col-md-7 heading-section text-center" data-aos="fade-up" data-aos-duration="1000">
                    <span class="subheading">Stories</span>
                    <h2>Result of our Treatment and Work</h2>
                </div>
            </div>
            <div class="row g-0">
                <div class="col-md-3" data-aos="flip-left" data-aos-delay="100" data-aos-duration="1000">
                    <div class="result-wrap">
                        <div class="img" style="background-image: url(images/result-1.jpg);"></div>
                        <div class="text text-center">
                            <span>Shah Alam, 28 years</span>
                            <h3>Johnson</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3" data-aos="flip-left" data-aos-delay="100" data-aos-duration="1000">
                    <div class="result-wrap">
                        <div class="img" style="background-image: url(images/result-2.jpg);"></div>
                        <div class="text text-center">
                            <span>Kuala Lumpur, 23 years</span>
                            <h3>Leah Tylor</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3" data-aos="flip-left" data-aos-delay="100" data-aos-duration="1000">
                    <div class="result-wrap">
                        <div class="img" style="background-image: url(images/result-3.jpg);"></div>
                        <div class="text text-center">
                            <span>Genting Highland, 25 years</span>
                            <h3>Mary Johnson</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3" data-aos="flip-left" data-aos-delay="100" data-aos-duration="1000">
                    <div class="result-wrap">
                        <div class="img" style="background-image: url(images/result-4.jpg);"></div>
                        <div class="text text-center">
                            <span>Kuala Klang, 29 years</span>
                            <h3>Beatrice Schwarzenegger</h3>
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