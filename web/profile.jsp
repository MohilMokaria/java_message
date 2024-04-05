<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- BOOTSTRAP CDN -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />
        
        <!-- CUSTOM CSS -->
        <link rel="stylesheet" href="./css/profile-styles.css" />
        <title>Profile Setup</title>
    </head>
    <body>
        <%
          String email = (String) session.getAttribute("userEmail");
          if (email != null) {
          String uname = (String) session.getAttribute("uname");
          byte[] image = (byte[]) session.getAttribute("profile");
          String base64Image = java.util.Base64.getEncoder().encodeToString(image);
        %>
        <form id="regform" class="my-form my-card" action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
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
            <div id="profile-img-container" class="mb-3">
                <img id="profile-img" src="data:image/jpeg;base64,<%= base64Image %>" alt="Profile Picture" onclick="triggerFileInput()">
            </div>
            <input id="upload-input" type="file" name="photo" accept="image/*" style="display:none;">

            <div class="form-floating mb-3">
                <input
                    type="text"
                    class="form-control"
                    id="uname-signup"
                    placeholder="User Name"
                    name="uname"
                    value="<%= uname %>"
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
                    value="<%= email %>"
                    readonly
                    />
                <label for="floatingInput" class="my-form-label">Your Email</label>
            </div>

            <div class="my-btn-div">
                <button
                    type="button"
                    onclick="validateAndSubmit()"
                    class="btn btn-primary profile-btn"
                    >
                    Update Profile
                </button>
            </div>

            <a href="LogoutServlet" class="btn btn-danger profile-btn">Logout</a>
        </form>
        <% } else { %>
        <% response.sendRedirect("signup.jsp");%>
        <% }%>

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
