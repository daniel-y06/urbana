package com.productos.negocio;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.productos.datos.Conexion;

public class Producto {

    // Atributos para el carrito
    private int idProducto;
    private String nombre;
    private double precio;
    private int idCategoria;

    public String buscarProductoCategoria(int cat) {
        String sentencia = "SELECT nombre_pr, precio_pr FROM tb_producto WHERE id_cat = " + cat;
        Conexion con = new Conexion();
        ResultSet rs = null;
        String resultado = "<table border='3'><tr><th>Producto</th><th>Precio</th></tr>";

        try {
            rs = con.Consulta(sentencia);
            while (rs.next()) {
                resultado += "<tr><td>" + rs.getString(1) + "</td>"
                           + "<td>" + rs.getDouble(2) + "</td></tr>";
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }

        resultado += "</table>";
        System.out.print(resultado); // Imprime en consola (útil para depuración)
        return resultado;
    }
    
    public String consultarTodo()
    {
    String sql="SELECT * FROM tb_producto ORDER BY id_pr";
    Conexion con=new Conexion();
    String tabla="<table border=2><th>ID</th><th>Producto</th><th>Cantidad</th><th>Precio</th>";
    ResultSet rs=null;
    rs=con.Consulta(sql);
    try {
    while(rs.next())
    {
    tabla+="<tr><td>"+rs.getInt(1)+"</td>"
    + "<td>"+rs.getString(3)+"</td>"
    + "<td>"+rs.getInt(4)+"</td>"
    + "<td>"+rs.getDouble(5)+"</td>"
    + "</td></tr>";
    }
    } catch (SQLException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
    System.out.print(e.getMessage());
    }
    tabla+="</table>";
    return tabla;
    }
    
    public String reporteProducto() {
        String sql="SELECT pr.id_pr, pr.nombre_pr, cat.descripcion_cat, pr.cantidad_pr, pr.precio_pr "
                + "FROM tb_producto pr, tb_categoria cat WHERE pr.id_cat=cat.id_cat";
        Conexion con=new Conexion();
        String tabla="<table class=table><thead><tr>"
                + "<th scope=\"col\">ID</th>"
                + "<th scope=\"col\">Descripción</th>"
                + "<th scope=\"col\">Categoría</th>"
                + "<th scope=\"col\">Cantidad</th>"
                + "<th scope=\"col\">Precio</th>"
                + "<th scope=\"col\">Modificar</th>"
                + "<th scope=\"col\">Eliminar</th>"
                + "</tr></thead><tbody>";
        ResultSet rs=null;
        rs=con.Consulta(sql);
        try {
            while(rs.next())
            {
                tabla+="<tr>"
                + "<th scope=\"row\">"+rs.getInt(1)+"</th>"
                + "<td>"+rs.getString(2)+"</td>"
                + "<td>"+rs.getString(3)+"</td>"
                + "<td>"+rs.getInt(4)+"</td>"
                + "<td>"+rs.getDouble(5)+"</td>"
                + "<td><a href=actualizar.jsp?id="+rs.getInt(1)+">"
                + "Actualizar</a></td>"
                + "<td><a href=eliminar.jsp?id="+rs.getInt(1)+">"
                + "Eliminar</a></td>"
                + "</tr>";
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        tabla+="</tbody></table>";
        return tabla;
    }
    
    
    public String eliminarProductos( String id )
    {
    	String sql="DELETE FROM tb_producto"
    			+ "WHERE id_pr=" + id;
    	Conexion con=new Conexion ();
    	String msg =con.Ejecutar(sql);
    	return msg;
    	
    }

    // Obtener todos los productos como lista
    public List<Producto> obtenerTodos() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT id_pr, nombre_pr, precio_pr, id_cat FROM tb_producto";
        Conexion con = new Conexion();
        ResultSet rs = null;
        rs = con.Consulta(sql);
        try {
            while (rs.next()) {
                Producto p = new Producto();
                p.idProducto = rs.getInt("id_pr");
                p.nombre = rs.getString("nombre_pr");
                p.precio = rs.getDouble("precio_pr");
                p.idCategoria = rs.getInt("id_cat");
                lista.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Cargar datos de producto por id
    public void buscarPorId(int id) {
        String sql = "SELECT id_pr, nombre_pr, precio_pr, id_cat FROM tb_producto WHERE id_pr=" + id;
        Conexion con = new Conexion();
        ResultSet rs = null;
        rs = con.Consulta(sql);
        try {
            if (rs.next()) {
                this.idProducto = rs.getInt("id_pr");
                this.nombre = rs.getString("nombre_pr");
                this.precio = rs.getDouble("precio_pr");
                this.idCategoria = rs.getInt("id_cat");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Método para insertar un producto (agregar este método)
    public boolean insertarProducto(String nombre, double precio, int idCategoria) {
        String sql = "INSERT INTO tb_producto (nombre_pr, precio_pr, id_cat) VALUES (?, ?, ?)";
        Conexion con = new Conexion();
        try {
            java.sql.PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setDouble(2, precio);
            ps.setInt(3, idCategoria);
            int filas = ps.executeUpdate();
            ps.close();
            con.getConexion().close();
            return filas > 0;
        } catch (Exception e) {
            System.out.println("Error al insertar producto: " + e.getMessage());
            return false;
        }
    }

    // Nuevo método para insertar producto con cantidad
    public boolean insertarProducto(String nombre, int cantidad, double precio, int idCategoria) {
        String sql = "INSERT INTO tb_producto (nombre_pr, cantidad_pr, precio_pr, id_cat) VALUES (?, ?, ?, ?)";
        Conexion con = new Conexion();
        try {
            java.sql.PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setString(1, nombre);
            ps.setInt(2, cantidad);
            ps.setDouble(3, precio);
            ps.setInt(4, idCategoria);
            int filas = ps.executeUpdate();
            ps.close();
            con.getConexion().close();
            return filas > 0;
        } catch (Exception e) {
            System.out.println("Error al insertar producto: " + e.getMessage());
            return false;
        }
    }

    // Corregido: método para disminuir la cantidad de un producto por id
    public boolean disminuirCantidad(int idProducto) {
        String sql = "UPDATE tb_producto SET cantidad_pr = cantidad_pr - 1 WHERE id_pr = ? AND cantidad_pr > 0";
        Conexion con = new Conexion();
        try {
            java.sql.PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, idProducto);
            int filas = ps.executeUpdate();
            ps.close();
            con.getConexion().close();
            return filas > 0;
        } catch (Exception e) {
            System.out.println("Error al disminuir cantidad: " + e.getMessage());
            return false;
        }
    }

    // Rebajar una cantidad específica de un producto (de una sola vez)
    public boolean disminuirCantidad(int idProducto, int cantidad) {
        String sql = "UPDATE tb_producto SET cantidad_pr = cantidad_pr - ? WHERE id_pr = ? AND cantidad_pr >= ?";
        Conexion con = new Conexion();
        try {
            java.sql.PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setInt(1, cantidad);
            ps.setInt(2, idProducto);
            ps.setInt(3, cantidad);
            int filas = ps.executeUpdate();
            ps.close();
            con.getConexion().close();
            return filas > 0;
        } catch (Exception e) {
            System.out.println("Error al disminuir cantidad: " + e.getMessage());
            return false;
        }
    }

    // Getters necesarios
    public int getIdProducto() {
        return idProducto;
    }
    public String getNombre() {
        return nombre;
    }
    public double getPrecio() {
        return precio;
    }
    public int getIdCategoria() {
        return idCategoria;
    }

}
