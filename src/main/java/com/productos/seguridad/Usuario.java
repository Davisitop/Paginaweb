package com.productos.seguridad;

import java.sql.ResultSet;
import java.util.regex.Pattern; // Importar para validar regex
import com.productos.datos.Conexion; 

public class Usuario {

    private Integer id;
    private Integer perfil;
    private int estadoCuenta;
    private String nombre;
    private String correo;
    private String clave;
    private String cedula; // Agregado para mostrar en perfil

    // Getters y Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getPerfil() { return perfil; }
    public void setPerfil(Integer perfil) { this.perfil = perfil; }
    public int getEstadoCuenta() { return estadoCuenta; }
    public void setEstadoCuenta(int estadoCuenta) { this.estadoCuenta = estadoCuenta; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
    public String getClave() { return clave; }
    public void setClave(String clave) { this.clave = clave; }
    public String getCedula() { return cedula; }
    public void setCedula(String cedula) { this.cedula = cedula; }

    // Verificar Login
    public boolean verificarUsuario(String ncorreo, String nclave) {
        boolean respuesta = false;
        String sql = "SELECT * FROM tb_usuario WHERE correo_us='" + ncorreo + "' AND clave_us='" + nclave + "'";
        Conexion con = new Conexion();
        try {
            ResultSet rs = con.Consulta(sql);
            if (rs.next()) {
                this.setEstadoCuenta(rs.getInt("estado_cuenta"));
                this.setId(rs.getInt("id_us"));
                this.setNombre(rs.getString("nombre_us"));
                this.setPerfil(rs.getInt("id_per"));
                this.setCorreo(rs.getString("correo_us"));
                this.setCedula(rs.getString("cedula_us"));
                respuesta = true;
            }
            if(con.getConexion() != null) con.getConexion().close();
        } catch (Exception e) { e.printStackTrace(); }
        return respuesta;
    }

    // Registrar Usuario con VALIDACIONES
    public String ingresarUsuario(String nombre, String cedula, String correo, String clave) {
        
        // 1. Validar longitud de contraseña
        if (clave == null || clave.length() < 8) {
            return "Error: La contraseña debe tener al menos 8 caracteres.";
        }

        // 2. Validar formato de correo (Regex simple)
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        if (correo == null || !Pattern.matches(emailRegex, correo)) {
            return "Error: El formato del correo no es válido.";
        }

        // 3. Insertar si pasa las validaciones
        String sql = "INSERT INTO tb_usuario (nombre_us, cedula_us, correo_us, clave_us, id_per, id_est, estado_cuenta) " +
                     "VALUES ('" + nombre + "', '" + cedula + "', '" + correo + "', '" + clave + "', 2, 1, 1)";
        
        Conexion con = new Conexion();
        String msg = "Exito";
        try {
            String resultado = con.Ejecutar(sql);
            if (resultado.contains("error") || resultado.contains("Error")) {
                msg = "Error: El correo o la cédula ya podrían estar registrados.";
            }
            if(con.getConexion() != null) con.getConexion().close();
        } catch (Exception e) { 
            msg = "Error: " + e.getMessage(); 
        }
        return msg;
    }

    // Método para obtener datos completos por ID (para Perfil y Edición)
    public Usuario obtenerUsuarioPorId(String id) {
        Usuario u = null;
        String sql = "SELECT * FROM tb_usuario WHERE id_us=" + id;
        Conexion con = new Conexion();
        try {
            ResultSet rs = con.Consulta(sql);
            if (rs.next()) {
                u = new Usuario();
                u.setId(rs.getInt("id_us"));
                u.setNombre(rs.getString("nombre_us"));
                u.setCorreo(rs.getString("correo_us"));
                u.setClave(rs.getString("clave_us"));
                u.setCedula(rs.getString("cedula_us"));
                u.setPerfil(rs.getInt("id_per"));
            }
            if(con.getConexion() != null) con.getConexion().close();
        } catch(Exception e){}
        return u;
    }

    // Reporte Usuarios, Actualizar y Eliminar se mantienen igual...
    // (Incluye aquí el resto de métodos: reporteUsuarios, actualizarUsuario, eliminarUsuarioDefinitivo tal como estaban)
    // ...
    // Para ahorrar espacio, asumo que mantienes los métodos reporteUsuarios, actualizarUsuario y eliminarUsuarioDefinitivo del paso anterior.
    
    public String reporteUsuarios() {
        String sql = "SELECT id_us, nombre_us, correo_us, clave_us FROM tb_usuario WHERE id_per = 2 ORDER BY id_us ASC";
        Conexion con = new Conexion();
        StringBuilder tabla = new StringBuilder();
        try {
            ResultSet rs = con.Consulta(sql);
            tabla.append("<table class='table table-bordered table-hover'>");
            tabla.append("<thead class='table-dark'><tr><th>ID</th><th>Nombre</th><th>Correo</th><th>Contraseña</th><th>Acciones</th></tr></thead><tbody>");
            while (rs.next()) {
                int id = rs.getInt("id_us");
                String claveOculta = rs.getString("clave_us").replaceAll(".", "*");
                tabla.append("<tr>");
                tabla.append("<td>").append(id).append("</td>");
                tabla.append("<td>").append(rs.getString("nombre_us")).append("</td>");
                tabla.append("<td>").append(rs.getString("correo_us")).append("</td>");
                tabla.append("<td>").append(claveOculta).append("</td>");
                tabla.append("<td>");
                tabla.append("<a href='admin_editarUsuario.jsp?id=").append(id).append("' class='btn btn-warning btn-sm me-2'><i class='fas fa-edit'></i> Editar</a>");
                tabla.append("<a href='admin_eliminarUsuario.jsp?id=").append(id).append("' onclick=\"return confirm('¿Seguro eliminar?');\" class='btn btn-danger btn-sm'><i class='fas fa-trash-alt'></i> Eliminar</a>");
                tabla.append("</td></tr>");
            }
            if(con.getConexion() != null) con.getConexion().close();
        } catch (Exception e) { return "Error: " + e.getMessage(); }
        tabla.append("</tbody></table>");
        return tabla.toString();
    }
    
    public String actualizarUsuario(String id, String nombre, String correo, String clave, int perfil) {
        String sql = "UPDATE tb_usuario SET nombre_us='"+nombre+"', correo_us='"+correo+"', clave_us='"+clave+"', id_per="+perfil+" WHERE id_us="+id;
        Conexion con = new Conexion();
        String res = con.Ejecutar(sql);
        try { if(con.getConexion() != null) con.getConexion().close(); } catch(Exception e){}
        return res;
    }

    public void eliminarUsuarioDefinitivo(String id) {
        Conexion con = new Conexion();
        try {
            con.Ejecutar("DELETE FROM tb_deseos WHERE id_usuario=" + id);
            con.Ejecutar("DELETE FROM tb_bitacora WHERE id_usuario=" + id);
            con.Ejecutar("DELETE FROM tb_usuario WHERE id_us=" + id);
            if(con.getConexion() != null) con.getConexion().close();
        } catch(Exception e) { e.printStackTrace(); }
    }
}