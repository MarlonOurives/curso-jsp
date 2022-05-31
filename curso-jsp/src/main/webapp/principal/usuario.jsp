<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<!DOCTYPE html>
<html lang="en">


<jsp:include page="head.jsp"></jsp:include>

<body>
	<!-- Pre-loader start -->

	<jsp:include page="theme-loader.jsp"></jsp:include>

	<!-- Pre-loader end -->
	<div id="pcoded" class="pcoded">
		<div class="pcoded-overlay-box"></div>
		<div class="pcoded-container navbar-wrapper">

			<jsp:include page="navbar.jsp"></jsp:include>

			<div class="pcoded-main-container">
				<div class="pcoded-wrapper">

					<jsp:include page="navbarmainmenu.jsp"></jsp:include>

					<div class="pcoded-content">
						<!-- Page-header start -->

						<jsp:include page="pageheader.jsp"></jsp:include>
						<!-- Page-header end -->
						<div class="pcoded-inner-content">
							<!-- Main-body start -->
							<div class="main-body">
								<div class="page-wrapper">
									<!-- Page-body start -->
									<div class="page-body">

										<div class="row">
											<div class="col-sm-12">
												<!-- Basic Form Inputs card start -->
												<div class="card">
													<div class="card-block">
														<h4 class="sub-title">Cadastro de Usu�rio</h4>
														<form class="form-material"
															action="<%=request.getContextPath()%>/ServletUsuarioController"
															method="post" id="formUser">

															<input type="hidden" name="acao" id="acao" value="">

															<div class="form-group form-default form-static-label">
																<input type="text" name="id" id="id" readonly="readonly"
																	value="${modelLogin.id}" class="form-control">
																<span class="form-bar"></span> <label
																	class="float-label">ID:</label>
															</div>

															<div class="form-group form-default form-static-label">
																<input type="text" name="nome" id="nome"
																	autocomplete="off" value="${modelLogin.nome}"
																	class="form-control" required="required"> <span
																	class="form-bar"></span> <label class="float-label">Nome:</label>
															</div>

															<div class="form-group form-default form-static-label">
																<input type="email" name="email" id="email"
																	autocomplete="off" value="${modelLogin.email}"
																	class="form-control" required="required"> <span
																	class="form-bar"></span> <label class="float-label">E-mail:</label>
															</div>
															<div class="form-group form-default form-static-label">
																<input type="text" name="login" id="login"
																	autocomplete="off" value="${modelLogin.login}"
																	class="form-control" required="required"> <span
																	class="form-bar"></span> <label class="float-label">Login:</label>
															</div>
															<div class="form-group form-default form-static-label">
																<input type="password" name="senha" id="senha"
																	autocomplete="off" value="${modelLogin.senha}"
																	class="form-control" required="required"> <span
																	class="form-bar"></span> <label class="float-label">Senha:</label>
															</div>


															<button class="btn btn-primary waves-effect waves-light">Salvar</button>

															<button type="button"
																class="btn btn-danger waves-effect waves-light"
																onclick="deleteComAjax();">Excluir</button>
															<button type="button" class="btn btn-success"
																data-toggle="modal" data-target="#modalUsuario">
																Pesquisar Usu�rio</button>
															<button type="button"
																class="btn btn-secondary waves-effect waves-light"
																onclick="limparForm();">Limpar Formul�rio</button>
														</form>

													</div>
												</div>
											</div>
										</div>
										<span id="msg">${msg}</span>

									</div>
									<!-- Page-body end -->
								</div>
								<div id="styleSelector"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="javascriptfile.jsp"></jsp:include>

	<!-- Modal -->
	<div class="modal fade" id="modalUsuario" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="input-group mb-3">
						<input type="text" class="form-control" placeholder="Nome"
							id="nomeBusca" aria-label="Nome" aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-outline-info" type="button"
								onclick="buscarUsuario();">Buscar</button>
						</div>
					</div>
				</div>
				<div style="height: 300px; overflow: scroll;">
					<span id="totalresultados"></span>

					<table class="table" id="tabelaresultados">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Nome</th>
								<th scope="col">Visualizar</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Fechar</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function buscarUsuario() {
			var nomeBusca = document.getElementById('nomeBusca').value;
			if (nomeBusca != null && nomeBusca != '' && nomeBusca.trim() != '') {
				var urlAction = document.getElementById('formUser').action;

				$
						.ajax(
								{

									method : "get",
									url : urlAction,
									data : "nomeBusca=" + nomeBusca
											+ '&acao=buscarUserAjax',
									success : function(response) {
										var json = JSON.parse(response);
										$('#tabelaresultados > tbody > tr')
												.remove();
										for (var p = 0; p < json.length; p++) {
											$('#tabelaresultados > tbody')
													.append(
															'<tr><td>'
																	+ json[p].id
																	+ '</td> <td>'
																	+ json[p].nome
																	+ '</td> <td> <button type="button" class="btn btn-info">Ver Informa��es</button></td><tr>')
										}
										document
												.getElementById('totalresultados').textContent = 'Resultados: '
												+ json.length;
									}

								}).fail(
								function(xhr, status, errorThrown) {
									alert('Erro ao buscar usu�rio por nome: '
											+ xhr.responseText);
								});
			}
		}

		function deleteComAjax() {
			if (confirm('Deseja excluir o usu�rio?')) {

				var urlAction = document.getElementById('formUser').action;
				var idUser = document.getElementById('id').value;

				$.ajax({

					method : "get",
					url : urlAction,
					data : "id=" + idUser + '&acao=deletarajax',
					success : function(response) {

						limparForm();
						document.getElementById('msg').textContent = response;
					}

				}).fail(
						function(xhr, status, errorThrown) {
							alert('Erro ao deletar usu�rio por id: '
									+ xhr.responseText);
						});

			}
		}

		function criarDelete() {
			if (confirm("Deseja excluir o usu�rio?")) {
				document.getElementById("formUser").method = 'get';
				document.getElementById("acao").value = 'deletar';
				document.getElementById("formUser").submit();
			}
		}

		function limparForm() {

			var elementos = document.getElementById("formUser").elements;

			for (p = 0; p < elementos.length; p++) {
				elementos[p].value = '';
			}
		}
	</script>
</body>

</html>

