<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%
    // Recuperar el carrito y los datos de productos
    HttpSession sesion = request.getSession();
    Map<Integer, Integer> carrito = (Map<Integer, Integer>) sesion.getAttribute("carrito");
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
    double total = 0;

    // Validación de tarjeta con algoritmo de Luhn
    boolean tarjetaValida = true;
    String errorTarjeta = null;
    String numeroTarjeta = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        numeroTarjeta = request.getParameter("numero");
        if (numeroTarjeta != null) {
            numeroTarjeta = numeroTarjeta.replaceAll("\\s+", "");
            int sum = 0;
            boolean alternate = false;
            try {
                for (int i = numeroTarjeta.length() - 1; i >= 0; i--) {
                    int n = Integer.parseInt(numeroTarjeta.substring(i, i + 1));
                    if (alternate) {
                        n *= 2;
                        if (n > 9) n -= 9;
                    }
                    sum += n;
                    alternate = !alternate;
                }
                if (sum % 10 != 0) {
                    tarjetaValida = false;
                    errorTarjeta = "El número de tarjeta ingresado no es válido.";
                }
            } catch (NumberFormatException e) {
                tarjetaValida = false;
                errorTarjeta = "El número de tarjeta ingresado no es válido.";
            }
        }
    }
    boolean compraProcesada = false;
    if ("POST".equalsIgnoreCase(request.getMethod()) && tarjetaValida) {
        // Rebajar la cantidad de cada producto en la base de datos (de una sola vez por producto)
        if (carrito != null && !carrito.isEmpty()) {
            com.productos.negocio.Producto productoNegocio = new com.productos.negocio.Producto();
            for (Map.Entry<Integer, Integer> entry : carrito.entrySet()) {
                int idProducto = entry.getKey();
                int cantidad = entry.getValue();
                // Rebaja la cantidad de una sola vez usando el método adecuado
                productoNegocio.disminuirCantidad(idProducto, cantidad);
            }
        }
        compraProcesada = true;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pago - Raiz Urbana</title>
    <link rel="icon" href="iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
    <style>
        .tarjetas {
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            align-items: center;
            gap: 18px;
            margin-bottom: 16px;
        }
        .tarjetas img {
            height: 38px;
            width: auto;
            max-width: 70px;
            object-fit: contain;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            background: #faf9f8;
        }
        .numero-tarjeta-input {
            width: 240px;
            font-size: 1.2em;
            letter-spacing: 2px;
            padding: 0.5em;
            margin-bottom: 12px;
            text-align: center;
        }
        @media (max-width: 900px) {
            .container-pago { flex-direction: column; }
            .resumen-carrito, .form-pago { border-right: none; border-bottom: 1px solid #eee; }
            .tarjetas { justify-content: center; }
            .numero-tarjeta-input { width: 98vw; max-width: 98vw; }
        }
    </style>
</head>
<body>
    <header>
        <h1 style="text-align:center; color:#21618C;">Raiz Urbana</h1>
    </header>
    <div class="container-pago">
        <div class="resumen-carrito">
            <h2>Resumen de tu compra</h2>
            <table>
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Precio</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (carrito != null && !carrito.isEmpty()) {
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
                    } else {
                %>
                    <tr>
                        <td colspan="4">No hay productos en el carrito.</td>
                    </tr>
                <%
                    }
                %>
                    <tr class="total-row">
                        <td colspan="3" style="text-align:right;">Total:</td>
                        <td>$<%= String.format("%.2f", total) %></td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="form-pago">
            <h2>Pago con Tarjeta</h2>
            <div class="tarjetas">
                <img src="https://upload.wikimedia.org/wikipedia/commons/0/04/Visa.svg" alt="Visa">
                <img src="imagenes/master.png" alt="MasterCard">
                <img src="imagenes/disco.png" alt="Discover">
            </div>
            <% if (!tarjetaValida && errorTarjeta != null) { %>
                <div style="color:red; font-weight:bold; margin-bottom:10px;"><%= errorTarjeta %></div>
            <% } %>
            <form action="pago.jsp" method="post" autocomplete="off">
                <label for="direccion">Dirección de envío</label>
                <input type="text" id="direccion" name="direccion" required maxlength="120" placeholder="Calle, número, ciudad, provincia">

                <label for="telefono">Número de teléfono</label>
                <input type="text" id="telefono" name="telefono" required maxlength="15" pattern="[0-9+ ]{7,15}" placeholder="Ej: 0999999999">

                <label for="nombre">Nombre del comprador</label>
                <input type="text" id="nombre" name="nombre" required maxlength="50" placeholder="Como aparece en tu identificación">

                <label for="numero">Número de tarjeta</label>
                <input type="text" class="numero-tarjeta-input" id="numero" name="numero" maxlength="16" pattern="[0-9]{16}" required placeholder="0000 0000 0000 0000" inputmode="numeric" autocomplete="cc-number" value="<%= numeroTarjeta != null ? numeroTarjeta : "" %>">

                <label>Fecha de expiración</label>
                <div class="expira-group">
                    <input type="text" id="expira_mes" name="expira_mes" required maxlength="2" pattern="[0-9]{2}" placeholder="MM">
                    <span>/</span>
                    <input type="text" id="expira_anio" name="expira_anio" required maxlength="2" pattern="[0-9]{2}" placeholder="AA">
                </div>

                <label for="cvv">CVV</label>
                <input type="text" id="cvv" name="cvv" required maxlength="4" pattern="[0-9]{3,4}" placeholder="CVV">

                <label for="correo">Correo de contacto</label>
                <input type="email" id="correo" name="correo" required placeholder="correo@ejemplo.com">

                <input type="hidden" name="total" value="<%= String.format("%.2f", total) %>">
                <input type="submit" value="Pagar $<%= String.format("%.2f", total) %>">
            </form>
            <% if (compraProcesada) { %>
                <script>
                    window.location.href = "respuesta.jsp";
                </script>
            <% } %>
        </div>
    </div>
    <footer style="margin-top:40px; text-align:center; color:#777;">
        <h3>Redes Sociales</h3>
        <ul style="list-style:none; padding:0; display:flex; justify-content:center; gap:20px;">
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
    <script>
        // Formato automático para el campo de número de tarjeta (opcional)
        document.addEventListener('DOMContentLoaded', function() {
            var input = document.getElementById('numero');
            if (input) {
                input.addEventListener('input', function(e) {
                    this.value = this.value.replace(/\D/g, '').slice(0,16);
                });
            }
        });
    </script>
</body>
</html>