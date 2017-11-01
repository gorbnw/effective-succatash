// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(() => {

  let tag_counts = $(".yelp_id")[0].innerText;
  tag_counts = JSON.parse(tag_counts);

  google.charts.load("current", {packages:["corechart"]});

  google.charts.setOnLoadCallback(drawChart);
  function drawChart() {
    var data = google.visualization.arrayToDataTable(tag_counts);

    var options = {
      pieHole: 0.2,
      title: 'Common Tags Used At This Business',
      backgroundColor: 'transparent',
      colors:['#091d36','#3a4e7a', '#c2d2e9', '#0F1926', '#4F6D8E', '#72a4db', '#8da3bc', '#1d3f66', '#063468', '#616b77'],
      width: 400,
      height: 300,
      chartArea: { left: 10, width: "100%", height: "100%" },
      legend: {position: 'right', textStyle: {color: 'white', fontSize: 12}}
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

    const tagsList = $(e.target).find('li[name="clicked"]')
    let tagsValues = []

    const getTags = () => {
      for(var i = 0; i < tagsList.length; i++){
        tagsValues.push(tagsList[i].value);
      };
      return tagsValues
    }

    getTags()
    const url = $(e.target).attr('action')
    const positive = $(e.target).find('input[name="testimonial[positive]"]:checked').val()
    const tags = tagsValues
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

  // const data = new google.visualization.DataTable();

}); //end document ready
