<%@page import="bean.User"%>
<%@page import="bean.Appointment"%>
<%@page import="java.util.*"%>
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
        $.ajax({
            url: "GetDentistServlet",
            method: "GET",
            data: {
                clause: "FETCH FIRST 3 ROWS ONLY"
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
    <section class="slider-hero">
        <div class="overlay"></div>
        <div class="item">
            <div class="work">
                <div class="img d-flex align-items-center justify-content-center js-fullheight" style="background-image: url(images/bg_2.jpg);">
                    <div class="container-xl">
                        <div class="row">
                            <div class="col-md-12 col-lg-10">
                                <div class="row">
                                    <div class="col-md-8 col-lg-6">
                                        <div class="text mt-md-5">
                                            <h1 class="mb-4">A Brighter Dental Experienced</h1>
                                            <p class="mb-4">You'll feel right at home in our convenient family dentist office thanks to our focus on your comfort, health and happiness..</p>
                                            <p><a href="login.jsp" class="btn btn-primary p-4 py-3">Make An Appointment <span class="ion-ios-arrow-round-forward"></span></a> <a href="#" class="btn btn-white p-4 py-3">View Course <span class="ion-ios-arrow-round-forward"></span></a></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
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
                                        <input type="date" id="date" name="date" class="form-control arrival_date" placeholder="Appointment Date" required/>
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
                    <%  }  else { %>
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
                                        <input type="text" id="name" name="name" class="form-control" value="Please Login" readonly placeholder="Your Full Name" readonly/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="email">Email Address</label>
                                        <input id="email" name="email" type="email" class="form-control"  value="Please Login" readonly placeholder="Email" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="tel">Phone Number</label>
                                        <input type="text" id="tel" name="tel" class="form-control"  value="Please Login" readonly placeholder="Your Phone Number" readonly>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="date">Appointment Date</label>
                                        <input id="date" name="date" type="date" class="form-control arrival_date" placeholder="Appointment Date" readonly/>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="time">Appointment Time</label>
                                        <input type="time" id="time" name="time" class="form-control" placeholder="Appointment Time" readonly/>
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
                                        <textarea name="message" id="message" cols="0" rows="5" class="form-control" placeholder="Message" readonly>Login to book appointment.</textarea>
                                    </div>
                                </div>
                                <div class="col-md-12 d-flex align-items-center">
                                    <div class="form-group">
                                        <a href="login.jsp" class="btn btn-white py-3 d-block rounded">Login</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    <% } %>
                </div>
                <div class="col-md-6 heading-section d-flex align-items-center" data-aos="fade-up" data-aos-delay="200" data-aos-duration="1000">
                    <div class="mt-0 my-lg-5 py-5">
                        <span class="subheading">Learn Anything</span>
                        <h2 class="mb-2">We Offer Best Dental Services</h2>
                        <div class="row mt-4 g-lg-2">
                            <div class="col-lg-12 d-flex align-items-stretch services-wrap">
                                <div class="services d-flex">
                                    <div class="icon"><span class="flaticon-booking"></span></div>
                                    <div class="text">
                                        <h2>Easy Booking</h2>
                                        <p class="mb-0">We know how busy your schedule is, so your appointment will always start on time with no waiting.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 d-flex align-items-stretch services-wrap">
                                <div class="services d-flex">
                                    <div class="icon"><span class="flaticon-dentist"></span></div>
                                    <div class="text">
                                        <h2>Team Dentist</h2>
                                        <p class="mb-0">Our incredible team members have been with us for over 10 years.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12 d-flex align-items-stretch services-wrap">
                                <div class="services d-flex">
                                    <div class="icon"><span class="flaticon-offer"></span></div>
                                    <div class="text">
                                        <h2>Best Price Guarantee</h2>
                                        <p class="mb-0">We offer the best price and accept most insurances.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="ftco-section bg-light">
        <div class="container-xl" id="services">
            <div class="row justify-content-center">
                <div class="col-md-8 heading-section text-center mb-5" data-aos="fade-up" data-aos-duration="1000">
                    <span class="subheading">Services</span>
                    <h2 class="mb-4">Toothcare Services</h2>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-3 text-center d-flex align-items-stretch" data-aos="flip-right" data-aos-delay="100" data-aos-duration="1000">
                    <div class="services-2">
                        <div class="icon"><span class="flaticon-tooth"></span></div>
                        <div class="text">
                            <h2>Teeth Scaling</h2>
                            <p>The procedure gets rid of tartar that can adhere your teeth. You may need these treatments if you have periodontitis (advanced gum disease).</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 text-center d-flex align-items-stretch" data-aos="flip-right" data-aos-delay="200" data-aos-duration="1000">
                    <div class="services-2">
                        <div class="icon"><span class="flaticon-crown"></span></div>
                        <div class="text">
                            <h2>Dental Implants</h2>
                            <p>Replacement for your  tooth roots by providing a strong foundation for fixed (permanent) or removable replacement teeth that are made to match your natural teeth.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 text-center d-flex align-items-stretch" data-aos="flip-right" data-aos-delay="300" data-aos-duration="1000">
                    <div class="services-2">
                        <div class="icon"><span class="flaticon-dental-care"></span></div>
                        <div class="text">
                            <h2>Invisalign</h2>
                            <p>Invisalign aligners is an orthodontic procedure available to adults and kids who have misaligned or crooked teeth.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 text-center d-flex align-items-stretch" data-aos="flip-right" data-aos-delay="400" data-aos-duration="1000">
                    <div class="services-2">
                        <div class="icon"><span class="flaticon-tooth-1"></span></div>
                        <div class="text">
                            <h2>Teeth Whitening</h2>
                            <p>Teeth whitening is one of the most popular cosmetic dentistry treatments offering a quick, non-invasive and affordable way to enhance a smile.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 text-center d-flex align-items-stretch" data-aos="flip-right" data-aos-delay="100" data-aos-duration="1000">
                    <div class="services-2">
                        <div class="icon"><span class="flaticon-calculus"></span></div>
                        <div class="text">
                            <h2>Dental Calculus</h2>
                            <p>Tartar buildup bonds strongly to tooth enamel and must be removed by a dental professional. This can be done with a professional cleaning, debridement, or scaling and root planing.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 text-center d-flex align-items-stretch" data-aos="flip-right" data-aos-delay="200" data-aos-duration="1000">
                    <div class="services-2">
                        <div class="icon"><span class="flaticon-removal"></span></div>
                        <div class="text">
                            <h2>Tooth Extraction</h2>
                            <p>Tooth extraction is a procedure where a tooth or teeth are removed by an oral or maxillofacial surgeon using dental tools and equipment.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 text-center d-flex align-items-stretch" data-aos="flip-right" data-aos-delay="300" data-aos-duration="1000">
                    <div class="services-2">
                        <div class="icon"><span class="flaticon-calculus"></span></div>
                        <div class="text">
                            <h2>Tartar Removal</h2>
                            <p>Our dentist will clean your teeth and perform fouride treatment so they're free of plaque and tartar which can prevent permanent tooth decay and gum disease.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 text-center d-flex align-items-stretch" data-aos="flip-right" data-aos-delay="400" data-aos-duration="1000">
                    <div class="services-2">
                        <div class="icon"><span class="flaticon-dental-care-1"></span></div>
                        <div class="text">
                            <h2>Root Canal Therapy</h2>
                            <p>Dental procedure used to treat infection at the centre of a tooth. Root canal treatment is not painful and can save a tooth that might otherwise have to be removed completely.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="ftco-section ftco-no-pt ftco-no-pb">
        <div class="container-xl" id="about">
            <div class="row g-xl-5">
                <div class="col-md-6 d-flex align-items-stretch" data-aos="fade-up" data-aos-delay="100" data-aos-duration="1000">
                    <div class="img w-100" style="background-image: url(images/about.jpg);"></div>
                </div>
                <div class="col-md-6 heading-section d-flex align-items-center" data-aos="fade-up" data-aos-delay="200" data-aos-duration="1000">
                    <div class="mt-0 my-lg-5 py-5">
                        <span class="subheading">Welcome to our Dental Clinic</span>
                        <h2 class="mb-2">Toothcare is a Dental Clinic and Innovative Approach to Treatment</h2>
                        <p>Our team believes in accessible dental care. We offer straightforward pricing, clear estimates and an unprecedented dental warranty. Keep up with your routinr 6-month checkups and if something needs fixing, we'll hande it at no cost to you.</p>
                        <div class="row section-counter mt-5">
                            <div class="col-sm-6 col-md-6 col-lg-4 d-flex align-items-stretch">
                                <div class="counter-wrap-2 d-flex" data-aos="fade-up" data-aos-delay="100" data-aos-duration="1000">
                                    <div class="icon">
                                        <span class="flaticon-affection"></span>
                                    </div>
                                    <div class="text">
                                        <h2 class="number"><span class="countup">600</span></h2>
                                        <span class="caption">Happy Patients</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-4 d-flex align-items-stretch">
                                <div class="counter-wrap-2 d-flex" data-aos="fade-up" data-aos-delay="200" data-aos-duration="1000">
                                    <div class="icon">
                                        <span class="flaticon-gum"></span>
                                    </div>
                                    <div class="text">
                                        <h2 class="number"><span class="countup">1000</span></h2>
                                        <span class="caption">Performed Treatments</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6 col-lg-4 d-flex align-items-stretch">
                                <div class="counter-wrap-2 d-flex" data-aos="fade-up" data-aos-delay="400" data-aos-duration="1000">
                                    <div class="icon">
                                        <span class="flaticon-calendar"></span>
                                    </div>
                                    <div class="text">
                                        <h2 class="number"><span class="countup">10</span></h2>
                                        <span class="caption">Years of Experienced</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center pb-4">
                <div class="col-md-7 text-center heading-section" data-aos="fade-up" data-aos-duration="1000">
                    <span class="subheading">Our Teams</span>
                    <h2 class="mb-5">Professional Dentist</h2>
                </div>
            </div>
            <div class="row justify-content-center pb-4" id="team"></div>
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
                                <h1 class="mb-md-0 mb-4">Do not wait make an appointment today!</h1>
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
    <section class="ftco-section testimony-section">
        <div class="container-xl">
            <div class="row justify-content-center pb-4">
                <div class="col-md-7 text-center heading-section" data-aos="fade-up" data-aos-duration="1000">
                    <span class="subheading">Testimonial</span>
                    <h2 class="mb-5">Happy Customers</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="100">
                    <div class="carousel-testimony">
                        <div class="item">
                            <div class="testimony-wrap">
                                <div class="desc mb-4">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-quote-left"></div>
                                    <p class="mb-0 msg">Bagus aihh alu putih gigi.</p>
                                </div>
                                <div class="d-flex align-items-center mb-4">
                                    <div class="user-img" style="background-image: url(images/person_7.jpg)"></div>
                                    <div class="ps-3 tx">
                                        <p class="name">Najib Razak</p>
                                        <span class="position">PM</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimony-wrap">
                                <div class="desc mb-4">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-quote-left"></div>
                                    <p class="mb-0 msg">Lepas pergi klinik keluar-keluar je terus kompiden.</p>
                                </div>
                                <div class="d-flex align-items-center mb-4">
                                    <div class="user-img" style="background-image: url(images/person_11.jpg)"></div>
                                    <div class="ps-3 tx">
                                        <p class="name">tehyung</p>
                                        <span class="position">Idol dunia</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimony-wrap">
                                <div class="desc mb-4">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-quote-left"></div>
                                    <p class="mb-0 msg">Doktor semua lawa-lawa >w<</p>
                                </div>
                                <div class="d-flex align-items-center mb-4">
                                    <div class="user-img" style="background-image: url(images/person_10.jpg)"></div>
                                    <div class="ps-3 tx">
                                        <p class="name">Jungkuk</p>
                                        <span class="position">Singer</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimony-wrap">
                                <div class="desc mb-4">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-quote-left"></div>
                                        <p class="mb-0 msg">Gigi dah tak rongak lagi..Gigi korang semua lemah..siuuu..</p>
                                </div>
                                <div class="d-flex align-items-center mb-4">
                                    <div class="user-img" style="background-image: url(images/person_9.jpg)"></div>
                                    <div class="ps-3 tx">
                                        <p class="name">Ronuldo</p>
                                        <span class="position">Profesional shoot</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimony-wrap">
                                <div class="desc mb-4">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-quote-left"></div>
                                        <p class="mb-0 msg">Service dia lain macam woo apatah gi jumpa Dr idol Dr Johnny Sin.</p>
                                </div>
                                <div class="d-flex align-items-center mb-4">
                                    <div class="user-img" style="background-image: url(images/person_5.jpeg)"></div>
                                    <div class="ps-3 tx">
                                        <p class="name">Siti Khalifa</p>
                                        <span class="position">Tiktoker</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="testimony-wrap">
                                <div class="desc mb-4">
                                    <div class="icon d-flex align-items-center justify-content-center"><span class="fa fa-quote-left"></div>
                                    <p class="mb-0 msg">Sakit gigi lagi sakit dri putus cinta..untung ada klinik ni, gigi tak sakit lagi.</p>
                                </div>
                                    <div class="d-flex align-items-center mb-4">
                                        <div class="user-img" style="background-image: url(images/person_8.jpeg)">
                                    </div>
                                    <div class="ps-3 tx">
                                        <p class="name">Messi</p>
                                        <span class="position">Goat</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center pb-5">
                <div class="col-md-7 text-center heading-section" data-aos="fade-up" data-aos-duration="1000">
                    <span class="subheading">Our Pricing</span>
                    <h2 class="mb-3">Pricing &amp; <span>Packages</span></h2>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="100">
                    <div class="block-7">
                        <div class="text-center">
                            <span class="excerpt d-block">Basic Plan</span>
                            <span class="price"><sup>RM</sup> <span class="number">210</span></span>
                            <ul class="pricing-text mb-3">
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Diagnostic Services</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Professional Consultation</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Tooth Implants</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Surgical Extractions</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Teeth Whitening</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Teeth Cleaning</li>
                            </ul>
                            <a href="#" class="btn btn-primary d-block px-2 py-3">Get Started</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="200">
                    <div class="block-7">
                        <div class="text-center">
                            <span class="excerpt d-block">Beginner Plan</span>
                            <span class="price"><sup>RM</sup> <span class="number">330</span></span>
                            <ul class="pricing-text mb-3">
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Diagnostic Services</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Professional Consultation</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Tooth Extraction</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Surgical Extractions</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Teeth Whitening</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Teeth Cleaning</li>
                            </ul>
                            <a href="#" class="btn btn-primary d-block px-2 py-3">Get Started</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="300">
                    <div class="block-7">
                        <div class="text-center">
                            <span class="excerpt d-block">Premium Plan</span>
                            <span class="price"><sup>RM</sup> <span class="number">375</span></span>
                            <ul class="pricing-text mb-3">
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Diagnostic Services</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Professional Consultation</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Root Canal Therapy</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Surgical Extractions</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Teeth Whitening</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Teeth Cleaning</li>
                            </ul>
                            <a href="#" class="btn btn-primary d-block px-2 py-3">Get Started</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3" data-aos="fade-up" data-aos-duration="1000" data-aos-delay="400">
                    <div class="block-7">
                        <div class="text-center">
                            <span class="excerpt d-block">Ultimate Plan</span>
                            <span class="price"><sup>RM</sup> <span class="number">450</span></span>
                            <ul class="pricing-text mb-3">
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Diagnostic Services</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Professional Consultation</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Invisalign</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Surgical Extractions</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Teeth Whitening</li>
                                <li><span class="fa ion-ios-arrow-round-forward me-2"></span>Teeth Cleaning</li>
                            </ul>
                            <a href="#" class="btn btn-primary d-block px-2 py-3">Get Started</a>
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