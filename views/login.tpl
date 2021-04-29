% include("header.tpl")
% include("banner.tpl")

<style>
    #gohome, #log-in {cursor: pointer;}

</style>

<div class="form-signin">
    <h1 class="h3 mb-3 fw-normal">LOGIN</h1>
    <p class="hint-text">Enter username and password into the text fields below.</p>
    <p id="failed" class="hint-text" style="color:red;" hidden>No account with that username and password combination</p>
    <input id="uname" type="text" class="form-control" name="username" placeholder="Username" required autofocus><br>
    <input  id="pword" type="password" class="form-control" name="password" placeholder="Password" required>
    <button  id="log-in" class="w-100 btn btn-lg btn-success" type="button">Login</button>
    <p class="mt-2 mb-1 text-muted"> Not a member? <a href="./register">Sign Up Here</a></p>
    <p class="mt-2 mb-2 text-muted">&copy; 2021</p>
</div>
    
<script>
    // create session for current user

    function create_session(user){
        sessionStorage.setItem("username", user.username);
        sessionStorage.setItem("userid", user.id);
        
        console.log("created session for: ", sessionStorage.getItem("username"));
    }

    // functions to manage users

    function api_get_users(success_function){
        $.ajax({url:'/api/users', type:"GET",
            success:success_function});
    }

    function api_hash(salt, pass, success_function){
        console.log("fetching hash");
        saltpassword = {salt, pass}
        $.ajax({url:"/api/hash", type:"POST",
            data:JSON.stringify(saltpassword),
            contentType:"application/json; charset=utf-8",
            success:success_function});
    }

    function login(username, password){
        api_get_users(function(result) {
            for (const user of result.users){
                if (username == user.username){ // && password == user.password){
                    console.log("salt", user.salt, "pw", password);
                    api_hash(user.salt, password, function(result){ // call api hashing function to check user password
                        console.log(result.key)
                        if (user.password == result.key){
                            create_session(user);
                            console.log("logged in as: ", user);
                            window.location.href = "./tasks";
                            return;
                        }
                        else {
                            $("#failed").prop('hidden', false);
                            console.log("login failed");
                            return;
                        }
                    });
                }
            }
        });
    }

    // wire responses (on click)

    function get_current_user(){
        console.log("waiting...");
        api_get_users(function(result) {
            console.log(result);
            $("#log-in").click(function(){
                login($("#uname").val(), $("#pword").val());
            });
        });
    }

    $(document).ready(function(){
        get_current_user();

        $("#gohome").click(function(){
            window.location.href = "./tasks";
        });
    });

</script>

% include("footer.tpl")
