// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(() => {
  $('.form-button').removeAttr('data-disable-with');

  $(document).on('submit', '.vote-form', (e) => {
    e.preventDefault();
    // may not be event delegated - keep an eye out
    const url = $(e.target).closest('.vote-form').attr('action')
    const token = $(e.target).closest('.vote-form').find('input[name="authenticity_token"]').val();
    const data = $(e.target).closest('.vote-form').find('.testimonial-id').val();

    const request = $.ajax({
      method: 'POST',
      url: url,
      data: { vote: {testimonial_id: data}, authenticity_token: token }
    }).done((response) => {
      $(e.target).closest('.vote-container').find('.vote-count').text(response);
    }).fail((response) => {
      $(e.target).closest('.testimonial').find('.vote-error').text(response['responseText']);
    });
  }) // End Ajax of vote count button.
  //
  // $('.form-button').on('click', (e) => {
  //   e.preventDefault;
  // })

  $('div.testimonial-form .label-tag').on('click', (e) => {
    if($('input[type=checkbox]:checked').length <= 5) {
      $('.tags-errors').empty();
      if($(e.target).closest('input').prop('checked') === false ){
        $(e.target).closest('label').removeClass("clicked");
      } else {
        $(e.target).closest('label').addClass("clicked");
      }
      } else{
        e.preventDefault();
        $(e.target).closest('label').removeClass("clicked");
        $('.tags-errors').html("Limit five tags per testimonial");
    }
  })

}); //end document ready
