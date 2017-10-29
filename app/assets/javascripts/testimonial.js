// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(() => {
  $('.vote-form').on('submit', (e) => {
    e.preventDefault();
    // may not be event delegated - keep an eye out

    const url = $(e.target).closest('.vote-form').attr('action')

    const data = $(e.target).closest('.vote-form').find('.testimonial-id').val();

    const request = $.ajax({
      method: 'POST',
      url: url,
      data: { vote: {testimonial_id: data} }
    }).done((response) => {
      $(e.target).closest('.vote-container').find('.vote-count').text(response);
    }).fail(() => {
      alert("Oops, Something went wrong, please try again!");
    }).always(() => {
      console.log('Click Registered');
    })
  }) // End Ajax of vote count button.

});
