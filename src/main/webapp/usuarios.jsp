<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.seguridad.*"%>
<%
String usuario;
HttpSession sesion = request.getSession();
String mensajeAccion = null;
if (sesion.getAttribute("usuario") == null) 
{
%>
<jsp:forward page="login.jsp">
	<jsp:param name="error" value="Debe registrarse en el sistema." />
</jsp:forward>
<%
} else {
usuario = (String) sesion.getAttribute("usuario"); 
int perfil = (Integer) sesion.getAttribute("perfil");

// Procesar bloqueo/desbloqueo y eliminación antes de mostrar la tabla
String accion = request.getParameter("accion");
String idUsuarioStr = request.getParameter("idUsuario");
String idEliminarStr = request.getParameter("idEliminar");
if ("Bloquear".equals(accion) || "Desbloquear".equals(accion)) {
    if (idUsuarioStr != null) {
        try {
            int idUsuario = Integer.parseInt(idUsuarioStr);
            Usuario userList = new Usuario();
            userList.bloqueoUsuario(idUsuario);
            mensajeAccion = "Usuario bloqueado/desbloqueado con éxito.";
        } catch (Exception ex) {
            mensajeAccion = "Error al bloquear/desbloquear: " + ex.getMessage();
        }
    }
}
if ("Eliminar".equals(accion)) {
    if (idEliminarStr != null) {
        try {
            com.productos.datos.Conexion conDel = new com.productos.datos.Conexion();
            String sqlDel = "DELETE FROM tb_usuario WHERE id_us=" + idEliminarStr;
            conDel.Ejecutar(sqlDel);
            conDel.getConexion().close();
            mensajeAccion = "Usuario eliminado con éxito.";
        } catch (Exception ex) {
            mensajeAccion = "Error al eliminar: " + ex.getMessage();
        }
    }
}
%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Raiz Urbana</title>
    <link rel="icon" href= "iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
</head>
<body id="fondo">
    <main>
        <header>
            <h1>Raiz Urbana</h1>
           
            <h2 class="destacado">Moda casual, urbana y sostenible</h2>
            <h4 id="favorito">Consumir la moda de manera consciente e intencionada para lucir mejor cada día</h4>
        </header>
        <nav>
		<%
		Pagina pag = new Pagina();
		String menu = pag.mostrarMenu(perfil);
		out.print(menu);
		%>
		</nav>

	<section class="opcion">
		<h1>Registro de usuarios (
			<%
		out.println(usuario);
		%>
		)
		</h1>
		<form action="validarRegistro.jsp" method="post" class="card">
		<table border="0" cellpadding="5" cellspacing="5">
			
			<tr>
				<td><label for="nombre">Nombre:</label></td>
				<td><input type="text" id="nombre" name="nombre" required>
				</td>
			</tr>
			
			<tr>
				<td><label for="cedula">Cedula:</label></td>
				<td><input type="text" id="cedula" name="cedula" required>
				</td>
			</tr>
			
			<tr>
				<td><label for="perfil">Perfil:</label></td>
				<td><select id="perfil" name="perfil">
						<%
						Perfil per = new Perfil();
						out.print(per.mostrarPerfil());
						%>
				</select></td>
			</tr>
		
			<tr>
				<td><label for="estado_civil">Estado Civil:</label></td>
				<td><select id="estado_civil" name="estado_civil">
						<%
						EstadoCivil estc = new EstadoCivil();
						out.print(estc.mostrarEstadoCivil());
						%>
				</select></td>
			</tr>
			
			<tr>
				<td><label for="correo">Correo:</label></td>
				<td><input type="email" id="correo" name="correo" required>
				</td>
			</tr>
			
			<tr>
                <td><label for="contrasena">Contraseña:</label></td>
                <td>
					<label for="contrasena-default">654321</label>
					<input type="hidden" id="contrasena" name="contrasena" value="654321" />
				</td>
            </tr>
            
			<tr>
                <td><label for="estado">
                <%
                	String estado = (String) sesion.getAttribute("estado");
                		if (estado != null) {
                		out.println(estado);
                	}
                %>
                </label></td>
            </tr>

			
			<tr>
				<td><input type="reset" value="Cancelar"></td>
				<td><input type="submit" value="Registrar"></td>
			</tr>

		</table>
	</form>
    <!-- Mostrar tabla de usuarios registrados -->
    <h2>Usuarios Registrados</h2>
    <% if (mensajeAccion != null) { %>
        <div style="color: green; font-weight: bold; margin-bottom: 10px;"><%= mensajeAccion %></div>
    <% } %>
    <table border="1" cellpadding="5" cellspacing="0" style="margin-top:20px;">
        <tr>
            <th>Id</th>
            <th>Tipo Usuario</th>
            <th>Estado Civil</th>
            <th>Cedula</th>
            <th>Nombre</th>
            <th>Correo</th>
            <th>Estado</th>
            <th>Bloqueo</th>
            <th>Eliminar</th>
        </tr>
        <%
            Usuario userList = new Usuario();
            String sql = "SELECT u.id_us, p.descripcion_per, e.descripcion_est, u.cedula_us, u.nombre_us, u.correo_us, u.bloqueo, u.id_per " +
                         "FROM tb_usuario u, tb_perfil p, tb_estadocivil e " +
                         "WHERE u.id_per = p.id_per AND u.id_est = e.id_est " +
                         "ORDER BY u.id_us";
            com.productos.datos.Conexion con = new com.productos.datos.Conexion();
            java.sql.ResultSet rs = null;
            try {
                rs = con.Consulta(sql);
                while (rs != null && rs.next()) {
                    int id = rs.getInt(1);
                    int bloqueo = rs.getInt(7);
                    int idPerfil = rs.getInt(8);
                    String tipoUsuario = "";
                    switch (idPerfil) {
                        case 1: tipoUsuario = "Administrador"; break;
                        case 2: tipoUsuario = "Cliente"; break;
                        case 3: tipoUsuario = "Vendedor"; break;
                        default: tipoUsuario = "Otro"; break;
                    }
        %>
        <tr>
            <td><%= id %></td>
            <td><%= tipoUsuario %></td>
            <td><%= rs.getString(3) %></td>
            <td><%= rs.getString(4) %></td>
            <td><%= rs.getString(5) %></td>
            <td><%= rs.getString(6) %></td>
            <td><%= (bloqueo == 0 ? "Desbloqueado" : "Bloqueado") %></td>
            <td>
                <form action="usuarios.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="idUsuario" value="<%= id %>"/>
                    <input type="submit" name="accion" value="<%= (bloqueo == 0 ? "Bloquear" : "Desbloquear") %>"/>
                </form>
            </td>
            <td>
                <form action="usuarios.jsp" method="post" style="display:inline;" onsubmit="return confirm('¿Está seguro de eliminar este usuario?');">
                    <input type="hidden" name="idEliminar" value="<%= id %>"/>
                    <input type="submit" name="accion" value="Eliminar"/>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.print("<tr><td colspan='9' style='color:red;'>Error al cargar usuarios: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception ex) {}
                try { con.getConexion().close(); } catch (Exception ex) {}
            }
        %>
    </table>
		<nav>
		
	</section>

	<footer>
            <h3>Redes Sociales</h3>
            <ul>
                <li>
                    <a href="https://www.facebook.com/Raiz-Urbana100905191588000" target="_blank">
                        <img id="icono" src="iconos/face.jpg" width="50" height="50" alt="facebook">
                    </a>
                </li>
                <li>
                    <a href="https://www.instagram.com/raizurbana/" target="_blank">
                        <img id="icono" src="iconos/insta.jpg" width="50" height="50" alt="instagram">
                    </a>
                </li>
                <li>
                    <a href="https://tiktok.com/RaizUrbana" target="_blank">
                        <img id="icono" src="iconos/tik.jpg" alt="tiktok" width="50" height="50">
                    </a>
                </li>
            </ul>
        </footer>
	<script src="main.js"></script>
</body>
</html>

<%
}
%>