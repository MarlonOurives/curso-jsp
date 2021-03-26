package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.Produto;
import dao.DaoProduto;

@WebServlet("/salvarProduto")
public class ProdutoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	DaoProduto daoProduto = new DaoProduto();

	public ProdutoServlet() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
		try {
			String acao = request.getParameter("acao");
			String prod = request.getParameter("prod");
			if (acao.equalsIgnoreCase("delete")) {

				daoProduto.delete(prod);
				RequestDispatcher view = request.getRequestDispatcher("/cadastroProduto.jsp");
				request.setAttribute("produtos", daoProduto.listar());
				view.forward(request, response);

			} else if (acao.equalsIgnoreCase("editar")) {

				Produto beanProduto = daoProduto.consultar(prod);
				RequestDispatcher view = request.getRequestDispatcher("/cadastroProduto.jsp");
				request.setAttribute("prod", beanProduto);
				view.forward(request, response);

			} else if (acao.equalsIgnoreCase("listartodos")) {

				RequestDispatcher view = request.getRequestDispatcher("/cadastroProduto.jsp");
				request.setAttribute("produtos", daoProduto.listar());
				view.forward(request, response);

			}

		} catch (Exception e) {
			e.printStackTrace();

		}

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String acao = request.getParameter("acao");
		if (acao != null && acao.equalsIgnoreCase("reset")) {
			try {
				RequestDispatcher view = request.getRequestDispatcher("/cadastroProduto.jsp");
				request.setAttribute("produtos", daoProduto.listar());
				view.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			String id = request.getParameter("id");
			String nome = request.getParameter("nome");
			Double quantidade = Double.parseDouble(request.getParameter("quantidade"));
			Double valor = Double.parseDouble(request.getParameter("valor"));

			Produto produto = new Produto();
			produto.setId(!id.isEmpty() ? Long.parseLong(id) : null);
			produto.setNome(nome);
			produto.setQuantidade(quantidade);
			produto.setValor(valor);
			try {

				String msg = null;
				boolean podeInserir = true;

				if (id == null || id.isEmpty() && !daoProduto.validarNome(nome)) {
					msg = "Produto já cadastrado";
					podeInserir = false;
				}

				if (id == null || id.isEmpty() && daoProduto.validarNome(nome)) {

					daoProduto.salvarProduto(produto);

				} else if (id != null && !id.isEmpty()) {
					if (!daoProduto.validarProdutoUpdate(nome, id)) {
						msg = "Produto já cadastrado";
						podeInserir = false;

					} else {
						daoProduto.atualizar(produto);

					}

				}
				if (msg != null) {
					request.setAttribute("msg", msg);
				}
				if (!podeInserir) {
					request.setAttribute("prod", produto);
				}

				RequestDispatcher view = request.getRequestDispatcher("/cadastroProduto.jsp");
				request.setAttribute("produtos", daoProduto.listar());
				view.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

}
