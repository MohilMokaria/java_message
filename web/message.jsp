<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Message | Create New Message</title>
        <!-- BOOTSTRAP CDN -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />
        <!-- CUSTOM CSS -->
        <link rel="stylesheet" href="./css/chat-styles.css" />
    </head>
    <body>
        <%
            if (session.getAttribute("userEmail") != null) {
        %>

        <nav class="navbar navbar-expand-lg fixed-top">
            <div class="container-fluid">
                <h5 class="navbar-brand me-auto">Message</h5>
                <div
                    class="offcanvas offcanvas-end"
                    tabindex="-1"
                    id="offcanvasNavbar"
                    aria-labelledby="offcanvasNavbarLabel"
                    >
                    <div class="offcanvas-header">
                        <h5 class="offcanvas-title" id="offcanvasNavbarLabel">Message</h5>
                        <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="offcanvas"
                            aria-label="Close"
                            ></button>
                    </div>
                    <div class="offcanvas-body">
                        <ul
                            class="navbar-nav justify-content-center flex-grow-1 pe-3 my-toggle-menu"
                            >
                            <li class="nav-item">
                                <a class="nav-link mx-lg-2 mitem" aria-current="page" href="ReceiveMessageServet">
                                    <div class="d-flex gap-1">
                                        <span class="material-symbols-outlined">
                                            download
                                        </span>
                                        <div>Inbox</div>
                                    </div>
                                </a>
                            </li>
                            <hr class="nav-hr" />
                            <li class="nav-item">
                                <a class="nav-link mx-lg-2 mitem" href="SendMessageServet">
                                    <div class="d-flex gap-1">
                                        <span class="material-symbols-outlined">
                                            upload
                                        </span>
                                        <div>Outbox</div>
                                    </div>
                                </a>
                            </li>
                            <hr class="nav-hr" />
                            <li class="nav-item">
                                <a class="nav-link mx-lg-2 mitem" href="message.jsp">
                                    <div class="d-flex gap-1">
                                        <span class="material-symbols-outlined">
                                            edit_square
                                        </span>
                                        <div>Create Message</div>
                                    </div>
                                </a>
                            </li>
                            <hr class="nav-hr" />
                            <li class="nav-item profile-navbar">
                                <a
                                    href="ShowProfileServlet"
                                    class="nav-link mx-lg-2 mitem"
                                    >
                                    <div class="d-flex gap-1">
                                        <span class="material-symbols-outlined my-nav-icons">
                                            person_book
                                        </span>
                                        <div>My Profile</div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <a href="ShowProfileServlet" class="profile-button">
                    <div class="d-flex gap-1">
                        <span class="material-symbols-outlined my-nav-icons">
                            person_book
                        </span>
                        <div>My Profile</div>
                    </div>
                </a>
                <button
                    class="navbar-toggler pe-0"
                    type="button"
                    data-bs-toggle="offcanvas"
                    data-bs-target="#offcanvasNavbar"
                    aria-controls="offcanvasNavbar"
                    aria-label="Toggle navigation"
                    >
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
        </nav>
        <div class="chat-form">
            <form action="ChatServlet" method="post">
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null && !error.isEmpty()) {
                %>          
                <p class="alert alert-danger"><%= error%></p>  
                <%
                    }
                %>
                <%
                    String exception = (String) request.getAttribute("exception");
                    if (error != null && !error.isEmpty()) {
                %>          
                <p class="alert alert-danger"><%= exception%></p>  
                <%
                    }
                %>
                <div class="mb-4">
                    <h2>New Message</h2>
                </div>

                <div class="form-floating mb-3">
                    <input
                        type="email"
                        class="form-control"
                        id="email"
                        placeholder="Receiver's ID"
                        name="email"
                        required
                        />
                    <label for="floatingInput" class="my-form-label">Receiver's ID</label>
                </div>

                <div class="form-floating mb-3">
                    <textarea
                        class="form-control"
                        id="message"
                        placeholder="Message"
                        name="message"
                        required
                        ></textarea>
                    <label for="floatingInput" class="my-form-label">Message</label>
                </div>

                <center><button type="submit" class="btn btn-primary btn-block mb-2 profile-btn">Send</button></center>
            </form>
        </div>
        <!-- GOOGLE ICONS CDN -->
        <link
            rel="stylesheet"
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0"
            />
        <!-- BOOTSTRAP JS -->
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"
        ></script>
        
        <% } else { %>
            <% response.sendRedirect("signup.jsp");%>
        <% }%>
    </body>
</html>
