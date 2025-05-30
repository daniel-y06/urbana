<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.productos.negocio.* , com.productos.seguridad.*"%>
<%
String usuario;
HttpSession sesion = request.getSession();
if (sesion.getAttribute("usuario") == null) {
%>
<jsp:forward page="login.jsp">
	<jsp:param name="error" value="Debe registrarse en el sistema." />
</jsp:forward>
<%
} else {
	usuario = (String) sesion.getAttribute("usuario");
	int perfil = (Integer) sesion.getAttribute("perfil");
%>
<!DOCTYPE html>
<html lang="es">
<head>
 <meta charset="UTF-8">
    <title>Raiz Urbana</title>
    <link rel="icon" href= "iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&amp;family=Roboto:wght@400;700&amp;display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="style.css" />
<style>
body {
	font-family: 'Montserrat', 'Roboto', sans-serif;
}
</style>
</head>
 <header>
            <h1>Raiz Urbana</h1>
           
            <h2 class="destacado">Moda casual, urbana y sostenible</h2>
            <h4 id="favorito">Consumir la moda de manera consciente e intencionada para lucir mejor cada día</h4>
        </header>
<body class="bg-white text-gray-900">
	<header class="w-full shadow-md fixed top-0 left-0 bg-white z-50">
		<div>
	
			
		</div>
		<div class="hidden md:hidden bg-white shadow-md" id="mobile-menu">
			<ul>
				<nav>
				<%
				Pagina pag_nav_m = new Pagina();
				HttpSession ses_m = request.getSession();
				Object usr_m = ses_m.getAttribute("usuario");
				int per_m = (usr_m != null) ? (int) ses_m.getAttribute("perfil") : 0;
				out.print(pag_nav_m.mostrarMenu(per_m));
				%>
				</nav>
			</ul>
		</div>
	</header>

	<main class="pt-24">
		<section id="menu">
			<h2 class="text-center text-3xl font-bold text-indigo-700">Agregar Productos</h2>
			<form action="gestionProductos.jsp" method="post">
				<table>
					<tr>
						<td><label for="nombre">Nombre:</label></td>
						<td><input type="text" id="nombre" name="nombre" required></td>
					</tr>
					<tr>
						<td><label for="precio">Precio:</label></td>
						<td><input type="number" id="precio" name="precio" step="0.01" required></td>
					</tr>
					<tr>
						<td><label for="cantidad">Cantidad:</label></td>
						<td><input type="number" id="cantidad" name="cantidad" min="1" required></td>
					</tr>
					<tr>
						<td><label for="categoria">Categoria:</label></td>
						<td>
						<%
						Categoria c = new Categoria();
						out.print(c.mostrarCategoria());
						%>
						</td>
					</tr>
					<tr>
						<td colspan="2"><input type="submit" value="Agregar Producto"></td>
					</tr>
				</table>
			</form>
			<%
			// Obtener los datos del formulario
			String nombre = request.getParameter("nombre");
			String precio = request.getParameter("precio");
			String cantidad = request.getParameter("cantidad");
			String categoria = request.getParameter("cmbCategoria");
			boolean conversionOK = true;
			double precioDouble = 0;
			int cantidadInt = 0;
			int categoriaInt = 0;
			if (nombre != null && precio != null && cantidad != null && categoria != null) {
	            try {
	                precioDouble = Double.parseDouble(precio);
	                cantidadInt = Integer.parseInt(cantidad);
	                categoriaInt = Integer.parseInt(categoria);
	            } catch (NumberFormatException e) {
	                out.println("<p>Error: Precio, Cantidad o Categoria no válidos.</p>");
	                conversionOK = false;
	            }
	            if (conversionOK) {
		            Producto pInsert = new Producto();
		            // Debes implementar este método en tu clase Producto
		            boolean resultado = pInsert.insertarProducto(nombre, cantidadInt, precioDouble, categoriaInt);
		            if (resultado) {
		                out.println("<p>Producto agregado exitosamente.</p>");
						// Registrar en auditoría
						try {
							com.productos.datos.Conexion conAud = new com.productos.datos.Conexion();
							String sqlAud = "INSERT INTO auditoria.tb_auditoria (usuario, accion, tabla, fecha_hora) VALUES (?, ?, ?, NOW())";
							java.sql.PreparedStatement psAud = conAud.getConexion().prepareStatement(sqlAud);
							psAud.setString(1, usuario);
							psAud.setString(2, "INSERTAR");
							psAud.setString(3, "tb_producto");
							psAud.executeUpdate();
							psAud.close();
							conAud.getConexion().close();
						} catch(Exception ex) {
							// Ignorar error de auditoría
						}
		            } else {
		                out.println("<p>Error al agregar el producto.</p>");
		            }
	            }
	        }
			%>
		</section>
		<section id="productos">
			<h2 class="text-center text-3xl font-bold text-indigo-700">Lista de Productos</h2>
			<%
			Producto p = new Producto();
			out.print(p.reporteProducto());
			%>
		</section>
	</main>

	<h3>Redes Sociales</h3>
           
                
                    <a href="https://www.facebook.com/Raiz-Urbana100905191588000" target="_blank">
                        <img id="icono" src="iconos/face.jpg" width="50" height="50" alt="facebook">
                    </a>
                
                    <a href="https://www.instagram.com/raizurbana/" target="_blank">
                        <img id="icono" src="iconos/insta.jpg" width="50" height="50" alt="instagram">
                    </a>
                
                    <a href="https://tiktok.com/RaizUrbana" target="_blank">
                        <img id="icono" src="iconos/tik.jpg" alt="tiktok" width="50" height="50">
                    </a>

	
</body>
</html>
<%
}
%>