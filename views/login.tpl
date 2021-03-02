% include("header.tpl")
% include("banner.tpl")

<style>
    #gohome, #log-in {cursor: pointer;}
</style>

<div>
<form name="login">
<table>
    <tr>
        <td>
            <h1 class="w3-row w3-xxlarge w3-bottombar w3-border-black w3-margin-bottom">LOGIN</h1>
        </td>
    </tr>
</table>


<div id="failed-login" hidden>
    <p style="color:red;">
        Sorry, that account does not exist
    </p>
</div>

<table>
    <tr>
        <td>
            <label for="username">Username:</label>
        </td>
        <td>
            <input id="username"/>
        </td>
    </tr>
    <tr>
        <td>
            <label for="password">Password:</label>
        </td>
        <td>
            <input id="password" type="password"/>
        </td>
    </tr>
    <tr>
        <td>
            <input id="log-in" type="button" value="login"/>
        </td>
    </tr>
</table>
</form>
</div>

<script>
    // create session for current user

    function create_session(user){
        sessionStorage.setItem("username", user.username);
        sessionStorage.setItem("userid", user.userId);
        
        console.log("created session for: ", sessionStorage.getItem("user"));
    }

    // functions to manage users

    function api_get_users(success_function){
        $.ajax({url:'/api/users', type:"GET",
            success:success_function});
    }

    function api_create_user(user, success_function){

    }

    function login(username, password){
        api_get_users(function(result) {
            for (const user of result.users){
                if (username == user.username && password == user.password){
                    create_session(user);
                    console.log("logged in as: ", user);
                    window.location.href = "./tasks";
                }
                else {
                    $("#failed-login").prop('hidden', false);
                    console.log("login failed");
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
                login($("#username").val(), $("#password").val());
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
