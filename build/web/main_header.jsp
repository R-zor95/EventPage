
<%-- Document : main_header Created on : 13 Oct 2023, 01:09:14 Author : sortizu
--%> <%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="model.Tarjeta" %>
<%@page import="model.Evento" %>
<%@page import="DAO.TarjetaDAO" %>
<%@page import="DAO.EventoDAO" %>
<%@page import="DAO.CompraDAO" %>
<%@page import="DAO.UsuarioDAO" %>
<%@page import="debug.Console" %>
<%@page import="java.util.ArrayList" %>
<%
int id=-1;
String email;
String pass;
if(session.getAttribute("email")!=null && session.getAttribute("password")!=null){
email = (String)session.getAttribute("email");
pass = (String)session.getAttribute("password");  
id=new UsuarioDAO().validarUsuario(email, pass);
}
TarjetaDAO tarjetaDAO = new TarjetaDAO();
ArrayList<Tarjeta> tarjetasDeUsuario=new ArrayList<>();
if(id>=0){
  tarjetasDeUsuario = tarjetaDAO.cargarTarjetasDeUsuario(id);
}
%>
<!--Header-->
<div style="position: relative">
  <nav
    class="navbar navbar-default d-flex align-items-start"
    style="
      color: white;
      padding: 0px 50px;
      position: absolute;
      top: 0px;
      left: 0px;
      right: 0px;
      z-index: 10;
      min-width: 100%;
    "
  >
    <a
      href="index.jsp"
      class="m-auto m-sm-0"
      style="text-decoration: none; color: white"
    >
      <div
        class="card bg-danger"
        style="
          border: 0px;
          border-radius: 0px 0px 10px 10px;
          filter: opacity(0.9);
        "
      >
        <span class="narbar-brand h4 m-2 d-flex flex-row align-items-center justify-content-center" style="font-weight: 800;">
          <img src="${pageContext.request.contextPath}/img/logo/flavicon.svg" width="30px" style="color: white;" class="me-1"/>
          <%=nombrePagina%>
        </span>
      </div>
    </a>
    <div class="d-flex flex-row gap-2">
  <%  
    if (id>=0){
      %>
      <button
      type="button"
      class="btn btn-danger d-none d-lg-inline"
      data-bs-toggle="modal"
      data-bs-target="#profileModal"
      data-bs-whatever="@getbootstrap"
      style="
        min-width: 125px;
        height: 30px;
        margin: 0px;
        padding: 0px;
        gap: 0px;
        margin-top: 10px;
      "
    >
      <i class="bi bi-person-fill-gear"></i>
      Mi cuenta
    </button>
    <button
      type="button"
      class="btn btn-danger d-none d-lg-inline"
      data-bs-toggle="modal"
      data-bs-target="#shoppingModal"
      data-bs-whatever="@getbootstrap"
      style="
        min-width: 125px;
        height: 30px;
        margin: 0px;
        padding: 0px;
        gap: 0px;
        margin-top: 10px;
      "
    >
      <i class="bi bi-bag-fill"></i>
      Mis compras
    </button>

      <%
    }else{
      %>
      
      <button
        type="button"
        class="btn btn-danger d-none d-lg-inline"
        data-bs-toggle="modal"
        data-bs-target="#loginModal"
        data-bs-whatever="@getbootstrap"
        style="
          min-width: 125px;
          height: 30px;
          margin: 0px;
          padding: 0px;
          gap: 0px;
          margin-top: 10px;
        "
      >
      <i class="bi bi-box-arrow-in-right"></i>
        Acceder
      </button>
      <%
    }
    %>
      
      
    </div>
  </nav>
</div>

