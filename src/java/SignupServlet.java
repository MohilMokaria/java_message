
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

@WebServlet("/SignupServlet")
@MultipartConfig
public class SignupServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String jdbcUri = getServletContext().getInitParameter("jdbcUri");
        String dbUri = getServletContext().getInitParameter("dbUri");
        String dbId = getServletContext().getInitParameter("dbId");
        String dbPass = getServletContext().getInitParameter("dbPass");

        response.setContentType("text/html");

        String uname = request.getParameter("uname");
        String email = request.getParameter("mail");
        String password = request.getParameter("pass1");

        // Get the uploaded file
        Part filePart = request.getPart("photo");

        // Read the image data into a byte array
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
                    RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                    rd.include(request, response);
                } else {
                    PreparedStatement ps1 = con.prepareStatement("SELECT * FROM final_users_tbl WHERE email=?");
                    ps1.setString(1, email);

                    ResultSet rs = ps1.executeQuery();

                    if (rs.next()) {
                        String error = "User already registered with <br>" + email;
                        request.setAttribute("error", error);
                        RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                        rd.include(request, response);
                    } else {
                        PreparedStatement ps2 = con.prepareStatement("INSERT INTO final_users_tbl(uname,email, password, image) values(?,?,?,?)");
                        ps2.setString(1, uname);
                        ps2.setString(2, email);
                        ps2.setString(3, password);
                        InputStream inputStream = filePart.getInputStream();
                        ps2.setBlob(4, inputStream);

                        int i = ps2.executeUpdate();
                        String success = "Account Created! \nTry to login with " + email;
                        request.setAttribute("success", success);
                        RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                        rd.include(request, response);
                    }
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("exception", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
            rd.include(request, response);
        }
    }
}
