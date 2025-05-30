<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Compra realizada - Raiz Urbana</title>
    <link rel="icon" href="iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
    <style>
        body {
            background: #f4f4f4;
            font-family: 'Montserrat', Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .header-bar {
            background: #fff;
            border-bottom: 1px solid #eaeaea;
            padding: 1.5rem 0;
            text-align: center;
        }
        .header-bar img {
            height: 60px;
        }
        .main-success {
            max-width: 500px;
            margin: 40px auto 0 auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
            padding: 40px 32px 32px 32px;
            text-align: center;
        }
        .main-success .icon-check {
            color: #28a745;
            font-size: 4rem;
            margin-bottom: 16px;
        }
        .main-success h2 {
            color: #222;
            font-size: 2rem;
            margin-bottom: 12px;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .main-success p {
            color: #444;
            font-size: 1.1rem;
            margin-bottom: 24px;
        }
        .main-success .order-summary {
            background: #f8f8f8;
            border-radius: 8px;
            padding: 18px 16px;
            margin-bottom: 24px;
            text-align: left;
        }
        .main-success .order-summary h4 {
            margin: 0 0 10px 0;
            color: #21618C;
            font-size: 1.1rem;
            font-weight: 600;
        }
        .main-success .order-summary ul {
            list-style: none;
            padding: 0;
            margin: 0 0 8px 0;
        }
        .main-success .order-summary li {
            font-size: 1rem;
            color: #333;
            margin-bottom: 4px;
        }
        .main-success .order-summary .total {
            font-weight: bold;
            color: #21618C;
            font-size: 1.1rem;
        }
        .main-success .btn {
            background: #222;
            color: #fff;
            border: none;
            padding: 12px 32px;
            border-radius: 6px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: background 0.2s;
            margin-top: 10px;
            display: inline-block;
        }
        .main-success .btn:hover {
            background: #21618C;
        }
        .footer-bar {
            margin-top: 48px;
            background: #fff;
            border-top: 1px solid #eaeaea;
            padding: 24px 0;
            text-align: center;
            color: #888;
            font-size: 0.95rem;
        }
        .footer-bar ul {
            list-style: none;
            padding: 0;
            margin: 12px 0 0 0;
            display: flex;
            justify-content: center;
            gap: 20px;
        }
        .footer-bar li {
            display: inline-block;
        }
        .footer-bar img {
            width: 32px;
            height: 32px;
        }
        @media (max-width: 600px) {
            .main-success {
                padding: 24px 8px 16px 8px;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
</head>
<body>
    <div class="header-bar">
        <img src="iconos/logo.jpg" alt="Raiz Urbana Logo">
    </div>
    <div class="main-success">
        <div class="icon-check">
            <i class="fas fa-check-circle"></i>
        </div>
        <h2>¡Compra realizada con éxito!</h2>
        <%
            HttpSession sesion = request.getSession(false);
            String nombreUsuario = null;
            if (sesion != null) {
                nombreUsuario = (String) sesion.getAttribute("usuario");
            }
            if (nombreUsuario != null) {
        %>
            <div style="font-weight:bold; color:#21618C; margin-bottom:10px;">
                Cliente: <%= nombreUsuario %>
            </div>
        <% } %>
        <p>Gracias por confiar en <b>Raiz Urbana</b>. Tu pedido ha sido procesado correctamente.<br>
        En breve recibirás un correo con los detalles de tu compra.</p>
        <div class="order-summary">
            <h4>Resumen de tu pedido</h4>
            <ul>
                <%
                // Mostrar resumen de productos y total si viene de pago.jsp
                Map<Integer, Integer> carrito = null;
                boolean hayProductos = false;
                double total = 0;
                if (sesion != null) {
                    carrito = (Map<Integer, Integer>) sesion.getAttribute("carrito");
                }
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
                if (carrito != null && !carrito.isEmpty()) {
                    for (Map.Entry<Integer, Integer> entry : carrito.entrySet()) {
                        int id = entry.getKey();
                        int cantidad = entry.getValue();
                        String nombre = nombres.getOrDefault(id, "Producto");
                        double precio = precios.getOrDefault(id, 0.0);
                        double subtotal = precio * cantidad;
                        total += subtotal;
                        hayProductos = true;
                %>
                <li><%= nombre %> x <%= cantidad %> <span style="float:right;">$<%= String.format("%.2f", subtotal) %></span></li>
                <%
                    }
                }
                if (!hayProductos) {
                %>
                <li>No hay productos en el pedido.</li>
                <%
                }
                %>
            </ul>
            <div class="total">Total pagado: $<%= String.format("%.2f", total) %></div>
        </div>
        <a href="index.jsp" class="btn">Volver a la tienda</a>
    </div>
    <div class="footer-bar">
        <div>&copy; 2024 Raiz Urbana. Todos los derechos reservados.</div>
        <ul>
            <li>
                <a href="https://www.facebook.com/Raiz-Urbana100905191588000" target="_blank">
                    <img src="iconos/face.jpg" alt="facebook">
                </a>
            </li>
            <li>
                <a href="https://www.instagram.com/raizurbana/" target="_blank">
                    <img src="iconos/insta.jpg" alt="instagram">
                </a>
            </li>
            <li>
                <a href="https://tiktok.com/RaizUrbana" target="_blank">
                    <img src="iconos/tik.jpg" alt="tiktok">
                </a>
            </li>
        </ul>
    </div>
    
</body>
</html>