<!--Login modal-->
<div
  class="modal fade"
  id="loginModal"
  tabindex="-1"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Iniciar sesión</h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form action="UserLoginServlet" method="POST" id="userLoginForm">
          <div class="mb-3">
            <label for="login-email" class="col-form-label">Correo:</label>
            <input
              type="email"
              class="form-control modal-form-input"
              id="login-email"
              name="login-email"
              required
            />
          </div>
          <div class="mb-3">
            <label for="login-password" class="col-form-label"
              >Contraseña:</label
            >
            <input
              type="password"
              class="form-control modal-form-input"
              id="login-password"
              name="login-password"
              maxlength="45"
              required
            />
          </div>
          <div class="form-check m-2">
            <input
              type="checkbox"
              class="form-check-input"
              id="exampleCheck1"
            />
            <label class="form-check-label" for="exampleCheck1"
              >Recuerda mi sesión</label
            >
          </div>
          <center>
            <p>¿Aun no tienes una cuenta?</p>
            <button
              type="button"
              class="btn btn-outline-secondary w-50"
              data-bs-toggle="modal"
              data-bs-target="#registerModal"
              data-bs-whatever="@getbootstrap"
            >
              Registrarme
            </button>
          </center>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Cancelar
        </button>
        <button type="submit" class="btn btn-outline-danger" form="userLoginForm">Acceder</button>
      </div>
    </div>
  </div>
</div>
<!--Register modal-->
<div
  class="modal fade"
  id="registerModal"
  tabindex="-1"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Registro</h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3">
            <label for="event-name" class="col-form-label">Nombres:</label>
            <input
              type="text"
              class="form-control modal-form-input"
              id="event-name"
              maxlength="45"
              required
            />
          </div>
          <div class="mb-3">
            <label for="event-name" class="col-form-label">Apellidos:</label>
            <input
              type="text"
              class="form-control modal-form-input"
              id="event-name"
              maxlength="45"
              required
            />
          </div>
          <div class="mb-3">
            <label for="event-name" class="col-form-label">Email:</label>
            <input
              type="email"
              class="form-control modal-form-input"
              id="event-name"
              maxlength="45"
              required
            />
          </div>
          <div class="mb-3">
            <label for="event-name" class="col-form-label">Contraseña:</label>
            <input
              type="password"
              class="form-control modal-form-input"
              id="event-name"
              maxlength="45"
              required
            />
          </div>
          <div class="mb-3">
            <label for="event-name" class="col-form-label">DNI:</label>
            <input
              type="number"
              class="form-control modal-form-input"
              id="event-name"
              minlength="9"
              min="0"
              required
            />
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Cancelar
        </button>
        <button type="button" class="btn btn-outline-danger">
          Registrarme
        </button>
      </div>
    </div>
  </div>
</div>
<!--Profile modal-->
<div
  class="modal fade"
  id="profileModal"
  tabindex="-1"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Mi cuenta</h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <!--Formulario de datos personales-->
        <h4>Datos personales</h4>
        <form class="mb-5 d-flex flex-column">
          <div class="mb-3 d-flex align-items-start flex-column">
            <label for="event-name" class="col-form-label">Nombres:</label>
            <input
              type="text"
              class="form-control modal-form-input"
              id="event-name"
              maxlength="45"
              required
            />
          </div>
          <div class="mb-3 d-flex align-items-start flex-column">
            <label for="event-name" class="col-form-label">Apellidos:</label>
            <input
              type="text"
              class="form-control modal-form-input"
              id="event-name"
              maxlength="45"
              required
            />
          </div>
          <div class="mb-3 d-flex align-items-start flex-column">
            <label for="event-name" class="col-form-label">DNI:</label>
            <input
              type="number"
              class="form-control modal-form-input"
              id="event-name"
              minlength="9"
              min="0"
              required
            />
          </div>
          <button type="button" class="btn btn-outline-danger align-self-end">
            Actualizar datos personales
          </button>
        </form>
        <!--Formulario de cambios de credenciales-->
        <h4>Mis credenciales</h4>
        <form class="mb-3 d-flex flex-column">
          <div class="mb-3 d-flex align-items-start flex-column">
            <label for="event-name" class="col-form-label">Email:</label>
            <input
              type="email"
              class="form-control modal-form-input"
              id="event-name"
              maxlength="45"
              required
            />
          </div>
          <div class="mb-3 d-flex align-items-start flex-column">
            <label for="event-name" class="col-form-label">Contraseña:</label>
            <input
              type="password"
              class="form-control modal-form-input"
              id="event-name"
              maxlength="45"
              required
            />
          </div>
          <button type="button" class="btn btn-outline-danger align-self-end">
            Actualizar credenciales
          </button>
        </form>
        <!--Otras opciones-->
        <h4>Otros ajustes</h4>
        <p></p>
        <button type="button" class="btn btn-outline-secondary w-100">
          Eliminar cuenta
        </button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Cancelar
        </button>
      </div>
    </div>
  </div>
