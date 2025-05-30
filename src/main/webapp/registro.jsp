<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.productos.negocio.* , com.productos.seguridad.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Formulario de Registro</title>
    <link rel="icon" href="iconos/logo.jpg" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="css/estilos.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 400px;
            margin: auto;
            padding: 20px;
            background: white;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin: 10px 0 5px;
        }

        input[type="text"], input[type="file"], input[type="date"], input[type="month"], input[type="email"], input[type="password"], select {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"], input[type="reset"] {
            width: 48%;
            margin: 5px 1%;
            padding: 10px;
            border: none;
            background-color: #28a745;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }

        input[type="reset"] {
            background-color: #dc3545;
        }

        .radio-group {
            margin: 10px 0;
        }
    </style>
    <script>
        function validateForm() {
            const password = document.getElementById("password").value;
            const confirmPassword = document.getElementById("confirmPassword").value;
            if (password !== confirmPassword) {
                alert("Las contraseñas no coinciden.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body id="fondo">

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

    
	</header>

	<main class="pt-24">
		<h3 class="text-center text-3xl font-bold text-indigo-700">Registro nuevo cliente</h3>
		<form action="validarRegistro.jsp" method="post" class="card">
			<table border="0" cellpadding="5" cellspacing="5">
				<!-- organizacion columna fila -->
				<!-- input nombre -->
				<tr>
					<td><label for="nombre">Nombre:</label></td>
					<td><input type="text" id="nombre" name="nombre" required>
					</td>
				</tr>
				<!-- input cedula -->
				<tr>
					<td><label for="cedula">Cedula:</label></td>
					<td><input type="text" id="cedula" name="cedula" required>
					</td>
				</tr>
				<!-- input estado civil -->
				<tr>
					<td><label for="estado_civil">Estado Civil:</label></td>
					<td><select id="estado_civil" name="estado_civil">
							<option value="1">Soltero</option>
							<option value="2">Casado</option>
							<option value="3">Divorciado</option>
							<option value="4">Viudo</option>
					</select></td>
				</tr>
				<!-- input lugar residencia -->
				<tr>
					<td><label for="lugar_residencia">Lugar de Residencia:</label></td>
					<td><input type="radio" id="lugar_residencia"
						name="lugar_residencia" value="Quito"> Norte <input
						type="radio" id="lugar_residencia" name="lugar_residencia"
						value="Guayaquil"> Centro <input type="radio"
						id="lugar_residencia" name="lugar_residencia" value="Cuenca">
						Sur</td>
				</tr>
				<!-- input hoja de vida -->
				<tr>
					<td><label for="hoja_vida">Hoja de Vida:</label></td>
					<td><input type="file" id="hoja_vida" name="hoja_vida"
						accept=".pdf" ></td>
				</tr>
				<!-- input foto -->
				<tr>
					<td><label for="foto">Foto:</label></td>
					<td><input type="file" id="foto" name="foto" accept="image/*"
						></td>
				</tr>
				<!-- input fecha de nacimiento -->
				<tr>
					<td><label for="fecha_nacimiento">Fecha de Nacimiento:</label></td>
					<td><input type="date" id="fecha_nacimiento"
						name="fecha_nacimiento"></td>
				</tr>
				<!-- input color favorito -->
				<tr>
					<td><label for="color_favorito">Color Favorito:</label></td>
					<td><input type="text" id="color_favorito"
						name="color_favorito"></td>
				</tr>
				<!-- input correo -->
				<tr>
					<td><label for="correo">Correo:</label></td>
					<td><input type="email" id="correo" name="correo" required>
					</td>
				</tr>
				<!-- input contrasena -->
				<tr>
					<td><label for="contrasena">Contraseña:</label></td>
					<td><input type="password" id="contrasena" name="contrasena"
						required></td>
				</tr>
				<!-- input confirmar contrasena -->
				<tr>
					<td><label for="confirmar_contrasena">Confirmar
							Contraseña:</label></td>
					<td><input type="password" id="confirmar_contrasena"
						name="confirmar_contrasena" required></td>
				</tr>
				<!-- label estado -->
				<tr>
	                <td><label for="estado">
	                <%
	                	String estado = (String) request.getAttribute("estado");
	                	if (estado != null) {
	                		out.println(estado);
	                	}
	                %>
	                </label></td>
	            </tr>

				<!-- Boton de registro -->
				<tr>
					<td><input type="reset" value="Cancelar"></td>
					<td><input type="submit" value="Registrar"></td>
				</tr>


			</table>
		</form>
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