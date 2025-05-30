package com.productos.negocio;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import com.productos.datos.Conexion;

public class Categoria {

    public String mostrarCategoria() {
        String combo = "<select name='cmbCategoria'>";
        String sql = "SELECT * FROM tb_categoria";
        ResultSet rs = null;
        Conexion con = new Conexion();

        try {
            rs = con.Consulta(sql);
            while (rs.next()) {
                combo += "<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + "</option>";
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }

        combo += "</select>";
        return combo;
    }

    // Nuevo método para obtener todas las categorías como lista de mapas
    public List<Map<String, Object>> obtenerTodas() {
        List<Map<String, Object>> lista = new ArrayList<>();
        String sql = "SELECT id_cat, descripcion_cat FROM tb_categoria";
        Conexion con = new Conexion();
        ResultSet rs = null;
        try {
            rs = con.Consulta(sql);
            while (rs.next()) {
                Map<String, Object> cat = new HashMap<>();
                cat.put("id_cat", rs.getInt("id_cat"));
                cat.put("descripcion_cat", rs.getString("descripcion_cat"));
                lista.add(cat);
            }
        } catch (SQLException e) {
            System.out.print(e.getMessage());
        }
        return lista;
    }
}
