<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.productos.negocio.*,java.util.*,com.productos.datos.Conexion" %>
<%
    String idStr = request.getParameter("id");
    Producto producto = new Producto();
    boolean actualizado = false;
    String mensaje = null;

    if (idStr != null) {
        int id = Integer.parseInt(idStr);

        // Obtener usuario de sesión para auditoría
        HttpSession sesion = request.getSession(false);
        String usuario = (sesion != null) ? (String) sesion.getAttribute("usuario") : null;

        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("actualizar") != null) {
            String nombre = request.getParameter("nombre");
            String precioStr = request.getParameter("precio");
            String cantidadStr = request.getParameter("cantidad");
            String categoriaStr = request.getParameter("categoria");
            double precio = 0;
            int cantidad = 0;
            int categoria = 0;
            try {
                precio = Double.parseDouble(precioStr);
                cantidad = Integer.parseInt(cantidadStr);
                categoria = Integer.parseInt(categoriaStr);
                // Actualizar producto (incluyendo cantidad)
                String sql = "UPDATE tb_producto SET nombre_pr=?, precio_pr=?, cantidad_pr=?, id_cat=? WHERE id_pr=?";
                com.productos.datos.Conexion con = new com.productos.datos.Conexion();
                java.sql.PreparedStatement ps = con.getConexion().prepareStatement(sql);
                ps.setString(1, nombre);
                ps.setDouble(2, precio);
                ps.setInt(3, cantidad);
                ps.setInt(4, categoria);
                ps.setInt(5, id);
                int filas = ps.executeUpdate();
                ps.close();
                con.getConexion().close();
                actualizado = filas > 0;
                mensaje = actualizado ? "Producto actualizado correctamente." : "No se pudo actualizar el producto.";
                // Registrar en auditoría si fue exitoso
                if (actualizado && usuario != null) {
                    try {
                        com.productos.datos.Conexion conAud = new com.productos.datos.Conexion();
                        String sqlAud = "INSERT INTO auditoria.tb_auditoria (usuario, accion, tabla, fecha_hora) VALUES (?, ?, ?, NOW())";
                        java.sql.PreparedStatement psAud = conAud.getConexion().prepareStatement(sqlAud);
                        psAud.setString(1, usuario);
                        psAud.setString(2, "ACTUALIZAR");
                        psAud.setString(3, "tb_producto");
                        psAud.executeUpdate();
                        psAud.close();
                        conAud.getConexion().close();
                    } catch(Exception ex) {
                        // Ignorar error de auditoría
                    }
                }
            } catch (Exception e) {
                mensaje = "Error al actualizar: " + e.getMessage();
            }
        }

        
        producto.buscarPorId(id);
        // Obtener cantidad actual
        int cantidadActual = 0;
        try {
            String sql = "SELECT cantidad_pr FROM tb_producto WHERE id_pr=" + id;
            com.productos.datos.Conexion con = new com.productos.datos.Conexion();
            java.sql.ResultSet rs = con.Consulta(sql);
            if (rs.next()) {
                cantidadActual = rs.getInt("cantidad_pr");
            }
            rs.close();
            con.getConexion().close();
        } catch (Exception e) {
            cantidadActual = 0;
        }
        request.setAttribute("cantidadActual", cantidadActual);
    }
%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Actualizar Producto</title>
    <link rel="icon" href="iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
</head>
<body>

    <div class="container-actualizar">
        <h1>Actualizar Producto</h1>
        <% if (mensaje != null) { %>
            <div class="<%= actualizado ? "mensaje-actualizar" : "error-actualizar" %>"><%= mensaje %></div>
            <div style="text-align:center;">
                <a href="gestionProductos.jsp">Volver a la gestión de productos</a>
            </div>
        <% } else if (idStr != null) { %>
            <form method="post" class="form-actualizar">
                <input type="hidden" name="id" value="<%= idStr %>">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre" value="<%= producto.getNombre() %>" required>
                <label for="precio">Precio:</label>
                <input type="number" id="precio" name="precio" step="0.01" value="<%= producto.getPrecio() %>" required>
                <label for="cantidad">Cantidad:</label>
                <input type="number" id="cantidad" name="cantidad" min="0" value="<%= request.getAttribute("cantidadActual") != null ? request.getAttribute("cantidadActual") : "" %>" required>
                <label for="categoria">Categoría:</label>
                <select name="categoria" id="categoria" required>
                    <%
                        Categoria c = new Categoria();
                        List<Map<String, Object>> categorias = c.obtenerTodas();
                        int idCatActual = producto.getIdCategoria();
                        for (Map<String, Object> cat : categorias) {
                            int idCat = (Integer) cat.get("id_cat");
                            String nombreCat = (String) cat.get("descripcion_cat");
                    %>
                        <option value="<%= idCat %>" <%= (idCat == idCatActual ? "selected" : "") %>><%= nombreCat %></option>
                    <%
                        }
                    %>
                </select>
                <div class="actions">
                    <input type="submit" name="actualizar" value="Actualizar">
                    <a href="gestionProductos.jsp">Cancelar</a>
                </div>
            </form>
        <% } else { %>
            <div class="error-actualizar">ID de producto no especificado.</div>
            <div style="text-align:center;">
                <a href="gestionProductos.jsp">Volver</a>
            </div>
        <% } %>
    </div>
    
    
</body>
</html>