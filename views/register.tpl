% include("header.tpl")
% include("banner.tpl")

<div class="form-signin">
    <h1 class="h3 mb-3 fw-normal">REGISTER</h1>
    <p class="hint-text">Create your account. It's free and only takes a minute.</p>
    <p id="failed" class="hint-text" style="color:red;" hidden>No account with that username and password combination</p>
    <input id="uname" type="text" class="form-control" name="username" placeholder="Username" required autofocus><br>
    <input  id="pword-1" type="password" class="form-control" name="password" placeholder="Password" required>
    <input  id="pword-2" type="password" class="form-control" name="confirm_password" placeholder="Confirm Password" required>
    <button  id="new-user" class="w-100 btn btn-lg btn-success" type="button">Register</button>
    <p class="mt-2 mb-1 text-muted"> Already a member? <a href="./login">Login here</a></p>
    <p class="mt-2 mb-2 text-muted">&copy; 2021</p>
</div>
<script>

    function api_create_user(user, success_function){
        console.log("creating user: ", user);
        $.ajax({url:"/api/users", type:"POST",
            data:JSON.stringify(user),
            contentType:"application/json; charset=utf-8",
            success:success_function});
    }

    $(document).ready(function() {
        $("#new-user").click(function() {
            user = {username:$("#uname").val(), password:$("#pword-1").val()}
            api_create_user(user, function(){
                console.log("new user: ", user);
                window.location.href = "./login";
            });
        });
    });

</script>

% include("footer.tpl")
