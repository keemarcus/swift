
<nav class="navbar navbar-expand-lg navbar-light navcolor">
  <div class="container-fluid">
    <a class="navbar-brand" href="./tasks"><img src="/static/4.png" style="height:34px;width:200px;" /></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="./tasks">Home</a>
        </li>
        <li class="nav-item" hidden>
          <a class="nav-link" href="#">About</a>
        </li>
         <li class="nav-item" hidden>
          <a class="nav-link" href="#">Features</a>
        </li>
         <li class="nav-item" hidden>
          <a class="nav-link" href="#">Pricing</a>
        </li>
         <li class="nav-item" hidden>
          <a class="nav-link" href="#">Contact Us</a>
        </li>
      </ul>
    </div>
    <div class="collapse navbar-collapse d-flex justify-content-end">
      <div id="loggedout">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link" href="./login">Login</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="./register">Sign Up</a>
          </li>
        </ul>
      </div>
      <div id="loggedin" hidden>
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li id="logged-user" class="navbar-text">
          </li>
          <li class="nav-item">
            <a id="lout" class="nav-link">Logout</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</nav>
