<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro de Usuário</title>
<link rel="stylesheet" href="resources/css/cadastro.css">

</head>
<body>
	<center>
		<h1>Cadastro de usuário</h1>
	</center>
	<form action="salvarUsuario" method="post">
		<table>
			<ul class="form-style-1">
				<li>
					<table>
						<tr>
							<td>Código:</td>
							<td><input type="text" id="id" name="id" value="${user.id }"></td>
						</tr>
						<tr>
						<tr>
							<td>Login:</td>
							<td><input type="text" id="login" name="login"
								value="${user.login }"></td>
						</tr>
						<tr>
							<td>Senha:</td>
							<td><input type="password" id="senha" name="senha"
								value="${user.senha }">
						</tr>
						<tr>
							<td></td>
							<td><input type="submit" value="Salvar"></td>
						</tr>
					</table>
				</li>
			</ul>
	</form>

	<table>
		<div class="container">
			<table class="responsive-table">
				<caption>Cadastrados</caption>
				<c:forEach items="${usuarios}" var="user">
					<tr>
						<td style="width: 150px"><c:out value="${user.id}"></c:out></td>
						<td style="width: 150px"><c:out value="${user.login}"></c:out></td>
						<td><c:out value="${user.senha}"></c:out></td>
						<td><a href="salvarUsuario?acao=delete&user=${user.login }">Excluir</a></td>
						<td><a href="salvarUsuario?acao=editar&user=${user.login }">Editar</a></td>


					</tr>
				</c:forEach>
			</table>
		</div>
</body>
</html>
