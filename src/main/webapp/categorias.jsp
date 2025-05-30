<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.productos.negocio.*"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Raiz Urbana</title>
<link rel="icon" href="iconos/logo.jpg" type="image/x-icon">
<link rel="stylesheet" type="text/css" href="css/estilos.css">
</head>
<body id="fondo">
	<main>
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

				<div>



					<%
  String indiceSeleccionado = request.getParameter("cmbCategoria");
%>

					<form method="post" action="categorias.jsp">
						<label for="cmbCategoria">Selecciona una categoría:</label>
						<%Categoria c = new Categoria();
                out.print(c.mostrarCategoria());%>
						<button type="submit">Enviar</button>
					</form>
					
					<% 
					
					Producto p = new Producto();
				    try {
				    	int indice = Integer.parseInt(indiceSeleccionado);
					    
					    out.print(p.buscarProductoCategoria(indice)); 
			        } catch (NumberFormatException e) {
			        	 out.print(p.consultarTodo());
			        }
			    
				    
					%>
					
				</div>

			</section>

		</div>
		<footer> </footer>
	</main>
</body>
</html>