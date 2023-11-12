/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import debug.Console;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author sortizu
 */
public class Conexion {
    static String usuario = "root";
    static String clave = "1234";
    static String url = "jdbc:mysql://localhost:3306/event_page";
    public static Connection con;
    public static Statement stmt;
    public static ResultSet rs;
        
        public static void conectar(){
        
            try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        try {
            con = DriverManager.getConnection(url,usuario,clave);
            stmt = con.createStatement();
            /*stmt.executeUpdate("INSERT INTO usuario (nombres, apellidos, dni, correo, contraseña, admin) VALUES ('3', 'Maria Mendez')");
            rs = stmt.executeQuery("SELECT * FROM usuario");
            rs.next();
            do{
                System.out.println(rs.getString("id")+" "+rs.getString("nombre"));
                
            } while (rs.next());*/
        } catch (SQLException ex) {
            Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
        }
        }
        
        public static Connection getConnection(){
            if (con==null){
                conectar();
            }
            return con;
        }
        
    
}
