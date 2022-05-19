package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import connection.SingleConnectionBanco;
import model.ModelLogin;

public class DAOUsuarioRepository {

	private Connection connection;

	public DAOUsuarioRepository() {
		connection = SingleConnectionBanco.getConnection();
	}

	public ModelLogin gravarUsuario(ModelLogin obj) throws SQLException {
		
		if(obj.isNovo()) {
			
		
		String sql = "INSERT INTO model_login(login, senha, nome, email)VALUES (?, ?, ?, ?)";
		PreparedStatement preparedStatement;

		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, obj.getLogin());
		preparedStatement.setString(2, obj.getSenha());
		preparedStatement.setString(3, obj.getNome());
		preparedStatement.setString(4, obj.getEmail());

		preparedStatement.execute();
		connection.commit();
		}else {
			String sql = "UPDATE MODEL_LOGIN SET LOGIN = ?, SENHA = ?, NOME = ?, EMAIL = ? WHERE ID = "+obj.getId()+"";
			PreparedStatement preparedStatement;
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, obj.getLogin());
			preparedStatement.setString(2, obj.getSenha());
			preparedStatement.setString(3, obj.getNome());
			preparedStatement.setString(4, obj.getEmail());
			preparedStatement.executeUpdate();
			connection.commit();

		}
		return this.consultaUsuario(obj.getLogin());

	}

	public ModelLogin consultaUsuario(String login) throws SQLException {
		ModelLogin modelLogin = new ModelLogin();
		String sql = "SELECT * FROM model_login WHERE upper(login) = upper(?)";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, login);

		ResultSet resultSet = preparedStatement.executeQuery();
		while (resultSet.next()) {
			modelLogin.setId(resultSet.getLong("id"));
			modelLogin.setNome(resultSet.getString("nome"));
			modelLogin.setEmail(resultSet.getString("email"));
			modelLogin.setLogin(resultSet.getString("login"));
			modelLogin.setSenha(resultSet.getString("senha"));

		}
		return modelLogin;
	}

	public boolean validarLogin(String login) throws Exception {
		String sql = "SELECT COUNT(1) > 0 as existe FROM MODEL_LOGIN WHERE UPPER(LOGIN) = UPPER('"+login+"')";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		ResultSet resultSet = preparedStatement.executeQuery();
		
		resultSet.next();
		return resultSet.getBoolean("existe");
		
	}
	
	public void deletarUser(String idUser) throws SQLException {
		String sql = "DELETE FROM model_login WHERE id = ?";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setLong(1, Long.parseLong(idUser));
		preparedStatement.executeUpdate();
		connection.commit();
		
	}

}
