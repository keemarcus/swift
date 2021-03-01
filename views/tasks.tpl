% include("header.tpl")
% include("banner.tpl")

<style>
  .save_edit, .undo_edit, .move_task, .description, .edit_task, .delete_task, .prio_task {
    cursor: pointer;
  }
  .completed {text-decoration: line-through;}
  .description { padding-left:8px }
  .placeholder { border: 1px solid black }
  td {white-space: nowrap}
</style>


<div class="row col-lg-12">

  <!-- Today -->
  <div class="col-sm-4">
    <div class="rcorners">
      <h1 style="text-align: center"><i><u>Today</u></i></h1>
      <table id="task-list-today" class="table table-borderless tasks">
      </table>
    </div>
  </div>
  
  <!-- Tomorrow -->
  <div class="col-sm-4">
    <div class="rcorners">
      <h1 style="text-align: center"><i><u>Tomorrow</u></i></h1>
      <table id="task-list-tomorrow" class="table table-borderless tasks">
      </table>
    </div>
  </div>

  <!-- Later -->
  <div class="col-sm-4">
    <div class="rcorners">
      <h1 style="text-align: center"><i><u>Later</u></i></h1>
      <table id="task-list-later" class="table table-borderless tasks">
      </table>
    </div>
  </div>
</div>

<input id="current_input" hidden value=""/> 

% include("footer_html.tpl")
<script>
/* API CALLS */

function api_get_tasks(success_function) {
  $.ajax({url:"api/tasks", type:"GET", 
          success:success_function});
}

