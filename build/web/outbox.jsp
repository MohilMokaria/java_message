<%@page import="java.security.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="myClass.Message" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Home Screen</title>
        <!-- BOOTSTRAP CDN -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
            crossorigin="anonymous"
            />
        <!-- CUSTOM CSS -->
        <link rel="stylesheet" href="./css/home-styles.css" />
    </head>

    <body>
        <%
            if (session.getAttribute("userEmail") != null) {
        %>
        <!-- NAVBAR -->
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
        <!-- NAVBAR-END -->

        <!-- Main Content -->
        <div class="section-wrapper">
            <h5>Outbox</h5>
            <div class="chat-content">
                <%
                    List<Message> messageList = (List<Message>) request.getAttribute("sentList");
                    if (messageList != null && !messageList.isEmpty()) {
                        int modalCount = 1;
                        for (Message message : messageList) {
                        String modalId = "recipeModel" + modalCount;
                        byte[] imageData = message.getReceiverImage();
                        String base64Image = java.util.Base64.getEncoder().encodeToString(imageData);
                %>
                <a data-bs-toggle="modal" data-bs-target="#my-model<%= modalCount %>">
                    <div class="chat gap-2">
                        <img
                            src="data:image/jpeg;base64,<%= base64Image %>"
                            class="profile-pic"
                            alt="Profile Picture"
                            />
                        <span class="user-name"><%= message.getReceiver()%></span>
                        <span class="user-message"><%= message.getMsg()%></span>
                        <span class="user-time"><%= message.getFormattedMsgTime()%></span>
                    </div>
                </a>
                <div class="modal fade" id="my-model<%= modalCount %>" tabindex="-1" aria-labelledby="my-model<%= modalCount %>Label" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                        <div class="modal-content">
                            <div class="modal-header">
                                <div class="d-flex">
                                    <img src="data:image/jpeg;base64,<%= base64Image %>" class="profile-pic" alt="Profile Picture"/>
                                    <h5 class="modal-title ms-4" id="<%= modalCount %>Label"><%= message.getReceiver()%></h5>
                                </div>
                            </div>
                            <div class="modal-body">
                                <p><%= message.getMsg()%></p>
                                <span class="user-time"><%= message.getFormattedMsgTime()%></span>
                            </div>
                            <div class="modal-footer">
                                <button type="button" onclick="navigateToURL()" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                            modalCount++;
                        }
                    } else {
                %>
                <div class="centered-content">
                    <p>Outbox Empty!</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
        <!-- Main Content-END -->

        <% } else { %>
        <% response.sendRedirect("signup.jsp");%>
        <% }%>

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
    </body>
</html>
