<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"
    import="com.productos.seguridad.Usuario, com.productos.seguridad.Bitacora" %>
<%
    // Seguridad: Solo Admin
    Integer perfil = (Integer) session.getAttribute("perfil");
    if (perfil == null || perfil != 1) { response.sendRedirect("login.jsp"); return; }

    String idUser = request.getParameter("id");
    
    if(idUser != null) {
        Usuario u = new Usuario();
        // Llamamos al método nuevo que borra todo
        u.eliminarUsuarioDefinitivo(idUser);

        // Registramos la acción en la bitácora (quien eliminó a quien)
        Bitacora b = new Bitacora();
        int idAdmin = (Integer) session.getAttribute("id_usuario");
        b.registrar(idAdmin, "ELIMINACIÓN", "El Admin eliminó permanentemente al usuario ID: " + idUser);
    }

    // Volver a la lista
    response.sendRedirect("admin_verUsuarios.jsp");
%>