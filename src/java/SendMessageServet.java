
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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import myClass.Message;

@WebServlet("/SendMessageServet")
public class SendMessageServet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String jdbcUri = getServletContext().getInitParameter("jdbcUri");
        String dbUri = getServletContext().getInitParameter("dbUri");
        String dbId = getServletContext().getInitParameter("dbId");
        String dbPass = getServletContext().getInitParameter("dbPass");

        response.setContentType("text/html");
        HttpSession session = request.getSession();
        String receiver = (String) session.getAttribute("userEmail");
        List<Message> sentList = new ArrayList<>();

        try {

            Class.forName(jdbcUri);
            try (Connection connection = DriverManager.getConnection(dbUri, dbId, dbPass)) {

                String sql = "SELECT sender, receiver, msg, msg_time, s_image, r_image FROM final_chat_tbl WHERE sender = ? ORDER BY msg_time DESC";

                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setString(1, receiver);

                    try (ResultSet resultSet = statement.executeQuery()) {
                        while (resultSet.next()) {
                            Message message = new Message();
                            message.setSender(resultSet.getString("sender"));
                            message.setReceiver(resultSet.getString("receiver"));
                            message.setMsg(resultSet.getString("msg"));
                            message.setMsgTime(resultSet.getTimestamp("msg_time"));
                            message.setSenderImage(resultSet.getBytes("s_image"));
                            message.setReceiverImage(resultSet.getBytes("r_image"));
                            sentList.add(message);
                        }

                    }
                }
                request.setAttribute("sentList", sentList);
                RequestDispatcher rd = request.getRequestDispatcher("outbox.jsp");
                rd.include(request, response);
            }

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(SendMessageServet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("exception", ex.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("outbox.jsp");
            rd.include(request, response);
        }
    }
}
