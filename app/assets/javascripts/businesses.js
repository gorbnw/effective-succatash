// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(() => {

  $(document).on("submit", '#new_testimonial', (e) => {
    // e.preventDefault();
    let anonymous = null;
    const setAnonymous = () => {
      if($(e.target).find('input[name="testimonial[anonymous]"]:checked').val() === "1"){
        return anonymous = "1"
      } else {
        return anonymous = "0"
      }
    }
    const url = $(e.target).attr('action')
    const positive = $(e.target).find('input[name="testimonial[positive]"]:checked').val()
    const tags = $(e.target).find('select').val()
    const description = $(e.target).find('textarea').val()
    const business = $(e.target).find('.business').val()
    const data = { testimonial: { positive: positive,
                                  tags: tags,
                                  anonymous: setAnonymous(),
                                  description: description,
                                  business_id: business} }
    $.ajax({
      method: "POST",
      url,
      data
    }).done((response) => {
      $('.testimonial-list').append(response);
      $('.new_testimonial')[0].reset();
    }).fail((response) => {
      console.log(response)
      $('.errors').html(response.responseText);
    }) // end ajax response

  }) //end new testimonial listener

}); //end document ready
