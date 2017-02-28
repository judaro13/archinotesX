// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//
// $(function() {
//   return $(document).on('change', '', function(evt) {
//     return $.ajax('update_tables', {
//       type: 'GET',
//       dataType: 'script',
//       data: {
//         datasource_id: $("#select_datasource option:selected").val()
//       },
//       error: function(jqXHR, textStatus, errorThrown) {
//         return console.log("AJAX Error: " + textStatus);
//       },
//       success: function(data, textStatus, jqXHR) {
//         return console.log("Dynamic table select OK!");
//       }
//     });
//   });
// });

$( document ).ready( function() {
  $("#select_datasource" ).change(function() {
    $.ajax({
      url: "update_tables",
      type: 'GET',
      dataType: 'script',
      data: {
        datasource_id: $("#select_datasource option:selected").val()
      }
    }).done(function( msg ) {
      msg
    });
  });
})
