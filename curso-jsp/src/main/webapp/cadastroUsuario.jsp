<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro de Usuário</title>
<link rel="stylesheet" href="resources/css/cadastroUsuario.css">
<link rel="stylesheet" href="resources/css/padrao.css">
<!-- Adicionando JQuery -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"
	integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
	crossorigin="anonymous">
	
</script>

</head>
<body>
	<a href="index.jsp" class="sair">Sair</a>

	<a href="acessoliberado.jsp" class="inicio">Início</a>

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

						<td>IBGE:</td>
						<td><input type="text" id="ibge" name="ibge"
							value="${user.ibge}"></td>



					</tr>
					</tr>
					<tr>
						<td>Login:</td>
						<td><input autocomplete="off" class="field-long" type="text"
							id="login" name="login" aria-label="login" value="${user.login}" />
						</td>
						<td>Rua:</td>
						<td><input type="text" id="rua" name="rua"
							value="${user.rua}"></td>

					</tr>

					<tr>
						<td>Senha:</td>
						<td><input autocomplete="off" class="field-long"
							type="password" id="senha" name="senha" aria-label="senha"
							value="${user.senha}" /></td>
						<td>Bairro:</td>
						<td><input type="text" id="bairro" name="bairro"
							value="${user.bairro}"></td>
					</tr>

					<tr>
						<td>Nome:</td>
						<td><input autocomplete="off" class="field-long" type="text"
							id="nome" name="nome" aria-label="nome" value="${user.nome}" /></td>
						<td>Cidade:</td>
						<td><input type="text" id="cidade" name="cidade"
							value="${user.cidade}"></td>
					</tr>
					<tr>
						<td>Telefone:</td>
						<td><input autocomplete="off" class="field-long" type="text"
							maxlength="20" id="telefone" name="telefone"
							aria-label="telefone" value="${user.telefone}" /></td>
						<td>Estado:</td>
						<td><input type="text" id="estado" name="estado"
							value="${user.estado}"></td>
					</tr>
					<tr>
						<td>Cep:</td>
						<td><input type="text" id="cep" name="cep"
							onblur="consultaCep();" value="${user.cep}"></td>
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
					<th scope="col">Cep</th>
					<th scope="col">Rua</th>
					<th scope="col">Bairro</th>
					<th scope="col">Cidade</th>
					<th scope="col">Estado</th>
					<th scope="col">IBGE</th>

					<th scope="col">Editar</th>
					<th scope="col">Excluir</th>
				</tr>
				<c:forEach items="${usuarios}" var="user">
					<tr>
						<td class="color-td"><c:out value="${user.id}" /></td>
						<td class="color-td"><c:out value=" ${user.login}" /></td>

						<td class="color-td"><c:out value="${user.nome}"></c:out></td>
						<td class="color-td"><c:out value="${user.telefone}"></c:out>
						<td class="color-td"><c:out value="${user.cep}"></c:out>
						<td class="color-td"><c:out value="${user.rua}"></c:out>
						<td class="color-td"><c:out value="${user.bairro}"></c:out>
						<td class="color-td"><c:out value="${user.cidade}"></c:out>
						<td class="color-td"><c:out value="${user.estado}"></c:out>
						<td class="color-td"><c:out value="${user.ibge}"></c:out></td>

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

		function consultaCep() {
			var cep = $("#cep").val();

			//Consulta o webservice viacep.com.br/
			$.getJSON("https://viacep.com.br/ws/" + cep + "/json/?callback=?",
					function(dados) {

						if (!("erro" in dados)) {
							//Atualiza os campos com os valores da consulta.
							$("#rua").val(dados.logradouro);
							$("#bairro").val(dados.bairro);
							$("#cidade").val(dados.localidade);
							$("#estado").val(dados.uf);
							$("#ibge").val(dados.ibge);
						} else {
							$("#rua").val('');
							$("#bairro").val('');
							$("#cidade").val('');
							$("#estado").val('');
							$("#ibge").val('');
							//CEP pesquisado não foi encontrado.
							alert("CEP não encontrado.");
						}
					});
		}
	</script>

</body>
</html>
