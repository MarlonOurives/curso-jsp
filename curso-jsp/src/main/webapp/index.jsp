<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Curso de JSP</title>
</head>
<body>

	<h1>Login</h1>
	<h4 style="color: red;">${msg}</h4>
	<form action="ServletLogin" method="post">
	
		<table>
			<tr>
				<td><label>Login: </label> <input name="login" type="text"></td>
			</tr>
			<tr>
				<td><label>Senha: </label> <input name="senha" type="password"></td>
			</tr>
			<tr>
				<td><button type="submit">Enviar</button></td>
			</tr>
		</table>

	</form>

</body>
</html>