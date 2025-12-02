<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"
    import="com.productos.seguridad.Usuario, com.productos.seguridad.Bitacora" %>
<%
    Integer perfil = (Integer) session.getAttribute("perfil");
    if (perfil == null || perfil != 1) { response.sendRedirect("login.jsp"); return; }

    String accion = request.getParameter("accion");
    int idUser = Integer.parseInt(request.getParameter("id"));
    Usuario u = new Usuario();
    Bitacora b = new Bitacora();
    int idAdmin = (Integer) session.getAttribute("id_usuario");

    if ("bloquear".equals(accion)) {
        u.cambiarEstado(idUser, 0); 
        b.registrar(idAdmin, "BLOQUEO", "Admin bloqueó usuario ID: " + idUser);
    } else if ("desbloquear".equals(accion)) {
        u.cambiarEstado(idUser, 1); 
        b.registrar(idAdmin, "DESBLOQUEO", "Admin desbloqueó usuario ID: " + idUser);
    }
    response.sendRedirect("admin_verUsuarios.jsp");
%>