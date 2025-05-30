<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.*" %>
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
        <div class="agrupar">
            <section>
        <% Producto pr=new Producto();
        out.print(pr.consultarTodo());
        %>
         </section>
        </div>
        <main>
        <h2 style="text-align:center; color:#21618C;">Catálogo de Productos</h2>
        <div class="products">
            <div class="product">
                <img src="imagenes/camiseta.png" alt="camiseta">
                <h3>Camiseta Oversize Negra	</h3>
                <p class="price">$25.99</p>
            </div>
            <div class="product">
                <img src="imagenes/jean.png" alt="jean">
                <h3>Jeans Slim Azul Oscuro	</h3>
                <p class="price">$45.50</p>
            </div>
            <div class="product">
                <img src="imagenes/sudadera.png" alt="sudadera">
                <h3>Sudadera con Capucha Blanca	</h3>
                <p class="price">$39.99</p>
            </div>
         <div class="product">
                <img src="imagenes/zapa.png" alt="zapatillas">
                <h3>Zapatillas Urbanas Negras</h3>
                <p class="price">$69.90</p>
            </div>
            <div class="product">
                <img src="imagenes/gorra.png" alt="gorra">
                <h3>Gorra Snapback</h3>
                <p class="price">$15.0</p>
            </div>
        </div>
    </main>
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
    </main>
</body>
</html>