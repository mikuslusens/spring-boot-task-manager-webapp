$(document).ready(function() {
   
  $('#form').submit(function(event) {
    
	  event.preventDefault();
	  
	  $("input[value='Save']").prop("disabled", true);
	  
	  var name =  $("input[name='name']").val();
      var description = $("input[name='description']").val();
      var finished = $("input[name='finished']").val();
      var json = {"name" : name, "description" : description, "finished" : finished};
       
    $.ajax({
        url: $("#form").attr( "action"),
        data: JSON.stringify(json),
        type: "POST",
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        success: function() {
        	$('#infoModal').modal('show');
        	$("input[value='Save']").prop("disabled", false);
        },
        error: function(e) {
        	$('#modalTitle').text("Error");
        	$('#modalMessage').text("An error has occured! Please try again.");
        	$('#infoModal').modal('show');
        	$("input[value='Save']").prop("disabled", false);

        }
    });
    
  });
  
  $('#deleteButton').click(function(e) {
	  var id = $(this).val();
	  $.ajax({
          url: '/delete-task/'+ id,
          method: 'DELETE',
          success: function() {
        	$('#modalMessage').text("Task deleted successfully");
        	$('#infoModal').modal('show');
          	$("input[value='Save']").prop("disabled", false);
          },
          error: function(e) {
          	$('#modalTitle').text("Error");
          	$('#modalMessage').text("An error has occured! Please try again.");
          	$('#infoModal').modal('show');
          	$("input[value='Save']").prop("disabled", false);

          }
      });
  }); 
});