</div>

<!--End of Profile modal-->
<!--Shopping modal-->
<div
  class="modal fade"
  id="shoppingModal"
  tabindex="-1"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
>
  <div
    class="modal-dialog modal-lg modal-dialog-scrollable"

  >
    <div class="modal-content" style="min-height: 600px">
      <div class="modal-body m-0 p-0 g-0 d-flex flex-colum">
        <div class="card text-center border-0 d-flex flex-column flex-grow-1">
          <div class="card-header flex-grow-0">
            <ul class="nav nav-tabs card-header-tabs d-flex">
              <li class="nav-item flex-fill" role="presentation">
                <button
                  class="nav-link active w-100"
                  id="home-tab"
                  data-bs-toggle="tab"
                  data-bs-target="#shoppingCart"
                  type="button"
                  role="tab"
                  aria-controls="home"
                  aria-selected="true"
                  style="color: gray"
                >
                  Carrito de compras
                </button>
              </li>
              <li class="nav-item tab-header flex-fill" role="presentation">
                <button
                  class="nav-link w-100"
                  id="profile-tab"
                  data-bs-toggle="tab"
                  data-bs-target="#shoppingHistory"
                  type="button"
                  role="tab"
                  aria-controls="profile"
                  aria-selected="false"
                  style="color: gray"
                >
                  Historial de compras
                </button>
              </li>
              <li class="nav-item tab-header flex-fill" role="presentation">
                <button
                  class="nav-link w-100"
                  id="contact-tab"
                  data-bs-toggle="tab"
                  data-bs-target="#paidMethods"
                  type="button"
                  role="tab"
                  aria-controls="contact"
                  aria-selected="false"
                  style="color: gray"
                >
                  Métodos de pago
                </button>
              </li>
            </ul>
          </div>
          <div class="card-body tab-content d-flex flex-column flex-grow-1">
            <div
              class="tab-pane fade show active flex-grow-1"
              id="shoppingCart"
              role="tabpanel"
              aria-labelledby="home-tab"
            >
              <div
                class="d-flex flex-column justify-content-between align-items-center"
              >
              <h4 style="font-weight: 100">CARRITO DE COMPRAS</h4>
              <p class="text-center">
                Llega hasta el final de la lista para comprar tu ticket
              </p>
                <table class="table table-none">
                  <thead>
                    <tr>
                      <th>NOMBRE DE EVENTO</th>
                      <th>FECHA</th>
                      <th>COSTO</th>
                    </tr>
                  </thead>
                  <tbody>
                    <%
                      EventoDAO eventoDAOCarrito = new EventoDAO();
                      CompraDAO compraDAOCarrito = new CompraDAO();
                      int idCompra = compraDAOCarrito.obtenerIdCompraPendiente(id);
                      double costoTotal = 0;
                      ArrayList<Evento> eventos = eventoDAOCarrito.cargarEventosDeCompra(idCompra);
                      for(Evento evento : eventos){
                        costoTotal+=evento.getCosto();
                    %>
                    <tr>
                      <td><%=evento.getNombreEvento()%></td>
                      <td><%=evento.getFecha()%></td>
                      <td><%=evento.getCosto()%></td>
                    </tr>
                    <%}%>
                  </tbody>
                </table>
                <div>
                  <div class="row mb-3">
                    <div class="col-12 col-sm-8">
                      <p class="text-start" style="font-size: 12px">
                        <i class="bi bi-info-circle"></i>
                        Si estas pagando para acceder a más de un evento, el
                        ticket que se generará será unico y podras usarlo para
                        acceder a todos los eventos que hayas comprado.
                        <br />
                        Para ver los tickets que has comprado debes ir a la
                        pestaña "Historial de compras".
                      </p>
                    </div>
                    <div
                      class="col-12 col-sm-4 d-flex justify-content-center align-items-center"
                    >
                      <button
                        type="button"
                        class="btn btn-outline-danger"
                        id="shoppingCartBuyButton"
                        <%if(eventos.size()==0){%>
                        disabled
                        <%}%>
                      >
                        <%if(eventos.size()>0){%>
                        COMPRAR TOTAL POR: $<%=costoTotal%>
                        <%}else{%>
                        NO TIENES EVENTOS EN EL CARRITO
                        <%}%>
                      </button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div
              class="tab-pane fade"
              id="shoppingHistory"
              role="tabpanel"
              aria-labelledby="profile-tab"
              
            >
              <h4 style="font-weight: 100">HISTORIAL DE COMPRAS</h4>
              <table class="table table-none">
                  <thead>
                    <tr>
                      <th>TICKET</th>
                      <th>FECHA DE COMPRA</th>
                      <th>DETALLE</th>
                    </tr>
                  </thead>
                  <tbody></tbody>
                </table>
            </div>
            <div
              class="tab-pane fade flex-grow-1 d-flex flex-column"
              id="paidMethods"
              role="tabpanel"
              aria-labelledby="contact-tab"
            >
            <h4  style="font-weight: 100">MIS MÉTODOS DE PAGO</h4>
            <table class="table table-none">
              <thead>
                <tr>
                  <th>NÚMERO DE TARJETA</th>
                  <th>FECHA DE VENCIMIENTO</th>
                  <th>DETALLE</th>
                </tr>
              </thead>
              <tbody>
                <%
                    for(Tarjeta tarjeta : tarjetasDeUsuario){
                  %>
                <tr>
                  <td><%="*".repeat(12)+tarjeta.getNumeroTarjeta().substring(11,15)%></td>
                  <td><%=tarjeta.getFechaDeVencimiento()%></td>
                  <td>
                    <div>
                      <button type="button" class="btn btn-secondary detail-table-button">
                        <i class="bi bi-pencil-fill"></i>
                      </button>
                      <button type="button" class="btn btn-dark detail-table-button">
                        <i class="bi bi-trash-fill"></i>
                      </button>
                    </div>
                  </td>
                </tr>
                <%}%>
              </tbody>
            </table>
              <button type="button" class="btn btn-outline-danger mx-auto mt-auto" id="addCreditCard">
                Agregar tarjeta
              </button>
            
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--Ticket Detail Modal-->
<div
  class="modal fade"
  id="ticketDetailModal"
  tabindex="-1"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">
          Detalle de ticket
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <center>
          <h4 id="ticketDetailID">TICKET #76391</h4>
          <img
            src="https://upload.wikimedia.org/wikipedia/commons/d/d0/QR_code_for_mobile_English_Wikipedia.svg"
            alt="qr code"
          />
          <p>OFRECE ACCESO A LOS SIGUIENTES EVENTOS:</p>
          <div class="row mx-2" id="ticketEventList">
          </div>
          <h5 id="ticketDetailDate">Fecha: Jue 10 Ago - 7:00</h5>
          <h5 id="ticketDetailCost">Costo: $20.00</h5>
        </center>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Descargar
        </button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Aceptar
        </button>
      </div>
    </div>
  </div>
