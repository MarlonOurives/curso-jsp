package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import beans.Produto;
import connection.SingleConnection;

public class DaoProduto {
	
	private Connection connection;
	
	public DaoProduto() {
		connection = SingleConnection.getConnection();
	}
	
	public void salvarProduto(Produto produto) {
		try {
			String sql = "INSERT INTO PRODUTO(NOME, QUANTIDADE, VALOR) VALUES (?, ?, ?)";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, produto.getNome());
			preparedStatement.setDouble(2, produto.getQuantidade());
			preparedStatement.setDouble(3, produto.getValor());
			preparedStatement.execute();
		}catch (Exception e) {
			e.printStackTrace();
			try {
				connection.rollback();
			} catch (SQLException e2) {
				e2.printStackTrace();
			}
		}
	}
	
	public List<Produto> listar() throws Exception{
		List<Produto> listar = new ArrayList<Produto>();
		String sql = "Select * from produto";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		ResultSet resultSet = preparedStatement.executeQuery();
		while (resultSet.next()) {

			Produto produto = new Produto();
			produto.setId(resultSet.getLong("id"));
			produto.setNome(resultSet.getString("nome"));
			produto.setQuantidade(resultSet.getDouble("quantidade"));
			produto.setValor(resultSet.getDouble("valor"));

			listar.add(produto);

		}
		return listar;
	}
	
	public void delete(String id) {
		try {
			String sql = "Delete From produto where id = '"+ id + "'";
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
	public Produto consultar(String id)throws Exception {
		String sql = "Select * from produto where id = '" + id + "'";
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		ResultSet resultSet = preparedStatement.executeQuery();
		if(resultSet.next()) {
			Produto produto = new Produto();
			produto.setId(resultSet.getLong("id"));
			produto.setNome(resultSet.getString("nome"));
			produto.setQuantidade(resultSet.getDouble("quantidade"));
			produto.setValor(resultSet.getDouble("valor"));

			return produto;

		}
		return null;
	}
	public boolean validarNome(String nome)throws Exception {
		String sql = "Select count(1) as qtd from produto where nome = '" + nome + "'";
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		ResultSet resultSet = preparedStatement.executeQuery();
		
		if(resultSet.next()) {

			return resultSet.getInt("qtd") <= 0;

		}
		return false;
	}
	
	public boolean validarProdutoUpdate(String nome, String id)throws Exception {
		String sql = "Select count(1) as qtd from produto where nome = '" + nome + "' and id <> "+ id;
		
		PreparedStatement preparedStatement = connection.prepareStatement(sql);
		ResultSet resultSet = preparedStatement.executeQuery();
		
		if(resultSet.next()) {

			return resultSet.getInt("qtd") <= 0;

		}
		return false;
	}
	public void atualizar(Produto produto) {
		String sql = "update produto set nome = ?, quantidade = ?, valor = ? where id = " + produto.getId();
		PreparedStatement preparedStatement;
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, produto.getNome());
			preparedStatement.setDouble(2, produto.getQuantidade());
			preparedStatement.setDouble(3, produto.getValor());
			

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
