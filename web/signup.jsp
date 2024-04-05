<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign-in | Message</title>

        <!-- BOOTSTRAP CDN -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />
        <!-- CUSTOM CSS -->
        <link rel="stylesheet" href="./css/signup-styles.css" />

    </head>
    <body>

        <div class="card-body d-flex flex-column my-card">
            <%
            String exceptionMsg = (String) request.getAttribute("exception");
            if (exceptionMsg != null && !exceptionMsg.isEmpty()) {
            %>
            <p class="alert alert-danger"><%= exceptionMsg%></p> 
            <%
                }
            %>
            <%
                String error = (String) request.getAttribute("error");
                if (error != null && !error.isEmpty()) {
            %>
            <p class="alert alert-danger"><%= error%></p> 
            <%
                }
            %>
            <%
                String success = (String) request.getAttribute("success");
                if (success != null && !success.isEmpty()) {
            %>
            <p class="alert alert-success"><%= success%></p> 
            <%
                }
            %>
            <ul
                class="nav nav-pills mb-3 d-flex justify-content-center my-pills-list"
                id="pills-tab"
                role="tablist"
                >
                <div class="d-flex gap-3">
                    <li class="nav-item myPill" role="presentation">
                        <button
                            class="nav-link active my-pills-button"
                            id="pills-home-tab"
                            data-bs-toggle="pill"
                            data-bs-target="#pills-home"
                            type="button"
                            role="tab"
                            aria-controls="pills-home"
                            aria-selected="true"
                            >
                            Login
                        </button>
                    </li>
                    <li class="nav-item myPill" role="presentation">
                        <button
                            class="nav-link my-pills-button"
                            id="pills-profile-tab"
                            data-bs-toggle="pill"
                            data-bs-target="#pills-profile"
                            type="button"
                            role="tab"
                            aria-controls="pills-profile"
                            aria-selected="false"
                            >
                            Register
                        </button>
                    </li>
                </div>
            </ul>

            <div class="tab-content" id="pills-tabContent">
                <div
                    class="tab-pane fade show active"
                    id="pills-home"
                    role="tabpanel"
                    aria-labelledby="pills-home-tab"
                    tabindex="0"
                    >
                    <form id="logform" class="my-form" action="LoginServlet" method="post">
                        <div class="form-floating mb-3">
                            <input
                                type="email"
                                class="form-control"
                                id="mail-login"
                                placeholder="Registered Email"
                                name="mail"
                                required
                                />
                            <label for="floatingInput" class="my-form-label">
                                Registered Email
                            </label>
                        </div>

                        <div class="form-floating mb-3">
                            <input
                                type="password"
                                class="form-control"
                                id="pass-login"
                                placeholder="Account Password"
                                name="pass"
                                required
                                />
                            <label for="floatingInput" class="my-form-label">
                                Account Password
                            </label>
                        </div>

                        <div class="my-btn-div">
                            <button
                                type="submit"
                                class="btn btn-primary submit-btn"
                                >
                                Login
                            </button>
                        </div>
                    </form>
                </div>
                <div
                    class="tab-pane fade"
                    id="pills-profile"
                    role="tabpanel"
                    aria-labelledby="pills-profile-tab"
                    tabindex="0"
                    >
                    <form id="regform" class="my-form" action="SignupServlet" method="post" enctype="multipart/form-data">
                        <div id="profile-img-container" class="mb-3">
                            <img id="profile-img" src="./assets/user.jpg" alt="Profile Picture" onclick="triggerFileInput()">
                        </div>
                        <input id="upload-input" type="file" name="photo" accept="image/*" style="display:none;">

                        <div class="form-floating mb-3">
                            <input
                                type="text"
                                class="form-control"
                                id="uname-signup"
                                placeholder="User Name"
                                name="uname"
                                required
                                />
                            <label for="floatingInput" class="my-form-label">User Name</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input
                                type="email"
                                class="form-control"
                                id="mail-signup"
                                placeholder="Your Email"
                                name="mail"
                                required
                                />
                            <label for="floatingInput" class="my-form-label">Your Email</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input
                                type="password"
                                class="form-control"
                                id="pass-signup"
                                placeholder="New Password"
                                name="pass1"
                                required
                                />
                            <label for="floatingInput" class="my-form-label">New Password</label>
                        </div>

                        <div class="form-floating mb-3">
                            <input
                                type="password"
                                class="form-control"
                                id="conpass-signup"
                                placeholder="Confirm Password"
                                name="pass2"
                                required
                                />
                            <label for="floatingInput" class="my-form-label">Confirm Password</label>
                        </div>

                        <div class="my-btn-div">
                            <button
                                type="button"
                                onclick="validateAndSubmit()"
                                class="btn btn-primary submit-btn"
                                >
                                Sign-up
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

        <!-- BOOTSTRAP JS -->
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"
        ></script>
        <script>
                function validateAndSubmit() {
                    var fileInput = document.getElementById('upload-input');
                    if (fileInput.files.length === 0) {
                        alert("Please select an image.");
                        return;
                    }

                    // If file input has files selected, submit the form
                    document.getElementById('regform').submit();
                }

                function triggerFileInput() {
                    document.getElementById('upload-input').click();
                }

                document.getElementById('upload-input').addEventListener('change', function () {
                    var file = this.files[0];
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('profile-img').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                });

        </script>
    </body>
</html>