function api_create_task(task, success_function) {
  console.log("creating task with:", task)
  $.ajax({url:"api/tasks", type:"POST", 
          data:JSON.stringify(task), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}

function api_update_task(task, success_function) {
  console.log("updating task with:", task)
  task.id = parseInt(task.id)
  $.ajax({url:"api/tasks", type:"PUT", 
          data:JSON.stringify(task), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}

function api_delete_task(task, success_function) {
  console.log("deleting task with:", task)
  task.id = parseInt(task.id)
  $.ajax({url:"api/tasks", type:"DELETE", 
          data:JSON.stringify(task), 
          contentType:"application/json; charset=utf-8",
          success:success_function});
}

/* KEYPRESS MONITOR */

function input_keypress(event) {
  if (event.target.id != "current_input") {
    $("#current_input").val(event.target.id)
  }
  id = event.target.id.replace("input-","");
  $("#filler-"+id).prop('hidden', true);
  $("#save_edit-"+id).prop('hidden', false);
  $("#undo_edit-"+id).prop('hidden', false);
  // set up enter key funcitonality
  // Number 13 is the "Enter" key on the keyboard
  if (event.keyCode === 13) {
    // Cancel the default action, if needed
    event.preventDefault();
    // Trigger the button element with a click
    $("#save_edit-"+id).click();
  }
}

/* EVENT HANDLERS */

function move_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("move item", event.target.id )
  id = event.target.id.replace("move_task-","");
  if(event.target.className.search("today") > 0) 
  {
    target_list = event.target.className.search("1") > 0 ? "later" : "tomorrow";
  }
  else if(event.target.className.search("tomorrow") > 0)
  {
    target_list = event.target.className.search("1") > 0 ? "today" : "later";
  }
  else
  {
    target_list = event.target.className.search("1") > 0 ? "tomorrow" : "today";
  }
  api_update_task({'id':id, 'list':target_list},
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}

function complete_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("complete item", event.target.id )
  id = event.target.id.replace("description-","");
  completed = event.target.className.search("completed") > 0;
  console.log("updating :",{'id':id, 'completed':completed==false})
  api_update_task({'id':id, 'completed':completed==false}, 
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}

function edit_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("edit item", event.target.id)
  id = event.target.id.replace("edit_task-","");
  // move the text to the input editor
  $("#input-"+id).val($("#description-"+id).text());
  // hide the text display
  $("#move_task-"+id).prop('hidden', true);
  $("#description-"+id).prop('hidden', true);
  $("#dates-"+id).prop('hidden', true);
  $("#edit_task-"+id).prop('hidden', true);
  $("#delete_task-"+id).prop('hidden', true);
  $("#prio_task-"+id).prop('hidden', true)
  // show the editor
  $("#editor-"+id).prop('hidden', false);
  $("#save_edit-"+id).prop('hidden', false);
  $("#undo_edit-"+id).prop('hidden', false);
  // set the editing flag
  $("#current_input").val(event.target.id)
}

function save_edit(event) {
  console.log("save item", event.target.id)
  id = event.target.id.replace("save_edit-","");
  console.log("desc to save = ",$("#input-" + id).val())
  if ((id != "today") & (id != "tomorrow") & (id != "later")) {
    api_update_task({'id':id, description:$("#input-" + id).val(), deadline:$("#newdeadline-" + id).val()},
                    function(result) { 
                      console.log(result);
                      get_current_tasks();
                      $("#current_input").val("")
                    } );
  } else {
    api_create_task({description:$("#input-" + id).val(), list:id, deadline:$("#newdeadline-" + id).val()},
                    function(result) { 
                      console.log(result);
                      get_current_tasks();
                      $("#current_input").val("")
                    } );
  }
}

function undo_edit(event) {
  id = event.target.id.replace("undo_edit-","")
  console.log("undo",[id])
  $("#input-" + id).val("");
  if ((id != "today") & (id != "tomorrow") & (id != "later")) {
    // hide the editor
    $("#editor-"+id).prop('hidden', true);
    $("#save_edit-"+id).prop('hidden', true);
    $("#undo_edit-"+id).prop('hidden', true);
    // show the text display
    $("#move_task-"+id).prop('hidden', false);
    $("#description-"+id).prop('hidden', false);
    $("#dates-"+id).prop('hidden', false);
    $("#filler-"+id).prop('hidden', false);
    $("#edit_task-"+id).prop('hidden', false);
    $("#delete_task-"+id).prop('hidden', false);
    $("#prio_task-"+id).prop('hidden', false);
  }
  // set the editing flag
  $("#current_input").val("")
}

function delete_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("delete item", event.target.id )
  id = event.target.id.replace("delete_task-","");
  api_delete_task({'id':id},
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}

function display_task(x) {
  switch(x.list) {
  case "today":
    arrow1 = "arrow_forward";
    arrow2 = "chevron_right";
    break;
  case "tomorrow":
    arrow1 = "chevron_left";
    arrow2 = "chevron_right";
    break;
  case "later":
    arrow1 = "chevron_left";
    arrow2 = "arrow_back";
    break;
  default:
    break;
  }
  completed = x.completed ? " completed" : "";
  prio = x.prio ? "priority_high" : "crop_portrait";
  if ((x.id == "today") | (x.id == "tomorrow") | (x.id == "later")) {

    t = '<tr id="task-'+x.id+'" class="task no-sort">' +
        '  <td colspan="2"></td>' +  
        '  <td><span id="editor-'+x.id+'">' + 
        '        <form>' +
        '           <div class="mb-3"> '+
        '             <input id="input-'+x.id+'"  class="form-control" '+ 
        '               type="text" autofocus placeholder="Add new task..."/>'+
        '           </div> '+
        '           <div class="mb-3" style="text-align: center"> '+
        '             <small><label for="newdeadline-'+x.id+'" style="display:inline-block"><b>Deadline:</b></label>' +
        '             <input id="newdeadline-'+x.id+'" class="form-control" type="date" style="display:inline-block;  width:auto"/></small>' +
        '           </div> '+
        '         </form>' +
        '      </span>' + 
        '  </td>' +
        '  <td style="width:72px">' +
        '    <span id="filler-'+x.id+'" class="material-icons">more_horiz</span>' + 
        '    <span id="save_edit-'+x.id+'" hidden class="save_edit material-icons" style="border-radius: 5px;background-color: #8dcf65; color: white ">done</span>' + 
        '    <span id="undo_edit-'+x.id+'" hidden class="undo_edit material-icons" style="border-radius: 5px;background-color: #e86967; color: white ">close</span>' +
        '  </td>' +
        '</tr>';
  } else {
    t = '<tr id="task-'+x.id+'" class="task">' + 
        '  <td style="width:24px; padding: 0; vertical-align:middle"><span id="move_task-'+x.id+'" class="move_task '+x.list+' 1 material-icons" style="border-radius: 5px;background-color: #6dc8e1; margin-right:7px">' + arrow1 + '</span></td>' +
        '  <td style="width:24px; padding: 0; vertical-align:middle"><span id="move_task-'+x.id+'" class="move_task '+x.list+' 2 material-icons" style="border-radius: 5px;background-color: #8dcf65">' + arrow2 + '</span></td>' +
        '  <td><span id="description-'+x.id+'" class="description' + completed + '">' + x.description + '</span><br>' +
        '      <span id="dates-'+x.id+'" class="dates"><small>Created: <span id="date1">' + x.date + '</span> Deadline: <span id="date2">' + x.deadline + '</span></small></span>' +
        '      <span id="editor-'+x.id+'" hidden>' + 
        '        <input id="input-'+x.id+'" style="height:22px" class="w3-input" type="text" autofocus/><br>' +
        '           <small><label for="newdeadline-'+x.id+'" style="display:inline-block">Created: ' + x.date + ' Deadline: </label>' +
        '           <input id="newdeadline-'+x.id+'" class="w3-input" type="date" value="' + x.deadline + '" style="display:inline-block; height:10px; width:150px"/></small>' +
        '      </span>' + 
        '  </td>' +
        '  <td>' +
        '    <span id="edit_task-'+x.id+'" class="edit_task '+x.list+' material-icons" style="border-radius: 5px;background-color: #f1b869; ">edit</span>' +
        '    <span id="delete_task-'+x.id+'" class="delete_task material-icons" style="border-radius: 5px;background-color: #e86967; ">delete</span>' +
        '    <span id="save_edit-'+x.id+'" hidden class="save_edit material-icons">done</span>' + 
        '    <span id="undo_edit-'+x.id+'" hidden class="undo_edit material-icons">cancel</span>' +
        '    <span id="prio_task-'+x.id+'" data-order="' + x.order + '" class="material-icons prio_task " style="border-radius: 5px;background-color: #c2d9df; ">' + prio + '</span>' +
        '  </td>' +
        '</tr>';
  }
  $("#task-list-" + x.list).append(t);
  $("#current_input").val("")
}

function prio_task(event) {
  if ($("#current_input").val() != "") { return }
  console.log("toggle prio for item", event.target.id )
  id = event.target.id.replace("prio_task-","");
  prio = event.target.innerHTML == "priority_high";
  if(!prio)
  {
    order = 0;
  }
  else
  {
    order = (this.dataset.order == 0) ? 1 : this.dataset.order;  
  }
  console.log("updating :",{'id':id, 'prio':prio==false, 'order':order})
    api_update_task({'id':id, 'prio':prio==false, 'order':order}, 
                  function(result) { 
                    console.log(result);
                    get_current_tasks();
                  } );
}

function get_current_tasks() {
  // remove the old tasks
  $(".task").remove();
  // display the new task editor
  display_task({id:"today", list:"today"})
  display_task({id:"tomorrow", list:"tomorrow"})
  display_task({id:"later", list:"later"})
  // display the tasks
  api_get_tasks(function(result){
    for (const task of result.tasks) {
      display_task(task);
    }
    // wire the response events 
    $(".move_task").click(move_task);
    $(".description").click(complete_task)
    $(".prio_task").click(prio_task);
    $(".edit_task").click(edit_task);
    $(".save_edit").click(save_edit);
    $(".undo_edit").click(undo_edit);
    $(".delete_task").click(delete_task);
    // set all inputs to set flag
    $("input").keypress(input_keypress);
  });
}

$(document).ready(function() {
  get_current_tasks()
});

</script>
% include("footer.tpl")
