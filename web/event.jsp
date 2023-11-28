<%@page import="DAO.InvitadoDAO" %>
<%@page import="model.Invitado" %>
<%@page import="DAO.CategoriaEventoDAO" %>
<%@page import="model.CategoriaEvento" %>
<%@page import="DAO.EventoDAO" %>
<%@page import="model.Evento" %>
<%@page import="java.util.ArrayList" %>
<% 
//Estas variables se deben de cambiar en el jsp de cada pagina 
//En teoria solo con estas variables se puede definir a qué servlet se le hará la petición
String apiLink = "EventoServlet"; //Aqui se debe de poner la ruta de la servlet que agrega 
String pageElementName = "evento"; //Aqui se debe de poner el nombre del elemento que se está manejando en la pagina 
String pageElementPluralName = "eventos"; //Aqui se debe de poner el nombre del elemento que se está manejando en la pagina 
%>
<%@include file="admin_validation.jsp" %>
<!DOCTYPE html>
<html lang="es">
  <head>
    <%@ page contentType="text/html; charset=UTF-8" %>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Eventos</title>
    <%@include file="references.jsp" %>
  </head>
  <body class="vh-100 bg-light">
    <div class="container-fluid h-100 d-flex flex-column">
      <%@include file="header.jsp" %>
      <!--Page Content-->
      <div class="row flex-grow-1 mb-3 flex-column flex-md-row m-auto w-100">
        <%@include file="sidebar.jsp" %>
        <!-- Main Content -->
        <%@include file="crud_main_content_header.jsp" %>
        <thead>
          <tr>
            <th scope="col">id</th>
            <th scope="col">Portada</th>
            <th scope="col">Titulo</th>
            <th scope="col">Invitado</th>
            <th scope="col">Fecha</th>
            <th scope="col">Categorí­a</th>
            <th scope="col">Capacidad</th>
            <th scope="col">Costo ($)</th>
          </tr>
        </thead>
        <tbody>
          <%
            EventoDAO eventoDao = new EventoDAO();
            CategoriaEventoDAO categoriaDeEventoDao = new CategoriaEventoDAO();
            InvitadoDAO invitadoDeEventoDao = new InvitadoDAO();
            ArrayList<Evento> eventos = (ArrayList<Evento>)eventoDao.listAll();
            for(Evento evento : eventos){
            Invitado invitadoDeEvento=(Invitado)invitadoDeEventoDao.list(evento.getIdInvitado());
            CategoriaEvento categoriaDeEvento=(CategoriaEvento)categoriaDeEventoDao.list(evento.getIdCategoriaEvento());
          %>
            <tr data-id='<%=evento.getIdEvento()%>'>
              <td value='<%=evento.getIdEvento()%>' name="id-row"><%=evento.getIdEvento()%></td>
              <td>
                <img src='<%=evento.getImagenUrl()%>'
                alt="Foto de evento" 
                style="width: 150px;"
                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/placeholders/no_image.jpg'">
              </td>
              <td value='<%=evento.getNombreEvento()%>' name="event-name"><%=evento.getNombreEvento()%></td>
              <td value='<%=evento.getDescripcion()%>' name="event-description" hidden><%=evento.getDescripcion()%></td>
              <td value='<%=invitadoDeEvento!=null?evento.getIdInvitado():0%>' name="event-guest">
                <%if(invitadoDeEvento==null){%>
                <i class="bi bi-exclamation-triangle-fill" style="color:goldenrod;"></i>
                <%}else{%>
                <%=invitadoDeEvento.getNombres()+" "+invitadoDeEvento.getApellidos()%>
                <%}%>
              </td>
              <td value='<%=evento.getFecha()%>' name="event-date"><%=evento.getFecha()%></td>
              <td value='<%=categoriaDeEvento!=null?evento.getIdCategoriaEvento():0%>' name="event-label">
                <%if(categoriaDeEvento==null){%>
                <i class="bi bi-exclamation-triangle-fill" style="color:goldenrod;"></i>
                <%}else{%>
                <%=categoriaDeEvento.getNombreCategoria()%>
                <%}%>
              </td>
              <td value='<%=evento.getCapacidad()%>' name="event-capacity"><%=evento.getCapacidad()%></td>
              <td value='<%=evento.getCosto()%>' name="event-price"><%=evento.getCosto()%></td>
              <td value='<%=evento.isDestacado()?"1":"0"%>' name="featured" hidden><%=evento.isDestacado()%></td>
            </tr>
          <%}%>
        </tbody>
        <%@include file="crud_main_content_footer.jsp" %>
      </div>
      <!--End of Page Content-->
      <!--Main Modal-->
      <%@include file="main_modal_header.jsp" %>
      <!--Esto es el formulario que se usa tanto para añadir o editar-->
      <form id="mainForm" method="POST" action='<%=apiLink%>' enctype="multipart/form-data">
        <input type="text" value="" class="modal-form-input" id="id-row" name="id-row" hidden>
        <div class="mb-3">
          <label for="event-name" class="col-form-label"
            >Tí­tulo de evento:</label
          >
          <input
            type="text"
            class="form-control modal-form-input"
            id="event-name"
            name="event-name"
            maxlength="45"
            required
          />
        </div>
        
        <div class="mb-3">
          <label for="event-description" class="col-form-label"
            >Descripción:</label
          >
          <textarea
            class="form-control modal-form-input form-input-ignore"
            id="event-description"
            name="event-description"
            required
          ></textarea>
        </div>
        <div class="mb-3">
          <label for="event-guest" class="col-form-label"
            >Invitado que presentará evento:</label
          >
          <select
            id="event-guest"
            name="event-guest"
            class="form-select modal-form-input"
            aria-label="Default select example"
            required
          >
            <option value="" selected>
              Selecciona un invitado
            </option>
            <%
          InvitadoDAO listaDeInvitadosDao = new InvitadoDAO();
            ArrayList<Invitado> listaDeInvitados = (ArrayList<Invitado>)listaDeInvitadosDao.listAll();
            for(Invitado invitado : listaDeInvitados){
          %>
            <option value='<%=invitado.getIdInvitado()%>'><%=invitado.getNombres()+" "+invitado.getApellidos()%></option>
          <%}%>
          </select>
        </div>
        <div class="mb-3">
          <label for="event-date" class="col-form-label"
            >Fecha de evento:</label
          >
          <input
            type="datetime-local"
            class="form-control modal-form-input"
            id="event-date"
            name="event-date"
            required
          />
        </div>

        <div class="mb-3">
          <label for="event-label" class="col-form-label"
            >Categoría de evento:</label
          >
          <select
            id="event-label"
            name="event-label"
            class="form-select modal-form-input"
            aria-label="Default select example"
            required
          >
            <option value="" selected>
              Selecciona una categorí­a de evento
            </option>
            <%
          CategoriaEventoDAO listaDeCategoriasDao = new CategoriaEventoDAO();
            ArrayList<CategoriaEvento> listaDeCategorias = (ArrayList<CategoriaEvento>)listaDeCategoriasDao.listAll();
            for(CategoriaEvento categoriaEvento : listaDeCategorias){
          %>
            <option value='<%=categoriaEvento.getIdCategoriaEvento()%>'><%=categoriaEvento.getNombreCategoria()%></option>
          <%}%>
          </select>
        </div>
        <div class="mb-3">
          <label for="event-capacity" class="col-form-label"
            >Capacidad de evento:</label
          >
          <input
            type="number"
            class="form-control modal-form-input"
            id="event-capacity"
            name="event-capacity"
            min="0"
            required
          />
        </div>
        <div class="mb-3">
          <label for="event-price" class="col-form-label"
            >Costo de entrada:</label
          >
          <div class="input-group">
            <span class="input-group-text">$</span>
            <input
              type="number"
              class="form-control modal-form-input"
              id="event-price"
              name="event-price"
              min="0"
              required
            />
          </div>
        </div>
        <div class="mb-3">
          <label for="event-image" class="col-form-label"
            >Portada del evento (.jpg):</label>
          <input type="file" name="event-image" class="form-control modal-form-input" id="event-image" accept=".jpg">
        </div>
        <div class="form-check">
          <input type="checkbox" class="form-check-input modal-form-input" id="featured" name="featured">
          <label class="form-check-label" for="featured">Mostrar como novedad destacada en página principal</label>
        </div>
        <input type="text" name="form-mode" id="form-mode" value="" hidden>
      </form>
      <%@include file="main_modal_footer.jsp" %>
      <!--End of add event modal-->
      <!--Confirm delete modal-->
      <%@include file="confirm_delete_modal.jsp" %>
    </div>
    <%@include file="sidebar_script.jsp" %> <%@include file="table_script.jsp"
    %>
  </body>
</html>
