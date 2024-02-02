<%@page import="java.util.*" %>
<%@page import="bean.Register" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/login.css">
        <title>ToothCare</title>
        <script src="js/jquery-latest.min.js"></script>
    </head>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                url: "GetStatePostcodeServlet",
                method: "GET",
                data: {operation: 'state'},
                success: function (data, textStatus, jqXHR) {
                    let obj = $.parseJSON(data);
                    $.each(obj, function (key, value) {
                        $('#state').append('<option value="' + value.state_code + '">' + value.state_name + '</option>');
                    });
                    let sid = obj[0].state_code;
                    $.ajax({
                        url: "GetStatePostcodeServlet",
                        method: "GET",
                        data: {
                            operation: 'postcode',
                            state: sid
                        },
                        success: function (data, textStatus, jqXHR) {
                            let obj = $.parseJSON(data);
                            $.each(obj, function (key, value) {
                                $('#postcode').append('<option value="' + value.postcode + '">' + value.postcode + '</option>');
                            });
                            let pid = obj[0].postcode;
                            $.ajax({
                                url: "GetStatePostcodeServlet",
                                method: "GET",
                                data: {
                                    operation: 'area',
                                    postcode: pid
                                },
                                success: function (data, textStatus, jqXHR) {
                                    let obj = $.parseJSON(data);
                                    $.each(obj, function (key, value) {
                                        $('#area').append('<option value="' + value.areaid + '">' + value.area_name + '</option>');
                                    });
                                    let post_office = obj[0].post_office;
                                    $('#postoffice').val(post_office);
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    $('#area').append('<option>Area Unavailable</option>');
                                },
                                cache: false
                            });
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#postcode').append('<option>Postcode Unavailable</option>');
                        },
                        cache: false
                    });
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    $('#state').append('<option>State Unavailable</option>');
                },
                cache: false
            });
            $('#state').change(function () {
                $('#postcode').find('option').remove();
                $('#area').find('option').remove();
                let sid = $('#state').val();
                let data = {
                    operation: "postcode",
                    state: sid
                };
                $.ajax({
                    url: "GetStatePostcodeServlet",
                    method: "GET",
                    data: data,
                    success: function (data, textStatus, jqXHR) {
                        let obj = $.parseJSON(data);
                        $.each(obj, function (key, value) {
                            $('#postcode').append('<option value="' + value.postcode + '">' + value.postcode + '</option>');
                        });
                        let pid = obj[0].postcode;
                        $.ajax({
                            url: "GetStatePostcodeServlet",
                            method: "GET",
                            data: {
                                operation: 'area',
                                postcode: pid
                            },
                            success: function (data, textStatus, jqXHR) {
                                let obj = $.parseJSON(data);
                                $.each(obj, function (key, value) {
                                    $('#area').append('<option value="' + value.areaid + '">' + value.area_name + '</option>');
                                });
                                let post_office = obj[0].post_office;
                                $('#postoffice').val(post_office);
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                $('#area').append('<option>Area Unavailable</option>');
                            },
                            cache: false
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#postcode').append('<option>Postcode Unavailable</option>');
                    },
                    cache: false
                });
            });
            $('#postcode').change(function () {
                $('#area').find('option').remove();
                let pid = $('#postcode').val();
                let data = {
                    operation: "area",
                    postcode: pid
                };
                $.ajax({
                    url: "GetStatePostcodeServlet",
                    method: "GET",
                    data: data,
                    success: function (data, textStatus, jqXHR) {
                        let obj = $.parseJSON(data);
                        $.each(obj, function (key, value) {
                            $('#area').append('<option value="' + value.areaid + '">' + value.area_name+ '</option>');
                        });
                        let post_office = obj[0].post_office;
                        $('#postoffice').val(post_office);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        $('#area').append('<option>Area Unavailable</option>');
                    },
                    cache: false
                });
            });

        });
        </script>
    <body>
        <main>
            <!-- section pertama -->
            <section class="slide slide-one">
                <!-- LOGIN -->
                <div class="message message-one">
                    <div class="message-caption">
                        <h1>Hello</h1>
                        <p>Enter your personal details and start journey with us</p>
                    </div>
                    <button class="btn-enter">Sign up</button>
                </div>
                <!-- REGISTER -->
                <div class="message message-two">
                    <div class="message-caption">
                        <h1>Welcome back</h1>
                        <p>To keep connected with us please enter your personal info</p>
                    </div>
                    <button class="btn-enter">Login</button>
                </div>
            </section>
            <!-- section kedua -->
            <section class="form-page slide slide-two">
                <div class="form-container">
                    <!-- LOGIN -->
                    <div class="form-wrapper form-wrapper-one">
                        <section class="header">
                            <h1>Sign in to App</h1>
                            <%
                                List errorMsgsL = (List) request.getAttribute("errorMsgsLogin");
                                if(errorMsgsL!=null) {
                                    Iterator items = errorMsgsL.iterator();
                                    while(items.hasNext()) {
                                        String messageL = (String) items.next();
                            %>
                            <font color="red"><li><%=messageL%></li></font>
                            <%
                                    }
                                }
                            %>
                        </section>
                        <form class="input-group" action="LoginServlet" method="post">
                            <div class="email-input input">
                                <label for="emailLogin">Email</label>
                                <input type="email" name="email" id="emailLogin" required/>
                            </div>
                            <div class="password-input input">
                                <label for="passwordLogin">Password</label>
                                <input type="password" name="password" id="passwordLogin" required/>
                            </div>
                            <div class="forget-password-input input">
                                <a href="" class="forget-link">Forgot your Password ?</a>
                            </div>
                            <div class="button-input input">
                                <button>Login</button>
                            </div>
                        </form>
                    </div>
                    <!-- REGISTER -->
                    <div class="form-wrapper form-wrapper-two form-wrapper-hidden">
                        <section class="header">
                            <h1>Create Account</h1>
                            <%
                                List errorMsgsR = (List) request.getAttribute("errorMsgsRegister");
                                if(errorMsgsR!=null) {
                                    Iterator items = errorMsgsR.iterator();
                                    while(items.hasNext()) {
                                        String messageR = (String) items.next();
                            %>
                            <font color="red"><li class="center"><%=messageR%></li></font>
                            <%
                                    }
                                }
                            %>
                        </section>
                        <form id="signup" class="input-group" action="RegisterServlet" method="post">
                            <div class="name-input input">
                                <label for="name">Name</label>
                                <input type="text" name="name" id="name" value="${param.name}" required/>
                            </div>
                            <div class="email-input input">
                                <label for="emailRegister">Email</label>
                                <input type="email" name="email" id="emailRegister" required/>
                            </div>
                            <div class="password-input input">
                                <label for="passwordRegister">Password</label>
                                <input type="password" name="password" id="passwordRegister" required/>
                            </div>
                            <div class="phone-input input">
                                <label for="phone">Phone Number</label>
                                <input type="tel" name="phone" id="phone" pattern="[0-9]{3}-[0-9]{7}" placeholder="012-3456789" required/>
                            </div>
                            <div class="flex">
                                <div class="state-input input form-group">
                                    <label for="state">State</label>
                                    <div class="select-wrap">
                                        <select name="state" id="state" class="form-control" required></select>
                                    </div>
                                </div>
                                <div class="postcode-input input form-group">
                                    <label for="postcode">Postcode</label>
                                    <div class="select-wrap">
                                        <select name="postcode" id="postcode" class="form-control" required></select>
                                    </div>
                                </div>
                            </div>
                            <div class="area-input input form-group">
                                <label for="area">Area</label>
                                <div class="select-wrap">
                                    <select name="area" id="area" class="form-control" required></select>
                                </div>
                            </div>
                            <input type="hidden" name="postoffice" id="postoffice"/>
                            <div class="button-input input">
                                <button type="submit" form="signup">Sign up</button>
                            </div>
                        </form>
                    </div>
                </div>
            </section>
            <div class="top-left">
                <a href="index.jsp"><img src="data:image/png;base64,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"></a>
            </div>
        </main>
        <script src="js/login.js"></script>
    </body>
</html>
