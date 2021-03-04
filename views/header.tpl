<!DOCTYPE html>
<html lang="en">
<head>

<!-- Necessary resources for webpage to work -->

  <title>SWIFT Taskbook</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>-->


  <!-- Bootstrap -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <!-- End of Bootstrap -->


  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
  
  <!-- w3 css -->
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  
  
  
  <link rel="icon" href="/static/5.png">
  
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  <script>
  $( function() {
    $( "table" ).sortable(
    {
      items: "tr:not(.no-sort)",
      connectWith: ".tasks",
      placeholder: "placeholder",
      update: function(event) 
      {
	      list = this.id.replace("task-list-","");
	    },
      stop: function(event) 
      {
        if(typeof list == 'undefined')
          return;
        console.log("updating order for list:", list); 
        var reorder = $(document.getElementById("task-list-" + list)).sortable( "toArray" );
        var i = 1;
        reorder.forEach(function(order) 
        {
          var id = order.replace("task-","");
          api_update_task({'id':id, 'list':list, 'order':i}, 
                  function(result) { 
                    console.log(result);
                  } );
          i++;
        });
        get_current_tasks();
	    }
    });
  });
  </script>
  <style>

    html,body {
      background-color: #f6f8fa;
    }

    .navcolor {
      background-color: #ffffff;
    }
    .rcorners {
      border-radius: 25px;
      border: 2px solid #c5cbd3;
      padding-top: 25px;
      padding-bottom: 20px;
      padding-left: 20px;
      padding-right: 10px;
      margin-top: 30px;
      width: 100%;
      height: 100%;
    }

    .form-signin {
      width: 100%;
      max-width: 330px;
      margin: auto;
      padding-top: 100px;
      padding-bottom: 40px;
    }

    .form-signin .form-control {
      position: relative;
      box-sizing: border-box;
      height: auto;
      padding: 10px;
      font-size: 16px;
    }
    .form-signin .form-control:focus {
      z-index: 2;
    }
    .form-signin input[type="email"] {
      margin-bottom: -1px;
      border-bottom-right-radius: 0;
      border-bottom-left-radius: 0;
    }
    .form-signin input[type="password"] {
      margin-bottom: 10px;
      border-top-left-radius: 0;
      border-top-right-radius: 0;
    }

  </style>
</head>
<body>
