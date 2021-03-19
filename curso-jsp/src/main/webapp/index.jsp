<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/estilo.css">

</head>
<body>
	<h2>Index</h2>	
		
	<div class="login-page">
		<div class="form">
			<form action="LoginServlet" method="post" class="login-form">
				Login: <input type="text" id="login" name="login"> Senha: <input
					type="password" id="senha" name="senha"> 
					<button type="submit" value="Logar">Logar</button>
			</form>
		</div>
	</div>
</body>
</html>