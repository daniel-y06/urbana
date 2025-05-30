package com.productos.seguridad;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.productos.datos.Conexion;

public class Pagina {

	public String mostrarMenu(Integer nperfil)
	{
		String menu="";
		String sql="SELECT * FROM tb_pagina pag, tb_perfil per, "
				+ "tb_perfilpagina pper " +
				"WHERE pag.id_pag=pper.id_pag AND pper.id_per=per.id_per "
				+ "AND pper.id_per= "+nperfil;
		Conexion con = new Conexion();
		ResultSet rs=null;
		try
		{
			rs=con.Consulta(sql);
			while(rs.next())
			{
				String url = rs.getString(3);
				String nombre = rs.getString(2);
				// aquí puedes agregar otros enlaces si lo deseas
			}
			// Agregar opción "Carrito de Compras" solo para perfil 2
			if (nperfil != null && nperfil == 2) {
				menu += "<a href=\"carrito.jsp\" class=\"link-button\">Carrito de Compras</a>";
			}
			// Agregar opción "Administrar Productos" solo para perfiles 1 y 3
			if (nperfil != null && (nperfil == 1 || nperfil == 3)) {
				menu += "<a href=\"gestionProductos.jsp\" class=\"link-button\">Administrar Productos</a>";
			}
			// Agregar opción "Administrar Usuarios" solo para perfil 1
			if (nperfil != null && nperfil == 1) {
				menu += "<a href=\"usuarios.jsp\" class=\"link-button\">Administrar Usuarios</a>";
				menu += "<a href=\"bitacora.jsp\" class=\"link-button\">Bitácora</a>";
			}
			menu += "<a href=\"cambioClave.jsp\" class=\"link-button\">Cambiar Clave</a>";
			menu += "<a href=\"cerrarsesion.jsp\" class=\"link-button\">Cerrar Sesión</a>";
		}
		catch(SQLException e)
		{
			System.out.print(e.getMessage());
		}
		return menu;
	}

}