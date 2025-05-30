<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.productos.negocio.* , com.productos.seguridad.*"%>
<%
String usuario;
HttpSession sesion = request.getSession();
String mensaje = null;
String error = null;

if (sesion.getAttribute("usuario") == null) {
%>
<jsp:forward page="login.jsp">
	<jsp:param name="error" value="Debe registrarse en el sistema." />
</jsp:forward>
<%
} else {
	usuario = (String) sesion.getAttribute("usuario");
	int perfil = (Integer) sesion.getAttribute("perfil");

	// Procesar cambio de clave si se envió el formulario
	if ("POST".equalsIgnoreCase(request.getMethod())) {
		String claveActual = request.getParameter("claveActual");
		String nuevaClave = request.getParameter("nuevaClave");
		String repetirClave = request.getParameter("repetirClave");
		String correo = null;

		// Obtener el correo del usuario actual
		try {
			Usuario user = new Usuario();
			// Buscar correo por nombre de usuario
			String sql = "SELECT correo_us FROM tb_usuario WHERE nombre_us = ?";
			com.productos.datos.Conexion con = new com.productos.datos.Conexion();
			java.sql.PreparedStatement ps = con.getConexion().prepareStatement(sql);
			ps.setString(1, usuario);
			java.sql.ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				correo = rs.getString("correo_us");
			}
			rs.close();
			ps.close();
			con.getConexion().close();

			if (correo != null) {
				user.setCorreo(correo);

				// Validar y cambiar clave
				boolean ok = user.cambiarClave(claveActual, nuevaClave, repetirClave);
				if (ok) {
					mensaje = "Clave cambiada correctamente.";
				} else {
					error = "No se pudo cambiar la clave. Verifique la clave actual y los requisitos de la nueva clave.";
				}
			} else {
				error = "No se pudo identificar el usuario para cambiar la clave.";
			}
		} catch (Exception e) {
			error = "Error al cambiar la clave: " + e.getMessage();
		}
	}
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Raiz Urbana</title>
    <link rel="icon" href= "iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
</head>
<body>
    <div class="container-cambio">
        <h1>Cambio de clave (<%= usuario %>)</h1>
        <% if (mensaje != null) { %>
            <div class="mensaje-cambio"><%= mensaje %></div>
        <% } %>
        <% if (error != null) { %>
            <div class="error-cambio"><%= error %></div>
        <% } %>
        <form action="cambioClave.jsp" method="post" class="form-cambio">
            <label for="claveActual">Contraseña actual:</label>
            <input type="password" id="claveActual" name="claveActual" required>
            <label for="nuevaClave">Nueva Contraseña:</label>
            <input type="password" id="nuevaClave" name="nuevaClave" required>
            <label for="repetirClave">Confirmar Nueva Contraseña:</label>
            <input type="password" id="repetirClave" name="repetirClave" required>
            <div class="actions">
            <nav>
                <input type="reset" value="Cancelar">
               
                <input type="submit" value="Cambio de Clave">
                </nav>
            </div>
        </form>
        <nav>
        <div style="text-align:center; margin-top:18px;">
            <a href="menu.jsp" style="color:#21618C; text-decoration:underline;">Volver al menú</a>
        </div>
        </nav>
    </div>
</body>
</html>
<%
}
%>