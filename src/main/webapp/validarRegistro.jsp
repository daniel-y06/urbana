<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" session="true" import="com.productos.seguridad.Usuario" %>
 
<%
Usuario usuario = new Usuario();
String nombre = request.getParameter("nombre");
String cedula = request.getParameter("cedula");
String correo = request.getParameter("correo");
String clave = request.getParameter("contrasena");
String repetirClave = request.getParameter("confirmar_contrasena");
int estadoCivil = Integer.parseInt(request.getParameter("estado_civil"));

usuario.setNombre(nombre);
usuario.setCedula(cedula);
usuario.setCorreo(correo);
usuario.setEstadoCivil(estadoCivil);

HttpSession sesion = request.getSession();
Object usuarioSesion = sesion.getAttribute("usuario");
Integer perfilSesion = (Integer) sesion.getAttribute("perfil");

if (usuarioSesion == null || perfilSesion != 1) {
    // Si no ha iniciado sesión o no es admin, solo se permite el registro de cliente
    if (!usuario.coincidirClaves(clave, repetirClave)) {
        request.setAttribute("error", "Las contraseñas no coinciden.");
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    } else if (!usuario.validarClave(clave)) {
        request.setAttribute("error", "La contraseña no cumple con los requisitos de seguridad.");
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    } else {
        usuario.setClave(clave);
        String resultado = usuario.ingresarCliente();
        if (resultado.equals("Inserción correcta")) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", resultado);
            request.getRequestDispatcher("usuarios.jsp").forward(request, response);
        }
    }
} else {
    // Si ha iniciado sesión como admin, se permite el registro de usuario
    // Manejo seguro del parámetro perfil para evitar NumberFormatException
    String sPerfilParam = request.getParameter("perfil");
    int perfil = 2; // valor por defecto (por ejemplo, vendedor)
    if (sPerfilParam != null && !sPerfilParam.trim().isEmpty()) {
        try {
            perfil = Integer.parseInt(sPerfilParam);
        } catch (NumberFormatException e) {
            perfil = 2; // valor seguro por defecto
        }
    }
    usuario.setPerfil(perfil);

    // Solo validar la clave por defecto, sin confirmar
    if (clave == null) {
        clave = "654321";
    }
    usuario.setClave(clave);
    boolean resultado = usuario.ingresarUsuario();
    if (resultado) {
        response.sendRedirect("usuarios.jsp");
    } else {
        request.setAttribute("error", "Error al registrar el usuario.");
        request.getRequestDispatcher("usuarios.jsp").forward(request, response);
    }
}
%>