</div>
<!--Base modal for event-->
<div
  class="modal fade"
  id="eventDetailModal"
  tabindex="-1"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">Detalle de evento</h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-12">
            <img src="${pageContext.request.contextPath}/img/events_images/" 
                alt="Foto de evento" 
                style="width: 100%;"
                id="eventDetailImage"
                onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/img/placeholders/no_image.jpg'">
          </div>
        </div>
        <div class="row mt-3">
          <div class="col-12 col-md-8">
            <h4 id="detailEventName">TITULO EVENTO</h4>
            <p id="detailEventDescription">Lorem, ipsum dolor sit amet consectetur adipisicing elit. Soluta, amet! Numquam vel hic quidem consectetur accusantium dolorem beatae culpa repellendus, animi veniam? Voluptatibus placeat harum amet obcaecati aliquam inventore esse, eius fugiat provident perspiciatis assumenda magnam earum enim animi sit ipsa facere itaque magni perferendis veniam! Rerum aut dolor autem.</p>
          </div>
          <div class="col-12 col-md-4">
            <h4>COSTO</h4>
            <p id="detailEventCost">$20.00</p>
            <h4>CAPACIDAD</h4>
            <p id="detailEventCapacity">50 personas</p>
            <h4>FECHA</h4>
            <p id="detailEventDate">Jue 10 Ago - 7:00</p>
          </div>
        </div>
        
      </div>
      <div class="modal-footer">
        <div class="row">
          <div class="col-12 col-lg-6">
            <p style="font-size: 12px;"><i class="bi bi-info-circle"></i>
              La opcion "Agregar al carrito" te permite crear una lista de eventos que deseas comprar, para luego pagarlos todos juntos
              y tener un ticket unico para acceder a todos.
              Si solo deseas tener acceso a este evento, puedes usar la opcion "Comprar y generar ticket".
            </p>
          </div>
          <div class="col-12 col-lg-3">
            <button type="button" id="addToCart" class="btn btn-secondary w-100 mb-3" data-bs-dismiss="modal">
              AGREGAR AL CARRITO
            </button>
          </div>
          <div class="col-12 col-lg-3">
            <button
                        type="button"
                        class="btn btn-outline-danger w-100"
                        id="buyEventButton"
                      >
                        COMPRAR Y GENERAR TICKET
                      </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--Credit card selection-->
