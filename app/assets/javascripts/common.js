$(document).ready(function() {
  jQuery(".best_in_place").best_in_place();

  $(document).on('best_in_place:success', function(event, data, status, xhr) {
    $('.flash').html('<div class="alert alert-success">' + 'Successfully Updated' +
      '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
  });

  $(document).on('best_in_place:error', function (event, data, status, xhr) {
    var parsed_data = jQuery.parseJSON(data.responseText);
    $('.flash').html("");
    $(parsed_data).each(function () {
      $('.flash').append('<div class="alert alert-danger">' + this +
      '<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button></div>');
    })
  });
});
