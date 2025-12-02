<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"
    import="com.productos.seguridad.Usuario, com.productos.seguridad.Bitacora" %>
<%
    // Seguridad
    Integer perfilSession = (Integer) session.getAttribute("perfil");
    if (perfilSession == null || perfilSession != 1) { response.sendRedirect("login.jsp"); return; }

    // Obtener datos del formulario (incluida la CLAVE)
    String id = request.getParameter("id");
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave"); // <--- Aquí capturamos la nueva contraseña
    int nuevoPerfil = Integer.parseInt(request.getParameter("perfil"));

    // Actualizar en base de datos
    Usuario u = new Usuario();
    u.actualizarUsuario(id, nombre, correo, clave, nuevoPerfil);

    // Bitácora
    Bitacora b = new Bitacora();
    b.registrar((Integer)session.getAttribute("id_usuario"), "EDICIÓN", "Actualizó datos del usuario ID: " + id);

    response.sendRedirect("admin_verUsuarios.jsp");
%>