<div
  class="modal fade"
  id="creditCardSelectionModal"
  tabindex="-1"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">
          Método de pago
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form id="creditCardSelectionForm" method="POST" action="">
          <div class="mb-3">
            <label for="event-label" class="col-form-label"
              >Tarjeta de crédito:</label
            >
            <select
              id="event-label"
              name="event-label"
              class="form-select modal-form-input"
              aria-label="Default select example"
              required
            >
              <option value="" selected>
                Seleccione una de sus tarjetas
              </option>

              <%
              for(Tarjeta tarjeta : tarjetasDeUsuario){
            %>
              <option value='<%=tarjeta.getIdTarjeta()%>'><%="*".repeat(12)+tarjeta.getNumeroTarjeta().substring(11,15)%></option>
            <%}%>
            </select>
          </div>
          <div class="mb-3">
            <label for="ccv" class="col-form-label"
              >Ingrese el código CCV de su tarjeta:</label
            >
            <input
              type="number"
              class="form-control modal-form-input"
              id="ccv"
              name="ccv"
              required
            />
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
          Cancelar
        </button>
        <button type="button" class="btn btn-secondary" id="continueButton">
          Guardar
        </button>
      </div>
    </div>
  </div>
</div>
<!--Add credit card modal-->
<div
  class="modal fade"
  id="addCreditCardModal"
  tabindex="-1"
  aria-labelledby="exampleModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">
          Agregar tarjeta de crédito
        </h1>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="modal"
          aria-label="Close"
        ></button>
      </div>
      <div class="modal-body">
        <form id="addCreditCardForm" method="POST" action="TarjetaServlet">
          <div class="mb-3">
            <label for="card-number" class="col-form-label"
              >Número de tarjeta:</label
            >
            <input
              type="text"
              class="form-control"
              id="card-number"
              name="card-number"
              maxlength="16"
              minlength="16"
              required
            />
          </div>
          <div class="mb-3">
            <label for="expiration-date" class="col-form-label"
              >Fecha de vencimiento:</label
            >
            <input
              type="month"
              class="form-control modal-form-input"
              id="expiration-date"
              name="expiration-date"
              required
            />
          </div>
          <div class="mb-3">
            <label for="card-owner" class="col-form-label"
              >Nombre de propietario de tarjeta:</label
            >
            <input
              type="text"
              class="form-control modal-form-input"
              id="card-owner"
              name="card-owner"
              maxlength="150"
              required
            />
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="returnFromCreditCard">
          Volver
        </button>
        <button type="submit" class="btn btn-outline-danger" id="saveCreditCard" form="addCreditCardForm">
          Guardar
        </button>
      </div>
    </div>
  </div>
