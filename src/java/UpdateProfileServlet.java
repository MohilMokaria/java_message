
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig
public class UpdateProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String jdbcUri = getServletContext().getInitParameter("jdbcUri");
        String dbUri = getServletContext().getInitParameter("dbUri");
        String dbId = getServletContext().getInitParameter("dbId");
        String dbPass = getServletContext().getInitParameter("dbPass");

        response.setContentType("text/html");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("userEmail");
        String uname = request.getParameter("uname");

        Part filePart = request.getPart("photo");
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[4096];
        int bytesRead;
        try (InputStream inputStream = filePart.getInputStream()) {
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                byteArrayOutputStream.write(buffer, 0, bytesRead);
            }
        }
        byte[] imageData = byteArrayOutputStream.toByteArray();

        try {
            Class.forName(jdbcUri);

            try (Connection con = DriverManager.getConnection(dbUri, dbId, dbPass)) {

                PreparedStatement ps = con.prepareStatement("SELECT * FROM final_users_tbl WHERE uname=?");
                ps.setString(1, uname);
                ResultSet r = ps.executeQuery();

                if (r.next()) {
                    String error = uname + " is already taken !";
                    request.setAttribute("error", error);
                    RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
                    rd.include(request, response);
                } else {
                    PreparedStatement ps2 = con.prepareStatement("UPDATE final_users_tbl SET uname = ?, image = ? WHERE email = ?");
                    ps2.setString(1, uname);
                    InputStream inputStream = filePart.getInputStream();
                    ps2.setBlob(2, inputStream);
                    ps2.setString(3, email);

                    ps2.executeUpdate();

                    response.sendRedirect("ShowProfileServlet");
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("exception", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
            rd.include(request, response);
        }
    }
}
