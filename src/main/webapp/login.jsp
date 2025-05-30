<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Formulario de Registro</title>
<link rel="icon" href="iconos/logo.jpg" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="css/estilos.css">

</head>
<body>
<body id="fondo">
		<header>
			<h1>Raiz Urbana</h1>

			<h2 class="destacado">Moda casual, urbana y sostenible</h2>
			<h4 id="favorito">Consumir la moda de manera consciente e
				intencionada para lucir mejor cada día</h4>
		</header>
		<nav>
			<a href="index.jsp">Inicio</a>
        	<a href="login.jsp">Login</a>
            <a href="registro.jsp">Registro</a>
            <a href="productos.jsp">Ver Productos</a>
            <a href="categorias.jsp">Buscar Por Categoría</a>
            

		</nav>
		<div class="agrupar">
			<section>
				<h3>Iniciar Sesion</h3>
                <% 
                String mensaje = request.getParameter("mensaje");
                if (mensaje != null) { 
                %>
                <div style="color: green; font-weight: bold; margin-bottom: 10px;"><%= mensaje %></div>
                <% } %>
				<form action="validarlogin.jsp" method="post" class="card">
					<table border="0" cellpadding="5" cellspacing="5">
						<!-- input correo -->
						<tr>
							<td><label for="correo">Correo:</label></td>
							<td><input type="email" id="correo" name="correo" required></td>
						</tr>
						<!-- input contraseña -->
						<tr>
							<td><label for="contraseña">Contraseña:</label></td>
							<td><input type="password" id="contrasena" name="contrasena"
								required></td>
						</tr>
						    
						<tr>
							<td colspan="2"><input type="submit" value="Iniciar Sesion"></td>
						</tr>
					</table>+
				</form>
				</section>
		</div>
		
</body>
</html>