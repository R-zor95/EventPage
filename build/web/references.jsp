<%@page import="DAO.ConfiguracionDAO" %>
<%@page import="model.Configuracion" %>
<%
ConfiguracionDAO configuracionDAO = new ConfiguracionDAO();
String nombrePagina = configuracionDAO.cargarValorDeParametro("nombre_pagina");
String descripcionPagina = configuracionDAO.cargarValorDeParametro("descripcion_pagina");
String eslogan = configuracionDAO.cargarValorDeParametro("eslogan");
%>
<%@ page contentType="text/html; charset=UTF-8" %>
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/logo/flavicon.svg">
<!-- Bootstrap CSS -->
<link
href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
rel="stylesheet"
integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
crossorigin="anonymous"
/>
<!-- jQuery library-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script
src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
crossorigin="anonymous"
></script>

<!--Iconos Bootstrap-->
<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
