// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(() => {
  $('.vote-form').on('submit', (e) => {
    e.preventDefault();
    // may not be event delegated - keep an eye out
    console.log("connected")
    const url = $(e.target).closest('.vote-form').attr('action')
    console.log(url)
    const data = $(e.target).closest('.vote-form').find('.testimonial-id').val();
    console.log(data)
  })

});
