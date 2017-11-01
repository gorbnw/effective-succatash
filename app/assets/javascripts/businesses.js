// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(() => {

  let tag_counts = null

  $.ajax({
    method: 'GET',
    url: business_path()
  })

  google.charts.load("current", {packages:["corechart"]});


      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);

        var options = {
          title: 'My Daily Activities',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }

  $(document).on("submit", '#new_testimonial', (e) => {
    e.preventDefault();
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
                                  yelp_id: business} }
    $.ajax({
      method: "POST",
      url,
      data
    }).done((response) => {
      $('.errors').empty();
      $('.no-testimonials').remove();
      $('.testimonial-list').prepend(response);
      $('.new_testimonial')[0].reset();
    }).fail((response) => {
      console.log(response)
      $('.errors').html(response.responseText);
    }).always(() => {
      $('input.submit-button').removeAttr('disabled');

    }) // end ajax response

  }) //end new testimonial listener

  // Adding the Google Chart API to Business Show Page

  const data = new google.visualization.DataTable();

}); //end document ready
