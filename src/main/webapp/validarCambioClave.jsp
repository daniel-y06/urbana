<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.productos.seguridad.*"%>

<%
String usuario;
HttpSession sesion = request.getSession();
if (sesion.getAttribute("usuario") == null) //Se verifica si existe la variable
{
%>
<jsp:forward page="login.jsp">
	<jsp:param name="error" value="Debe registrarse en el sistema." />
</jsp:forward>
<%
} else {
%>

<%
usuario = (String) sesion.getAttribute("usuario"); //Se devuelve los valores de atributos
int perfil = (Integer) sesion.getAttribute("perfil");
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
        <a href="index.jsp">Inicio</a>
        	<a href="login.jsp">Login</a>
            <a href="registro.jsp">Registro</a>
            <a href="productos.jsp">Ver Productos</a>
            <a href="categorias.jsp">Buscar Por Categoría</a>
            

        </nav>

	<section class="opcion">
		<h1>
			Registro de usuarios (
			<%
		out.println(usuario);
		%>
			)
		</h1>
		<form action="validarCambioClave.jsp" method="post" class="card">
			<table border="0" cellpadding="5" cellspacing="5">
				<!-- organizacion columna fila -->
				<!-- input contraseña actual -->
				<tr>
					<td><label for="contrasena">Contraseña actual:</label></td>
					<td><input type="password" id="contrasena" name="contrasena"
						required></td>
				</tr>
				<!-- input nueva contraseña -->
				<tr>
					<td><label for="nueva_contrasena">Nueva Contraseña:</label></td>
					<td><input type="password" id="nueva_contrasena"
						name="nueva_contrasena" required></td>
				</tr>
				<!-- input confirmar contraseña -->
				<tr>
					<td><label for="confirmar_contrasena">Confirmar Nueva
							Contraseña:</label></td>
					<td><input type="password" id="confirmar_contrasena"
						name="confirmar_contrasena" required></td>
				</tr>

				<!-- label estado -->
				<tr>
					<td><label for="estado"> <%
                	String estado = (String) sesion.getAttribute("estado");
                		if (estado != null) {
                		out.println(estado);
                	}
                %>
					</label></td>
				</tr>

				<!-- Boton de registro -->
				<tr>
					<td><input type="reset" value="Cancelar"></td>
					<td><input type="submit" value="Registrar"></td>
				</tr>

			</table>
		</form>

		<nav>
			<%
		Pagina pag = new Pagina();
		String menu = pag.mostrarMenu(perfil);
		out.print(menu);
		%>
		</nav>
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