<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro de Usuário</title>
<link rel="stylesheet" href="resources/css/cadastroUsuario.css">
</head>
<body>
	<h3 style="color: red; text-align: center;">${msg}</h3>

	<form action="salvarUsuario" method="post" id="formUser"
		onsubmit="return validarCampos() ? true : false;">
		<ul class="form-style-1">
			<li>
				<table>
					<tr>

						<td>Codigo:</td>
						<td><input autocomplete="off" class="field-long" type="text"
							id="id" name="id" aria-label="id" value="${user.id}" /></td>
					</tr>
					<tr>
						<td>Login:</td>
						<td><input autocomplete="off" class="field-long" type="text"
							id="login" name="login" aria-label="login" value="${user.login}" />
						</td>
					</tr>

					<tr>
						<td>Senha:</td>
						<td><input autocomplete="off" class="field-long"
							type="password" id="senha" name="senha" aria-label="senha"
							value="${user.senha}" /></td>
					</tr>

					<tr>
						<td>Nome:</td>
						<td><input autocomplete="off" class="field-long" type="text"
							id="nome" name="nome" aria-label="nome" value="${user.nome}" /></td>
					</tr>
					<tr>
						<td>Telefone:</td>
						<td><input autocomplete="off" class="field-long" type="text"
							maxlength="20" id="telefone" name="telefone"
							aria-label="telefone" value="${user.telefone}" /></td>
					</tr>

					<tr>
						<td></td>
						<td><input type="submit" id="submit" name="submit"
							aria-label="Salvar" value="Salvar" /> <input type="submit"
							id="cancelar" name="cancelar" aria-label="Cancelar"
							value="cancelar"
							onclick="document.getElementById('formUser').action = 'salvarUsuario?acao=reset'" />
						</td>
					</tr>
				</table>
			</li>
		</ul>
	</form>


	<div class="container">
		<table class="responsive-table">
			<caption>Usuarios Cadastrados</caption>
			<tbody>
				<tr>
					<th scope="col">Código</th>
					<th scope="col">Login</th>
					<th scope="col">Nome</th>
					<th scope="col">Telefone</th>
					<th scope="col">Editar</th>
					<th scope="col">Excluir</th>
				</tr>
				<c:forEach items="${usuarios}" var="user">
					<tr>
						<td class="color-td"><c:out value="${user.id}" /></td>
						<td class="color-td"><c:out value=" ${user.login}" /></td>

						<td class="color-td"><c:out value="${user.nome}"></c:out></td>
						<td class="color-td"><c:out value="${user.telefone}"></c:out>
						</td>

						<td class="color-td"><a
							href="salvarUsuario?acao=editar&user=${user.id}"><img
								alt="Editar" title="Editar" src="resources/img/editar.png"
								width="20px" height="20px"></a></td>

						<td class="color-td"><a
							href="salvarUsuario?acao=delete&user=${user.id}"><img
								alt="Excluir" title="Excluir" src="resources/img/excluir.jpeg"
								width="20px" height="20px"></a></td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>
	<script type="text/javascript">
		function validarCampos() {
			if (document.getElementById("login").value == '') {
				alert('Informe o login');
				return false;
			} else if (document.getElementById("senha").value == '') {
				alert('Informe a senha');
				return false;
			} else if (document.getElementById("nome").value == '') {
				alert('Informe o nome');
				return false;
			} else if (document.getElementById("telefone").value == '') {
				alert('Informe o telefone');
				return false;
			}
			return true;
		}
	</script>

</body>
</html>
