package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;

@WebServlet("/ServletLogin")
public class ServletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletLogin() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/* Recebe os dados enviado pelo formul�rio e coloca em uma vari�vel */
		String login = request.getParameter("login");
		String senha = request.getParameter("senha");
		/* Confere se o login e senha s�o diferentes de null e n�o est� vazio */
		if (login != null && !login.isEmpty() && senha != null && !senha.isEmpty()) {
			/* Cria o objeto e seta os valores */
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setLogin(login);
			modelLogin.setSenha(senha);

		} else {
			/* Cria um dispatcher para redirecionar para a p�gina index.jsp */
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
			/* Seta uma msg para aparecer na tela e chama o forward para enviar tudo */
			request.setAttribute("msg", "Informe o login e senha corretamente");
			requestDispatcher.forward(request, response);
		}

	}

}
