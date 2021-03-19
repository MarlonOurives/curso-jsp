package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.BeanCursoJsp;
import dao.DaoLogin;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	BeanCursoJsp beanCursoJsp = new BeanCursoJsp();

    public LoginServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			DaoLogin daoLogin = new DaoLogin();

			String login = request.getParameter("login");
			String senha = request.getParameter("senha");
			
			if(daoLogin.validarLogin(login, senha)) {
				RequestDispatcher requestDispatcher = request.getRequestDispatcher("acessoliberado.jsp");
				requestDispatcher.forward(request, response);
			}else {
				RequestDispatcher requestDispatcher = request.getRequestDispatcher("acessonegado.jsp");
				requestDispatcher.forward(request, response);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}

}
