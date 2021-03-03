% include("header.tpl")
% include("banner.tpl")

<style>
    #gohome, #log-in {cursor: pointer;}
</style>

<div class="container" width="50%">
    <div class="col d-flex justify-content-center">
        <div>
            <h2 class="d-flex">Login</h2>
            <p class="hint-text">Enter username and password into the text fields below.</p>
            <p id="failed" class="hint-text" style="color:red;" hidden>No account with that username and password combination</p>
            <div class="form-group">
                <div class="row">
                    <div class="col col-md-auto"><input id="uname" type="text" class="form-control" name="username" placeholder="Username" required="required" style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAASCAYAAABSO15qAAAAAXNSR0IArs4c6QAAAPhJREFUOBHlU70KgzAQPlMhEvoQTg6OPoOjT+JWOnRqkUKHgqWP4OQbOPokTk6OTkVULNSLVc62oJmbIdzd95NcuGjX2/3YVI/Ts+t0WLE2ut5xsQ0O+90F6UxFjAI8qNcEGONia08e6MNONYwCS7EQAizLmtGUDEzTBNd1fxsYhjEBnHPQNG3KKTYV34F8ec/zwHEciOMYyrIE3/ehKAqIoggo9inGXKmFXwbyBkmSQJqmUNe15IRhCG3byphitm1/eUzDM4qR0TTNjEixGdAnSi3keS5vSk2UDKqqgizLqB4YzvassiKhGtZ/jDMtLOnHz7TE+yf8BaDZXA509yeBAAAAAElFTkSuQmCC&quot;); background-repeat: no-repeat; background-attachment: scroll; background-size: 16px 18px; background-position: 98% 50%;"></div>
                </div>        	
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col col-md-auto"><input id="pword" type="password" class="form-control" name="password" placeholder="Password" required="required" style="background-image: url(&quot;data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAACIUlEQVQ4EX2TOYhTURSG87IMihDsjGghBhFBmHFDHLWwSqcikk4RRKJgk0KL7C8bMpWpZtIqNkEUl1ZCgs0wOo0SxiLMDApWlgOPrH7/5b2QkYwX7jvn/uc//zl3edZ4PPbNGvF4fC4ajR5VrNvt/mo0Gr1ZPOtfgWw2e9Lv9+chX7cs64CS4Oxg3o9GI7tUKv0Q5o1dAiTfCgQCLwnOkfQOu+oSLyJ2A783HA7vIPLGxX0TgVwud4HKn0nc7Pf7N6vV6oZHkkX8FPG3uMfgXC0Wi2vCg/poUKGGcagQI3k7k8mcp5slcGswGDwpl8tfwGJg3xB6Dvey8vz6oH4C3iXcFYjbwiDeo1KafafkC3NjK7iL5ESFGQEUF7Sg+ifZdDp9GnMF/KGmfBdT2HCwZ7TwtrBPC7rQaav6Iv48rqZwg+F+p8hOMBj0IbxfMdMBrW5pAVGV/ztINByENkU0t5BIJEKRSOQ3Aj+Z57iFs1R5NK3EQS6HQqF1zmQdzpFWq3W42WwOTAf1er1PF2USFlC+qxMvFAr3HcexWX+QX6lUvsKpkTyPSEXJkw6MQ4S38Ljdbi8rmM/nY+CvgNcQqdH6U/xrYK9t244jZv6ByUOSiDdIfgBZ12U6dHEHu9TpdIr8F0OP692CtzaW/a6y3y0Wx5kbFHvGuXzkgf0xhKnPzA4UTyaTB8Ph8AvcHi3fnsrZ7Wore02YViqVOrRXXPhfqP8j6MYlawoAAAAASUVORK5CYII=&quot;); background-repeat: no-repeat; background-attachment: scroll; background-size: 16px 18px; background-position: 98% 50%; cursor: auto;"></div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <div class="col col-md-auto">
                        <button id="log-in" type="button" class="btn btn-success">Login</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // create session for current user

    function create_session(user){
        sessionStorage.setItem("username", user.username);
        sessionStorage.setItem("userid", user.userId);
        
        console.log("created session for: ", sessionStorage.getItem("username"));
    }

    // functions to manage users

    function api_get_users(success_function){
        $.ajax({url:'/api/users', type:"GET",
            success:success_function});
    }

    function login(username, password){
        api_get_users(function(result) {
            for (const user of result.users){
                if (username == user.username && password == user.password){
                    create_session(user);
                    console.log("logged in as: ", user);
                    window.location.href = "./tasks";
                    return;
                }
            }
            $("#failed").prop('hidden', false);
            console.log("login failed");
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
