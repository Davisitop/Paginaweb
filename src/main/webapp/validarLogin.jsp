<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" 
    import="com.productos.seguridad.Usuario, com.productos.seguridad.Bitacora" %>
<%
    String user = request.getParameter("usuario");
    String pass = request.getParameter("clave");

    Usuario u = new Usuario();
    boolean existe = u.verificarUsuario(user, pass);

    if (existe) {
        if (u.getEstadoCuenta() == 0) {
            response.sendRedirect("login.jsp?error=Usuario+BLOQUEADO.+Contacte+al+admin.");
            return;
        }
        session.setAttribute("usuario", u.getNombre());
        session.setAttribute("perfil", u.getPerfil());
        session.setAttribute("id_usuario", u.getId());

        Bitacora b = new Bitacora();
        b.registrar(u.getId(), "LOGIN", "Ingreso al sistema");

        response.sendRedirect("index.jsp");
    } else {
        response.sendRedirect("login.jsp?error=Credenciales+incorrectas");
    }
%>