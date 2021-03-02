<!DOCTYPE html>
<html lang="en">
<head>

  <!-- Necessary resources for webpage to work -->

  <title>SWIFT Taskbook</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

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
      padding-left: 10px;
      padding-right: 10px;
      margin-top: 30px;
      width: 100%;
      height: 100%;
    }

    


  </style>
</head>
<body>