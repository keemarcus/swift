% include("header.tpl")
% include("banner.tpl")

<div>
    <h1>LOGIN</h1>
    <input id="username"/>
    <input id="password"/>
    <label for="username">Username: </label>
    <label for="password">Password: </label>
    <input id="login" type="submit" value="LOGIN"/>
</div>
<div>
    <h1>SIGNUP</h1>
</div>

<script>
    // create session for current user

    function create_session(name){
        sessionStorage.setItem("user", name);
    }

    // functions to manage users

    function api_get_users(success_funtion){
        $.ajax({url:'/api/users', type:"GET",
            success:success_function});
    }

    function api_create_user(user, success_function){

    }

    // wire responses (on click)

    function login(username, password){
        api_get_users(function(result) {
            for (const user of result.users){
                if (username == user.username && password == user.password){
                    create_session(user.userId);
                }
            }
        });
    }

    function get_current_user(){
        api_get_users(function(result) {
            $("#login").on("click", login($("#username").val, $("#password").val))
        });
    }

    $(document).ready(function(){
        get_current_user();
    }

</script>

% include("footer.tpl")
