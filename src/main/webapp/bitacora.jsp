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
            <h1>Bitácora de Gestión de Productos</h1>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Usuario</th>
                    <th>Acción</th>
                    <th>Tabla</th>
                    <th>Fecha/Hora</th>
                </tr>
                <%
                // --- Solución robusta para mostrar todos los registros de auditoria.tb_auditoria ---
                Conexion con = null;
                ResultSet rs = null;
                boolean hayRegistros = false;
                try {
                    con = new Conexion();
                    // Forzar el search_path al esquema auditoria (PostgreSQL)
                    try {
                        java.sql.Statement st = con.getConexion().createStatement();
                        st.execute("SET search_path TO auditoria");
                        st.close();
                    } catch (Exception e) {
                        // Ignorar error de search_path
                    }
                    // Consulta sin el esquema para que funcione con el search_path
                    String sql = "SELECT id_aud, usuario, accion, tabla, fecha_hora FROM tb_auditoria ORDER BY id_aud DESC";
                    rs = con.Consulta(sql);
                    while (rs != null && rs.next()) {
                        hayRegistros = true;
                %>
                <tr>
                    <td><%= rs.getInt("id_aud") %></td>
                    <td><%= rs.getString("usuario") %></td>
                    <td><%= rs.getString("accion") %></td>
                    <td><%= rs.getString("tabla") %></td>
                    <td><%= rs.getTimestamp("fecha_hora") %></td>
                </tr>
                <%
                    }
                    if (!hayRegistros) {
                %>
                <tr>
                    <td colspan="5" style="color:gray;">No hay registros en la bitácora.</td>
                </tr>
                <%
                    }
                } catch (Exception e) {
                %>
                <tr>
                    <td colspan="5" style="color:red;">Error al cargar la bitácora: <%= e.getMessage() %></td>
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