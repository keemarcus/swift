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
    $( "table" ).sortable({
        items: "tr:not(.no-sort)",
        placeholder: "placeholder",
    });
  });
  </script>

</head>
<body>