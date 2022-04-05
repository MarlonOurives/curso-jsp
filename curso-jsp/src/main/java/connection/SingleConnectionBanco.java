package connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class SingleConnectionBanco {

	private static String banco = "jdbc:postgresql://localhost:5432/curso-jsp?autoReconnect=true";
	private static String user = "postgres";
	private static String senha = "root";
	private static Connection connection = null;
	
	public static Connection getConnection() {
		return connection;
	}
	
	/*Quando chamar a classe diretamente invoca o m�todo tamb�m*/
	static {
		conectar();
	}
	
	/*Quando instanciar vai conectar*/
	public SingleConnectionBanco() {
		conectar();
	}
	
	private static void conectar() {
		try {
			if(connection == null ) {
				/*Carrega o Drive de conex�o do banco*/
				Class.forName("org.postgresql.Driver");
				connection = DriverManager.getConnection(banco, user, senha);
				/*N�o efetua altera��es sem comando*/
				connection.setAutoCommit(false);
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
