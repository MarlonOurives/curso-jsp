package servlets;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.ModelLogin;

@WebServlet(urlPatterns = {"/ServletLogin", "/principal/ServletLogin"})
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
		String url = request.getParameter("url");
		/* Confere se o login e senha s�o diferentes de null e n�o est� vazio */
		if (login != null && !login.isEmpty() && senha != null && !senha.isEmpty()) {
			/* Cria o objeto e seta os valores */
			ModelLogin modelLogin = new ModelLogin();
			modelLogin.setLogin(login);
			modelLogin.setSenha(senha);
			/* Simulando um usu�rio */
			if (modelLogin.getLogin().equalsIgnoreCase("admin") && modelLogin.getSenha().equalsIgnoreCase("admin")) {
				/* Coloca o usuario na sess�o */
				request.getSession().setAttribute("usuario", modelLogin.getLogin());
				if(url == null || url.equals("null")) {
					url = "principal/principal.jsp";
				}
				/* Redireciona para a tela inicial p�s logado */
				RequestDispatcher requestDispatcher = request.getRequestDispatcher(url);
				requestDispatcher.forward(request, response);
			} else {
				/* Faz um redirect para index com mensagem de dados incorretos */
				RequestDispatcher requestDispatcher = request.getRequestDispatcher("/index.jsp");
				request.setAttribute("msg", "Informe o login e senha corretamente");
				requestDispatcher.forward(request, response);
			}

		} else {
			/* Cria um dispatcher para redirecionar para a p�gina index.jsp */
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
			/* Seta uma msg para aparecer na tela e chama o forward para enviar tudo */
			request.setAttribute("msg", "Informe o login e senha corretamente");
			requestDispatcher.forward(request, response);
		}

	}

}
