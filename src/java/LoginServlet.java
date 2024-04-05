
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String jdbcUri = getServletContext().getInitParameter("jdbcUri");
        String dbUri = getServletContext().getInitParameter("dbUri");
        String dbId = getServletContext().getInitParameter("dbId");
        String dbPass = getServletContext().getInitParameter("dbPass");
        response.setContentType("text/html");

        String email = request.getParameter("mail");
        String pass = request.getParameter("pass");

        try {
            Class.forName(jdbcUri);

            try (Connection con = DriverManager.getConnection(dbUri, dbId, dbPass)) {
                PreparedStatement ps = con.prepareStatement("SELECT * FROM final_users_tbl WHERE email=? AND password=?");

                ps.setString(1, email);
                ps.setString(2, pass);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userEmail", email);
//                    response.sendRedirect("./ReceiveMessageServet");
                    response.sendRedirect("ReceiveMessageServet");
                } else {
                    String error = "Invalid Login Credentials!";
                    request.setAttribute("error", error);
                    RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                    rd.include(request, response);
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("exception", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
            rd.include(request, response);
        }
    }
}
