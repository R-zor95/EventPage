<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ page contentType="text/html; charset=UTF-8" %>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>EventPage | Invitados</title>
    <%@include file="references.jsp" %>
  </head>
  <body>
    <div class="container-fluid d-flex flex-column vh-100 g-0">
      <!--Header-->
      <%@include file="main_header.jsp" %>
      <!--End of Header-->
      <div class="row g-0">
        <!--TITULO DE PAGINA-->
        <h2 class="col-12 mt-5 d-flex justify-content-center gap-2" style="font-weight: 300;">
          <i class="bi bi-star-fill"></i>
          <i class="bi bi-chat-fill"></i>
          NUESTROS INVITADOS  
          <i class="bi bi-chat-fill"></i>
          <i class="bi bi-star-fill"></i>
        </h2>
        <div class="zig-zag"></div>
        <!--Featured guests-->
        <div class="col-12 g-0 mt-3" style="padding-bottom: 55px">
          <div class="row gap-2 " style="margin: 0px;  padding: 0px;">
            <%@page import="DAO.InvitadoDAO" %>
<%@page import="model.Invitado" %>
<%@page import="java.util.ArrayList" %>
            <%
              InvitadoDAO dao = new InvitadoDAO();
              ArrayList<Invitado> invitados = (ArrayList<Invitado>)dao.listAll();
              for(Invitado invitado : invitados){
            %>
            <!--Guest card-->
            <div
              class="col-12 col-sm-8 col-lg-6 d-flex justify-content-center align-items-start m-auto"
            >
              <div class="card" style="height: 350px;overflow: hidden;">
                <div class="row" style="width: 100%; height: 100%;">
                  <div class="col-md-8" style="height: 100%;">
                    <img src='<%=invitado.getImagenUrl()%>' 
                    alt="Foto de <%=invitado.getNombres()%>" 
                    style="width: 100%; height: 100%;"
                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/placeholders/no_image.jpg'">
                  </div>
                  <div class="col-md-4">
                    <div class="card-body">
                      <h5 class="card-title"><%=invitado.getNombres()%></h5>
                      <p class="card-text">
                        <%=invitado.getBiografia()%>
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!--End of guest card-->
            <%}%>
          </div>
        </div>
      </div>

      <!--Navigation bar-->
      <%@include file="navigation_bar.jsp" %>
    </div>
  </body>
</html>
