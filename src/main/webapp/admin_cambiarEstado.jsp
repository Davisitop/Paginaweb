<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" import="com.productos.seguridad.Usuario, com.productos.seguridad.Bitacora" %>
<%
    Integer perfil = (Integer) session.getAttribute("perfil");
    if (perfil == null || perfil != 1) {
        response.sendRedirect("login.jsp");
        return;
    }

    String id = request.getParameter("id");
    int nuevoEstado = Integer.parseInt(request.getParameter("estado"));

    Usuario u = new Usuario();
    u.cambiarEstado(id, nuevoEstado);

    // Bitácora
    Bitacora b = new Bitacora();
    String accion = (nuevoEstado == 1) ? "DESBLOQUEO" : "BLOQUEO";
    b.registrar((Integer)session.getAttribute("id_usuario"), accion, "Usuario ID: " + id);

    response.sendRedirect("admin_verUsuarios.jsp");
%>