</div>
<%@include file="credit_card_script.jsp" %>
<!--End of Header-->


<!--Scripts-->
<script>
  $(document).ready(function () {
  var selectedEventId = -1;   
    //Function to show the modal to select the credit card before buying the ticket
        $("#buyEventButton, #shoppingCartBuyButton").click(function(){
            
            $("#eventDetailModal").modal("hide");
            $("#shoppingModal").modal("hide");
            $("#creditCardSelectionModal").modal("show");
        });
        $("#addToCart").click(function(){
            $("#addToCart").attr("disabled", true);
            $.ajax({
                url: "AgregarACarritoServlet",
                type: "POST",
                data: {"id":$("#eventDetailModal").attr("data-id")},
                success: function (response) {
                    $("#addToCart").attr("disabled", false);
                    
                },
                error: function (error) {
                    //$("#addToCart").attr("disabled", false);
                    //window.alert(error.responseText);
                }
            });
        });
        $("#buyEventButton").click(function(){
            $("#buyEventButton").attr("disabled", true);
            selectedEventId=$("#eventDetailModal").attr("data-id");
        });
        $("#continueButton").click(function(){
          if(selectedEventId>0){
            $.ajax({
                url: "CompraEventoServlet",
                type: "POST",
                data: {"id":selectedEventId,"id_tarjeta":$("#event-label").val(),"ccv":$("#ccv").val()},
                success: function (response) {
                  $("#creditCardSelectionModal").modal("hide");
                  updateTicketDetailModal(response);
                  selectedEventId=-1;
                },
                error: function (response) {
                  
                }
            });
          } else{
            $.ajax({
                url: "CompraCarritoServlet",
                type: "POST",
                data: {"id_tarjeta":$("#event-label").val()},
                success: function (response) {
                  $("#creditCardSelectionModal").modal("hide");
                  updateTicketDetailModal(response);
                },
                error: function (response) {
                  
                }
            });
          }
            
        });
        function updateTicketDetailModal(jsonData){
          $("#ticketEventList").html("");
          $("#ticketDetailID").text(
            "CÓDIGO DE TICKET: "+
            jsonData["compra"]["fecha_compra"].split("T")[0].replaceAll("-","")+
            "-"+
            jsonData["compra"]["id_compra"]+
            "-"+
            jsonData["compra"]["id_usuario"]);
          $("#ticketDetailDate").text(
            "Fecha de compra: "+
            jsonData["compra"]["fecha_compra"].split("T")[0]
            );
          var costoTotal = 0;
          for(var id in jsonData["eventos"]){
          var evento = jsonData["eventos"][id];
          var previousHTML = $("#ticketEventList").html();
          costoTotal+=parseFloat(evento["costo"]);
          $("#ticketEventList").html(
            previousHTML+
            "<p class='col-8'>"+evento["nombre_evento"]+"</p>"+
            "<p class='col-4'>"+evento["costo"]+"</p>"
          );
          }
          
          $("#ticketDetailCost").text("Costo total: $"+costoTotal);
          $("#ticketDetailModal").modal("show");
        }
    });
</script>