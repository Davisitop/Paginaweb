<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"
    import="com.productos.seguridad.Usuario" %>
<%
    // Seguridad
    Integer perfil = (Integer) session.getAttribute("perfil");
    if (perfil == null || perfil != 1) { response.sendRedirect("login.jsp"); return; }

    String id = request.getParameter("id");
    Usuario u = new Usuario();
    Usuario datos = u.obtenerUsuarioPorId(id); // Trae los datos actuales
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="estilos3.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="form-admin card p-4 shadow">
                    <h3 class="text-center mb-4 text-warning">✏ Editar Usuario</h3>
                    
                    <form action="admin_procesarEditarUsuario.jsp" method="post">
                        <input type="hidden" name="id" value="<%= datos.getId() %>">
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Nombre Completo:</label>
                            <input type="text" name="nombre" class="form-control" value="<%= datos.getNombre() %>" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Correo Electrónico:</label>
                            <input type="email" name="correo" class="form-control" value="<%= datos.getCorreo() %>" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Contraseña:</label>
                            <input type="text" name="clave" class="form-control" value="<%= datos.getClave() %>" required>
                            <small class="text-muted">Modifica este campo para cambiar la contraseña.</small>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-bold">Perfil (Rol):</label>
                            <select name="perfil" class="form-select">
                                <option value="2" <%= datos.getPerfil() == 2 ? "selected" : "" %>>Usuario (Cliente)</option>
                                <option value="1" <%= datos.getPerfil() == 1 ? "selected" : "" %>>Administrador</option>
                            </select>
                        </div>

                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" class="btn btn-success">Guardar Cambios</button>
                            <a href="admin_verUsuarios.jsp" class="btn btn-secondary">Cancelar</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>