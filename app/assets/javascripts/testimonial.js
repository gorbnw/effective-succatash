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

  $('.form-button').on('click', (e) => {
    e.preventDefault;
  })

  $('div.testimonial-form .tag').on('click', (e) => {
    e.preventDefault;
    if($('.tags-list').find('li[name="clicked"]').length < 5) {
      if($(e.delegateTarget).closest('li').attr('name') === 'tags') {
        $(e.delegateTarget).attr('name', 'clicked')
        $(e.delegateTarget).find('input').css('color', '#FCFCFC')
        $(e.delegateTarget).css('border-color', '#FCFCFC')
        $(e.delegateTarget).find('input').css('background-color', '#3a4e7a')
        $(e.delegateTarget).css('background-color', '#3a4e7a')
      } else {
        $(e.delegateTarget).attr('name', 'tags')
        $(e.delegateTarget).find('input').css('color', 'black')
        $(e.delegateTarget).css('border-color', 'black')
        $(e.delegateTarget).find('input').css('background-color', '#FCFCFC')
        $(e.delegateTarget).css('background-color', '#FCFCFC')
      }
      } else{
        $(e.delegateTarget).attr('name', 'tags')
        $(e.delegateTarget).find('input').css('color', 'black')
        $(e.delegateTarget).css('border-color', 'black')
        $(e.delegateTarget).find('input').css('background-color', '#FCFCFC')
        $(e.delegateTarget).css('background-color', '#FCFCFC')
        $('.tags-errors').html("Limit five tags per testimonial")
    }
  })

}); //end document ready
