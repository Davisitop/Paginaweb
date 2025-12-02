<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.productos.seguridad.Usuario" %>
<%
    String nombre = request.getParameter("nombre");
    String cedula = request.getParameter("cedula");
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");

    Usuario u = new Usuario();
    // Llamamos al método que ahora valida longitud y formato
    String resultado = u.ingresarUsuario(nombre, cedula, correo, clave);

    if (resultado.startsWith("Error")) {
        // Si hay error, redirigir al registro con el mensaje
        response.sendRedirect("registro.jsp?msg=" + java.net.URLEncoder.encode(resultado, "UTF-8"));
    } else {
        // Si es exitoso, mostrar alerta y mandar al login
%>
        <script>
            alert("¡Registro exitoso! Ahora puedes iniciar sesión.");
            window.location = "login.jsp";
        </script>
<%
    }
%>