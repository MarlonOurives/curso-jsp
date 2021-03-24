package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.BeanCursoJsp;
import connection.SingleConnection;
import servlet.Usuario;

public class DaoUsuario {

	private Connection connection;

	public DaoUsuario() {
		connection = SingleConnection.getConnection();
	}

	public void salvarUsuario(BeanCursoJsp usuario) {
		try {
			String sql = "INSERT INTO USUARIO(LOGIN, SENHA, NOME) VALUES (?, ?, ?, ? )";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, usuario.getLogin());
			preparedStatement.setString(2, usuario.getSenha());
			preparedStatement.setString(3, usuario.getNome());
			preparedStatement.setString(4, usuario.getTelefone());
			preparedStatement.execute();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}

		}

	}

	public List<BeanCursoJsp> listar() throws Exception {

		List<BeanCursoJsp> listar = new ArrayList<BeanCursoJsp>();
		String sql = "Select * from usuario";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		ResultSet resultSet = preparedStatement.executeQuery();
		while (resultSet.next()) {

			BeanCursoJsp beanCursoJsp = new BeanCursoJsp();
			beanCursoJsp.setId(resultSet.getLong("id"));
			beanCursoJsp.setLogin(resultSet.getString("login"));
			beanCursoJsp.setSenha(resultSet.getString("senha"));
			beanCursoJsp.setNome(resultSet.getString("nome"));
			beanCursoJsp.setTelefone(resultSet.getString("telefone"));

			listar.add(beanCursoJsp);

		}
		return listar;
	}
	
	public void delete(String id) {
		try {
			String sql = "Delete From usuario where id = '"+ id + "'";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.execute();
			connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		
	
	}

	public BeanCursoJsp consultar(String id)throws Exception {
		String sql = "Select * from usuario where id = '" + id + "'";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		ResultSet resultSet = preparedStatement.executeQuery();
		if(resultSet.next()) {
			BeanCursoJsp beanCursoJsp = new BeanCursoJsp();
			beanCursoJsp.setId(resultSet.getLong("id"));
			beanCursoJsp.setLogin(resultSet.getString("login"));
			beanCursoJsp.setSenha(resultSet.getString("senha"));
			beanCursoJsp.setNome(resultSet.getString("nome"));
			beanCursoJsp.setTelefone(resultSet.getString("telefone"));

			return beanCursoJsp;

		}
		return null;
	}
	public boolean validarLogin(String login)throws Exception {
		String sql = "Select count(1) as qtd from usuario where login = '" + login + "'";
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		ResultSet resultSet = preparedStatement.executeQuery();
		
		if(resultSet.next()) {

			return resultSet.getInt("qtd") <= 0;

		}
		return false;
	}

	public void atualizar(BeanCursoJsp beanCursoJsp) {
		String sql = "update usuario set login = ?, senha = ?, nome = ?, telefone = ?  where id = " + beanCursoJsp.getId();
		PreparedStatement preparedStatement;
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, beanCursoJsp.getLogin());
			preparedStatement.setString(2, beanCursoJsp.getSenha());
			preparedStatement.setString(3, beanCursoJsp.getNome());
			preparedStatement.setString(4, beanCursoJsp.getTelefone());
			

			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		
		
	}
}




