<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.productos.negocio.*" %>
<%
    String idStr = request.getParameter("id");
    String nombreStr = request.getParameter("nombre");
    String confirmado = request.getParameter("confirmado");
    String cantidadBorrarStr = request.getParameter("cantidad_borrar");
    String mensaje = null;
    int id = -1;
    String nombreProducto = null;
    int cantidadBorrar = 1;

    // Si solo se recibe el nombre, buscar el id correspondiente
    if ((idStr == null || idStr.isEmpty()) && nombreStr != null && !nombreStr.isEmpty()) {
        Producto producto = new Producto();
        String sql = "SELECT id_pr, nombre_pr FROM tb_producto WHERE nombre_pr = ?";
        com.productos.datos.Conexion con = new com.productos.datos.Conexion();
        try {
            java.sql.PreparedStatement ps = con.getConexion().prepareStatement(sql);
            ps.setString(1, nombreStr);
            java.sql.ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                idStr = String.valueOf(rs.getInt("id_pr"));
                nombreProducto = rs.getString("nombre_pr");
            }
            rs.close();
            ps.close();
            con.getConexion().close();
        } catch (Exception e) {
            mensaje = "Error al buscar producto: " + e.getMessage();
        }
    }

    if (idStr != null && !idStr.isEmpty()) {
        id = Integer.parseInt(idStr);
        // Buscar el nombre del producto si no se tiene aún
        if (nombreProducto == null || nombreProducto.isEmpty()) {
            try {
                String sql = "SELECT nombre_pr FROM tb_producto WHERE id_pr = ?";
                com.productos.datos.Conexion con = new com.productos.datos.Conexion();
                java.sql.PreparedStatement ps = con.getConexion().prepareStatement(sql);
                ps.setInt(1, id);
                java.sql.ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    nombreProducto = rs.getString("nombre_pr");
                }
                rs.close();
                ps.close();
                con.getConexion().close();
            } catch (Exception e) {
                nombreProducto = "";
            }
        }
    }

    if (cantidadBorrarStr != null) {
        try {
            cantidadBorrar = Integer.parseInt(cantidadBorrarStr);
            if (cantidadBorrar < 1) cantidadBorrar = 1;
        } catch (Exception e) {
            cantidadBorrar = 1;
        }
    }

    if (id > 0 && "si".equals(confirmado)) {
        try {
            Producto producto = new Producto();
            boolean ok = true;
            for (int i = 0; i < cantidadBorrar; i++) {
                ok = ok && producto.disminuirCantidad(id);
            }
            if (ok) {
                mensaje = "Cantidad del producto rebajada correctamente.";
                // Registrar en auditoría
                HttpSession sesion = request.getSession(false);
                String usuario = (sesion != null) ? (String) sesion.getAttribute("usuario") : null;
                if (usuario != null) {
                    try {
                        com.productos.datos.Conexion conAud = new com.productos.datos.Conexion();
                        String sqlAud = "INSERT INTO auditoria.tb_auditoria (usuario, accion, tabla, fecha_hora) VALUES (?, ?, ?, NOW())";
                        java.sql.PreparedStatement psAud = conAud.getConexion().prepareStatement(sqlAud);
                        psAud.setString(1, usuario);
                        psAud.setString(2, "ELIMINAR");
                        psAud.setString(3, "tb_producto");
                        psAud.executeUpdate();
                        psAud.close();
                        conAud.getConexion().close();
                    } catch(Exception ex) {
                        // Ignorar error de auditoría
                    }
                }
            } else {
                mensaje = "No se pudo rebajar la cantidad (puede que ya esté en 0 o el ID no exista).";
            }
        } catch (Exception e) {
            mensaje = "Error al rebajar cantidad: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Producto</title>
    <link rel="icon" href="iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
</head>
<body>
    <div class="container-eliminar">
        <h1>Eliminar Producto</h1>
        <% if (mensaje != null) { %>
            <div class="<%= mensaje.contains("correctamente") ? "success" : "error" %>"><%= mensaje %></div>
            <a href="gestionProductos.jsp">Volver a la gestión de productos</a>
        <% } else if (id > 0) { %>
            <form method="post">
                <input type="hidden" name="id" value="<%= id %>">
                <p>
                    ¿Está seguro que desea rebajar la cantidad del producto?<br>
                    <b>ID:</b> <%= id %><br>
                    <b>Nombre:</b> <%= (nombreProducto != null ? nombreProducto : "") %>
                </p>
                <label for="cantidad_borrar">Cantidad a rebajar:</label>
                <input type="number" name="cantidad_borrar" id="cantidad_borrar" min="1" value="1" required>
                <br><br>
                <button type="submit" name="confirmado" value="si">Sí, rebajar cantidad</button>
                <a href="gestionProductos.jsp">Cancelar</a>
            </form>
        <% } else { %>
            <form method="get">
                <p>Ingrese el <b>ID</b> o el <b>nombre</b> del producto que desea rebajar:</p>
                <input type="text" name="id" placeholder="ID de producto">
                <span style="margin:0 10px;">o</span>
                <input type="text" name="nombre" placeholder="Nombre de producto">
                <button type="submit">Buscar</button>
            </form>
            <div class="error">Debe especificar el ID o el nombre del producto.</div>
            <a href="gestionProductos.jsp">Volver</a>
        <% } %>
    </div>
</body>
</html>