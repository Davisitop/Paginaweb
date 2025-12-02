package com.productos.seguridad;

import com.productos.datos.Conexion;
import java.sql.*;

public class Bitacora {

    public void registrar(int idUsuario, String accion, String detalle) {
        String sql = "INSERT INTO tb_bitacora(id_usuario, accion, detalle, fecha) VALUES(" + idUsuario + ", '" + accion + "', '" + detalle + "', NOW())";
        Conexion con = new Conexion();
        try {
            con.Ejecutar(sql);
            if(con.getConexion() != null) con.getConexion().close();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public String reporteBitacora() {
        String sql = "SELECT u.nombre_us, b.accion, b.detalle, b.fecha FROM tb_bitacora b INNER JOIN tb_usuario u ON b.id_usuario = u.id_us ORDER BY b.fecha DESC";
        Conexion con = new Conexion();
        StringBuilder html = new StringBuilder();
        
        html.append("<div class='table-responsive'><table class='table table-hover align-middle' style='background: rgba(255,255,255,0.9); border-radius: 10px;'>");
        html.append("<thead class='table-danger'><tr><th>Usuario</th><th>Acción</th><th>Detalle</th><th>Fecha</th></tr></thead><tbody>");
        
        try {
            ResultSet rs = con.Consulta(sql);
            while (rs.next()) {
                html.append("<tr>");
                html.append("<td><b>").append(rs.getString("nombre_us")).append("</b></td>");
                html.append("<td>").append(rs.getString("accion")).append("</td>");
                html.append("<td>").append(rs.getString("detalle")).append("</td>");
                html.append("<td>").append(rs.getTimestamp("fecha")).append("</td>");
                html.append("</tr>");
            }
            if(con.getConexion() != null) con.getConexion().close();
        } catch (Exception e) { html.append("<tr><td>Error: ").append(e.getMessage()).append("</td></tr>"); }
        html.append("</tbody></table></div>");
        return html.toString();
    }
}