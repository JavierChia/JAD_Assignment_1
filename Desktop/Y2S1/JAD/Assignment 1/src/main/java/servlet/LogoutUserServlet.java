package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.openejb.server.httpd.HttpSession;

/**
 * Servlet implementation class logout
 */
@WebServlet("/LogoutUserServlet")
public class LogoutUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LogoutUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		javax.servlet.http.HttpSession session = request.getSession(false);
		String redirectMsg = "";
		if (session.getAttribute("sessUserRole").equals("Admin")) {
			redirectMsg = "/ST0510_JAD_Assignment_1/index.jsp?statusCode=loggedOut";
		} else {
			String referer = request.getHeader("referer");
            if (referer != null && referer.contains("account.jsp")) {
                redirectMsg = "/ST0510_JAD_Assignment_1/index.jsp?statusCode=loggedOut";
            } else {
            	redirectMsg = request.getHeader("referer").split("\\?")[0] + "?statusCode=loggedOut";
            }
		}
        if (session != null) {
        	session.removeAttribute("sessUserID");
            session.removeAttribute("sessUserRole");
            session.removeAttribute("sessUserName");
            session.removeAttribute("sessUserEmail");
            session.removeAttribute("sessUserAddress");
            session.removeAttribute("sessUserPassword");
        }
        response.sendRedirect(redirectMsg);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
