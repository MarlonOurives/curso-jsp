<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro de Produto</title>
<link rel="stylesheet" href="resources/css/cadastroProduto.css">
<link rel="stylesheet" href="resources/css/padrao.css">


</head>
<body>
<a href="index.jsp" class="sair">Sair</a>

<a href="acessoliberado.jsp" class="inicio">Início</a>
	<h3 style="color: red; text-align: center;">${msg}</h3>

	<form action="salvarProduto" method="post" id="formUser"
		onsubmit="return validarCampos() ? true : false;">
		<ul class="form-style-1">
			<li>
				<table>
					<tr>

						<td>Codigo:</td>
						<td><input autocomplete="off" class="field-long" type="text"
							id="id" name="id" aria-label="id" value="${prod.id}"
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td>Nome:</td>
						<td><input autocomplete="off" class="field-long" type="text"
							id="nome" name="nome" aria-label="nome" value="${prod.nome}" />
						</td>
					</tr>

					<tr>
						<td>Quantidade:</td>
						<td><input autocomplete="off" class="field-long"
							type="number" id="quantidade" name="quantidade"
							aria-label="quantidade" value="${prod.quantidade}" /></td>
					</tr>

					<tr>
						<td>Valor:</td>
						<td><input autocomplete="off" class="field-long"
							type="number" id="valor" name="valor" aria-label="valor"
							value="${prod.valor}" /></td>
					</tr>

					<tr>
						<td></td>
						<td><input type="submit" id="submit" name="submit"
							aria-label="Salvar" value="Salvar" /> <input type="submit"
							id="cancelar" name="cancelar" aria-label="Cancelar"
							value="cancelar"
							onclick="document.getElementById('formUser').action = 'salvarProduto?acao=reset'" />
						</td>
					</tr>
				</table>
			</li>
		</ul>
	</form>


	<div class="container">
		<table class="responsive-table">
			<caption>Produtos Cadastrados</caption>
			<tbody>
				<tr>
					<th scope="col">Código</th>
					<th scope="col">Nome</th>
					<th scope="col">Quantidade</th>
					<th scope="col">Valor</th>
					<th scope="col">Editar</th>
					<th scope="col">Excluir</th>
				</tr>
				<c:forEach items="${produtos}" var="prod">
					<tr>
						<td class="color-td"><c:out value="${prod.id}" /></td>
						<td class="color-td"><c:out value=" ${prod.nome}" /></td>

						<td class="color-td"><c:out value="${prod.quantidade}"></c:out></td>
						<td class="color-td"><c:out value="${prod.valor}"></c:out></td>

						<td class="color-td"><a
							href="salvarProduto?acao=editar&prod=${prod.id}"><img
								alt="Editar" title="Editar" src="resources/img/editar.png"
								width="20px" height="20px"></a></td>

						<td class="color-td"><a
							href="salvarProduto?acao=delete&prod=${prod.id}"><img
								alt="Excluir" title="Excluir" src="resources/img/excluir.jpeg"
								width="20px" height="20px"></a></td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>
	<script type="text/javascript">
		function validarCampos() {
			if (document.getElementById("nome").value == '') {
				alert('Informe o nome');
				return false;
			} else if (document.getElementById("quantidade").value == '') {
				alert('Informe a quantidade');
				return false;
			} else if (document.getElementById("valor").value == '') {
				alert('Informe o valor');
				return false;
			}
			return true;
		}
	</script>
</body>
</html>
