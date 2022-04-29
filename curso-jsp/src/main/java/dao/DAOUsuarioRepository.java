package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import connection.SingleConnectionBanco;
import model.ModelLogin;

public class DAOUsuarioRepository {

	private Connection connection;

	public DAOUsuarioRepository() {
		connection = SingleConnectionBanco.getConnection();
	}

	public void gravarUsuario(ModelLogin obj) throws SQLException {
		String sql = "INSERT INTO model_login(login, senha, nome, email)VALUES (?, ?, ?, ?)";
		PreparedStatement preparedStatement;

		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, obj.getLogin());
		preparedStatement.setString(2, obj.getSenha());
		preparedStatement.setString(3, obj.getNome());
		preparedStatement.setString(4, obj.getEmail());

		preparedStatement.execute();
		connection.commit();

	}

}
