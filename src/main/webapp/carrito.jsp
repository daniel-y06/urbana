<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,com.productos.negocio.*" %>
<%
    HttpSession sesion = request.getSession();
    String nombreUsuario = (String) sesion.getAttribute("usuario");
    Map<Integer, Integer> carrito = (Map<Integer, Integer>) sesion.getAttribute("carrito");
    if (carrito == null) {
        carrito = new HashMap<Integer, Integer>();
        sesion.setAttribute("carrito", carrito);
    }

    // Procesar acciones de añadir o quitar
    String accion = request.getParameter("accion");
    String idProdStr = request.getParameter("id");
    if (accion != null && idProdStr != null) {
        try {
            int idProd = Integer.parseInt(idProdStr);
            if ("add".equals(accion)) {
                carrito.put(idProd, carrito.getOrDefault(idProd, 0) + 1);
            } else if ("remove".equals(accion)) {
                if (carrito.containsKey(idProd)) {
                    int cantidad = carrito.get(idProd) - 1;
                    if (cantidad > 0) {
                        carrito.put(idProd, cantidad);
                    } else {
                        carrito.remove(idProd);
                    }
                }
            }
            sesion.setAttribute("carrito", carrito);
        } catch (NumberFormatException e) {
            // ignorar error de formato
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Raiz Urbana - Carrito</title>
    <link rel="icon" href="iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
</head>
<body id="fondo">
    <header>
        <h1>Raiz Urbana</h1>
        <h2 class="destacado">Moda casual, urbana y sostenible</h2>
        <h4 id="favorito">Consumir la moda de manera consciente e intencionada para lucir mejor cada día</h4>
    </header>
    <nav>
        <a href="index.jsp">Inicio</a>
        <a href="carrito.jsp">Carrito De Compras</a>
        <a href="cambioClave.jsp">Cambio de clave</a>
        <a href="cerrarsesion.jsp">Cerrar Sesion</a>
    </nav>
    <div class="agrupar">
        <h2 style="text-align:center; color:#21618C;">Catálogo de Productos</h2>
        <div class="products">
            <!-- Productos fijos con imágenes -->
            <div class="product">
                <img src="imagenes/camiseta.png" width="200" height="100" alt="camiseta">
                <h3>Camiseta Oversize Negra</h3>
                <p class="price">$25.99</p>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="101"/>
                    <input type="hidden" name="accion" value="add"/>
                    <button type="submit" class="btn btn-add">Añadir</button>
                </form>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="101"/>
                    <input type="hidden" name="accion" value="remove"/>
                    <button type="submit" class="btn btn-remove">Quitar</button>
                </form>
            </div>
            <div class="product">
                <img src="imagenes/jean.png" width="200" height="100" alt="jean">
                <h3>Jeans Slim Azul Oscuro</h3>
                <p class="price">$45.50</p>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="102"/>
                    <input type="hidden" name="accion" value="add"/>
                    <button type="submit" class="btn btn-add">Añadir</button>
                </form>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="102"/>
                    <input type="hidden" name="accion" value="remove"/>
                    <button type="submit" class="btn btn-remove">Quitar</button>
                </form>
            </div>
            <div class="product">
                <img src="imagenes/sudadera.png" width="200" height="100" alt="sudadera">
                <h3>Sudadera con Capucha Blanca</h3>
                <p class="price">$39.99</p>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="103"/>
                    <input type="hidden" name="accion" value="add"/>
                    <button type="submit" class="btn btn-add">Añadir</button>
                </form>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="103"/>
                    <input type="hidden" name="accion" value="remove"/>
                    <button type="submit" class="btn btn-remove">Quitar</button>
                </form>
            </div>
            <div class="product">
                <img src="imagenes/zapa.png" width="200" height="100" alt="zapatillas">
                <h3>Zapatillas Urbanas Negras</h3>
                <p class="price">$69.90</p>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="104"/>
                    <input type="hidden" name="accion" value="add"/>
                    <button type="submit" class="btn btn-add">Añadir</button>
                </form>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="104"/>
                    <input type="hidden" name="accion" value="remove"/>
                    <button type="submit" class="btn btn-remove">Quitar</button>
                </form>
            </div>
            <div class="product">
                <img src="imagenes/gorra.png" width="200" height="100" alt="gorra">
                <h3>Gorra Snapback</h3>
                <p class="price">$15.00</p>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="105"/>
                    <input type="hidden" name="accion" value="add"/>
                    <button type="submit" class="btn btn-add">Añadir</button>
                </form>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="105"/>
                    <input type="hidden" name="accion" value="remove"/>
                    <button type="submit" class="btn btn-remove">Quitar</button>
                </form>
            </div>
           
        </div>
        <h2 style="text-align:center; color:#21618C; margin-top:32px;">Carrito de Compras</h2>
        <% if (nombreUsuario != null) { %>
            <div style="text-align:center; font-weight:bold; color:#21618C; margin-bottom:10px;">
                Usuario: <%= nombreUsuario %>
            </div>
        <% } %>
        <%
            if (carrito.isEmpty()) {
        %>
            <p>No hay productos en el carrito.</p>
        <%
            } else {
        %>
        <table>
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Cantidad</th>
                    <th>Precio Unitario</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
            <%
                double total = 0;
                // Mapeo de IDs a nombres y precios fijos para los productos con imagen
                Map<Integer, String> nombres = new HashMap<Integer, String>();
                nombres.put(101, "Camiseta Oversize Negra");
                nombres.put(102, "Jeans Slim Azul Oscuro");
                nombres.put(103, "Sudadera con Capucha Blanca");
                nombres.put(104, "Zapatillas Urbanas Negras");
                nombres.put(105, "Gorra Snapback");
                Map<Integer, Double> precios = new HashMap<Integer, Double>();
                precios.put(101, 25.99);
                precios.put(102, 45.50);
                precios.put(103, 39.99);
                precios.put(104, 69.90);
                precios.put(105, 15.00);

                for (Map.Entry<Integer, Integer> entry : carrito.entrySet()) {
                    int id = entry.getKey();
                    int cantidad = entry.getValue();
                    String nombre = nombres.getOrDefault(id, "Producto");
                    double precio = precios.getOrDefault(id, 0.0);
                    double subtotal = precio * cantidad;
                    total += subtotal;
            %>
                <tr>
                    <td><%= nombre %></td>
                    <td><%= cantidad %></td>
                    <td>$<%= String.format("%.2f", precio) %></td>
                    <td>$<%= String.format("%.2f", subtotal) %></td>
                </tr>
            <%
                }
            %>
                <tr>
                    <td colspan="3" style="text-align:right;font-weight:bold;">Total:</td>
                    <td style="font-weight:bold;">$<%= String.format("%.2f", total) %></td>
                </tr>
            </tbody>
        </table>
        <!-- Botón de pagar debajo del total -->
        <div style="text-align:right; margin-top:10px;">
            <form action="pago.jsp" method="get" style="display:inline;">
                <button type="submit" class="btn btn-add" style="font-size:1.1rem;padding:10px 30px;">Pagar</button>
            </form>
        </div>
        <%
            }
        %>
    </div>
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
</body>
</html>
