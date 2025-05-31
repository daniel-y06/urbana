<!-- filepath: c:\Users\danie\eclipse-workspace\site002\src\main\webapp\bitacora.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,com.productos.datos.Conexion,com.productos.seguridad.Pagina"%>
<%
    // Obtener el perfil del usuario para mostrar el menú correctamente
    HttpSession sesion = request.getSession(false);
    int perfil = 0;
    if (sesion != null && sesion.getAttribute("perfil") != null) {
        perfil = (Integer) sesion.getAttribute("perfil");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bitácora</title>
    <link rel="icon" href="iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
    <style>
        .bitacora-table {
            width: 100%;
            border-collapse: collapse;
            margin: 30px 0;
            font-size: 1rem;
            background: #fff;
        }
        .bitacora-table th, .bitacora-table td {
            border: 1px solid #b5ead7;
            padding: 8px 12px;
            text-align: left;
        }
        .bitacora-table th {
            background: #b5ead7;
            color: #222;
            font-weight: bold;
        }
        .bitacora-table tr:nth-child(even) {
            background: #f8f8f8;
        }
        .bitacora-table tr:hover {
            background: #e0f7fa;
        }
        .bitacora-table td {
            vertical-align: top;
            max-width: 350px;
            word-break: break-all;
        }
        .bitacora-title {
            margin-top: 30px;
            color: #21618C;
            text-align: center;
            font-size: 2rem;
            font-weight: 700;
        }
        .logo-empresa {
            position: absolute;
            top: 18px;
            right: 32px;
            z-index: 100;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            box-shadow: 0 2px 8px #b5ead733;
            background: #fff;
            object-fit: cover;
        }
        header {
            position: relative;
        }
        @media (max-width: 600px) {
            .logo-empresa {
                width: 70px;
                height: 70px;
                top: 10px;
                right: 10px;
            }
            .bitacora-table th, .bitacora-table td {
                font-size: 0.85rem;
                padding: 6px 4px;
            }
        }
    </style>
</head>
<body id="fondo">
    <main>
        <header>
            <img src="iconos/logo.jpg" alt="Logo Raiz Urbana" class="logo-empresa">
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
        <div class="container">
            <div class="bitacora-title">Bitácora de Cambios (Auditoría)</div>
            <table class="bitacora-table">
                <tr>
                    <th>ID</th>
                    <th>Tabla</th>
                    <th>Operación</th>
                    <th>Valor Anterior</th>
                    <th>Valor Nuevo</th>
                    <th>Fecha</th>
                    <th>Usuario</th>
                    <th>Esquema</th>
                    <th>Activar</th>
                    <th>Trigger</th>
                </tr>
                <%
                Conexion con = null;
                ResultSet rs = null;
                boolean hayRegistros = false;
                try {
                    con = new Conexion();
                    // Consulta con nombres de columnas correctos y mayúsculas/minúsculas según tu tabla
                    String sql = "SELECT ID_AUD, TABLA_AUD, OPERACION_AUD, VALORANTERIOR_AUD, VALORNUEVO_AUD, FECHA_AUD, USUARIO_AUD, ESQUEMA_AUD, ACTIVAR_AUD, TRIGGER_AUD FROM auditoria.tb_auditoria ORDER BY ID_AUD ASC";
                    rs = con.Consulta(sql);
                    while (rs != null && rs.next()) {
                        hayRegistros = true;
                %>
                <tr>
                    <td><%= rs.getObject("ID_AUD") %></td>
                    <td><%= rs.getObject("TABLA_AUD") %></td>
                    <td><%= rs.getObject("OPERACION_AUD") %></td>
                    <td><%= rs.getObject("VALORANTERIOR_AUD") %></td>
                    <td><%= rs.getObject("VALORNUEVO_AUD") %></td>
                    <td><%= rs.getObject("FECHA_AUD") %></td>
                    <td><%= rs.getObject("USUARIO_AUD") %></td>
                    <td><%= rs.getObject("ESQUEMA_AUD") %></td>
                    <td><%= rs.getObject("ACTIVAR_AUD") %></td>
                    <td><%= rs.getObject("TRIGGER_AUD") %></td>
                </tr>
                <%
                    }
                    if (!hayRegistros) {
                %>
                <tr>
                    <td colspan="10" style="color:gray;">No hay registros en la bitácora.</td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                %>
                <tr>
                    <td colspan="10" style="color:red;">Error al cargar la bitácora: <%= e.getMessage() %></td>
                </tr>
                <%
                } finally {
                    if (rs != null) try { rs.close(); } catch (Exception ex) {}
                    if (con != null) try { con.getConexion().close(); } catch (Exception ex) {}
                }
                %>
            </table>
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
    </main>
</body>
</html>
