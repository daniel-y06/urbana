<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
 pageEncoding="ISO-8859-1" session="true" import="com.productos.seguridad.*" %>
 
<%
HttpSession sesion=request.getSession(); //Se crea la variable de sesi�n
Usuario usuario= new Usuario();
usuario.setNombre(request.getParameter("nombre"));
usuario.setCedula(request.getParameter("cedula"));
String nclave=request.getParameter("password");
String nrepetir=request.getParameter("confirmPassword");
if(!usuario.coincidirClaves(nclave, nrepetir)){
	%>
	<jsp:forward page="registro.jsp">
	<jsp:param name="estado" value="Datos incorrectos.<br/>Vuelva a intentarlo."/>
	</jsp:forward>
	<%
}
usuario.setPerfil(2); // Asignar un valor predeterminado
String nEstadoCivil=request.getParameter("estadoCivil");
try {
	int estadoCivil = Integer.parseInt(nEstadoCivil);
	usuario.setEstadoCivil(estadoCivil);
} catch (NumberFormatException e) {
	// Manejo de error si el valor no es un n�mero v�lido
    usuario.setEstadoCivil(1); // O asignar un valor predeterminado
}
usuario.setCorreo(request.getParameter("correo"));
boolean respuesta=usuario.ingresarUsuario();
if (respuesta)
{

response.sendRedirect("index.jsp"); //Se redirecciona a una p�gina espec�fica

}
else
{
	%>
	<jsp:forward page="registro.jsp">
	<jsp:param name="estado" value="Datos incorrectos.<br/>Vuelva a intentarlo."/>
	</jsp:forward>
	<%
}

%>