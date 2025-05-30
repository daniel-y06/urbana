<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.productos.negocio.*" %>
    
    
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Raiz Urbana</title>
    <link rel="icon" href= "iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
    <style>
    .agrupar {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 2.5rem;
    }
    .agrupar-content {
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: flex-start;
        gap: 3rem;
        width: 100%;
    }
    .agrupar section, .agrupar aside {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        max-width: 600px;
    }
    .agrupar section img {
        display: block;
        margin: 1.2rem auto 0 auto;
    }
    .agrupar aside .informacion {
        align-items: center;
        text-align: center;
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
        }
    @media (max-width: 900px) {
        .agrupar-content {
            flex-direction: column;
            align-items: center;
            gap: 2rem;
        }
        .agrupar section, .agrupar aside {
            max-width: 98vw;
        }
    }
</style>
</head>
<body id="fondo">
    <header>
        <!-- Logo en la esquina superior derecha -->
        <img src="iconos/logo.jpg" alt="Logo Raiz Urbana" class="logo-empresa">
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
        
        <p>
    <a href="https://jigsaw.w3.org/css-validator/check/referer">
        <img style="border:0;width:88px;height:31px"
            src="https://jigsaw.w3.org/css-validator/images/vcss"
            alt="¡CSS Válido!" />
    </a>
</p>

<p>
    <a href="https://jigsaw.w3.org/css-validator/check/referer">
        <img style="border:0;width:88px;height:31px"
            src="https://jigsaw.w3.org/css-validator/images/vcss-blue"
            alt="¡CSS Válido!" />
    </a>
</p>
        <div class="agrupar">
    <div class="agrupar-content">
        <section>
            <h3>Nuestra misión</h3>
            <p>Brindar a los jóvenes una experiencia única de moda urbana, ofreciendo prendas innovadoras, accesibles y en tendencia, que reflejen su estilo de vida, personalidad y actitud. Nos inspiramos en la cultura urbana, la música y el arte para crear colecciones dinámicas que conecten con una generación creativa, auténtica y siempre en movimiento.</p>
            <img src="imagenes/1.jpeg" width="400" height="300" alt="Prenda Urbana">
        </section>
        <aside class="informacion">
            <h3>Informacion</h3>
            <div>
                <iframe src="https://www.google.com/maps/d/u/0/embed?mid=1DsRHTf9KW-vEtV5cNRH3wldOOAgCOqI&ehbc=2E312F"
                        width="600" height="440" title="Ubicación"></iframe>
            </div>
            <a href="https://ec.linkedin.com/">Ver más información sobre los desarrolladores</a>
            <div>
                <img id="icono" src="iconos/Tele.jpg" width="50" height="50" alt="Telegram">
            </div>
        </aside>
    </div>
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