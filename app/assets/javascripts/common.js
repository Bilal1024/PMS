$(document).ready(function() {
  jQuery(".best_in_place").best_in_place();

  $(document).on('best_in_place:success', function(event, data, status, xhr) {
    showNotification('success', 'Successfully Updated', 'done')
  });

  $(document).on('best_in_place:error', function (event, data, status, xhr) {
    var parsed_data = jQuery.parseJSON(data.responseText);
    $(parsed_data).each(function () {
      showNotification('danger', this, "error")
    })
  });
});

function showNotification(color, text, icon){
  $.notify({
    icon: icon,
    message: text
  },
  { 
    type: color,
    timer: 3000,
    placement: {
      from: 'top',
      align: 'right'
    }
  });
}
