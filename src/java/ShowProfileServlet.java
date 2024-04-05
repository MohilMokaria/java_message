
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

@WebServlet("/ShowProfileServlet")
public class ShowProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String jdbcUri = getServletContext().getInitParameter("jdbcUri");
        String dbUri = getServletContext().getInitParameter("dbUri");
        String dbId = getServletContext().getInitParameter("dbId");
        String dbPass = getServletContext().getInitParameter("dbPass");

        response.setContentType("text/html");

        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        String uname = "";
        byte[] profilePicture = null;

        try {
            Class.forName(jdbcUri);

            try (Connection con = DriverManager.getConnection(dbUri, dbId, dbPass)) {
                String sql = "SELECT uname, image FROM final_users_tbl WHERE email = ?";
                try (PreparedStatement ps = con.prepareStatement(sql)) {
                    ps.setString(1, email);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            uname = rs.getString("uname");
                            profilePicture = rs.getBytes("image");
                        }
                    }
                }
                session.setAttribute("uname", uname);
                session.setAttribute("profile", profilePicture);
                RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
                rd.include(request, response);

            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(ShowProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("exception", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
            rd.include(request, response);
        }
    }
}
