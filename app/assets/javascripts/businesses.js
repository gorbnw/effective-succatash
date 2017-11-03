// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(() => {
  $('.hidden-check').hide();

  let tag_counts = $(".yelp_id")[0].innerText;
  tag_counts = JSON.parse(tag_counts);

  google.charts.load("current", {packages:["corechart"]});

  google.charts.setOnLoadCallback(drawChart);
  function drawChart() {
    var data = google.visualization.arrayToDataTable(tag_counts);

    var options = {
      pieHole: 0.2,
      title: 'Common Tags Used At This Business',
      titleTextStyle: { color: 'white',
                        fontSize: 16},
      backgroundColor: 'none',
      colors:['#091d36','#3a4e7a', '#c2d2e9', '#0F1926', '#4F6D8E', '#72a4db', '#8da3bc', '#1d3f66', '#063468', '#616b77'],
      tooltip: {textStyle: { color: 'black',
                            fontSize: 12,
                            italic: true},
                isHTML: true},
      // width: 500,
      // height: 400,
      pieSliceText: 'none',
      chartArea: { left: 40, width: "80%", height: "80%" },
      legend: {position: 'labeled', alignment: 'end', textStyle: {color: 'white', fontSize: 12, italic: true}}
    };

    var chart = new google.visualization.PieChart(document.getElementById('donutchart'));

    $('.loading-container').hide();
    chart.draw(data, options);
    $('#donutchart').show();
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

    const checkBoxes = $(e.target).find('.hidden-check:checked');
    console.log

    let tags = {};
    for(var i = 0; i < checkBoxes.length; i++){
      tags[checkBoxes[i].value] = checkBoxes[i].value;
    }
    console.log(tags);
    const url = $(e.target).attr('action')
    const positive = $(e.target).find('input[name="testimonial[positive]"]:checked').val();
    const description = $(e.target).find('textarea').val();
    const business = $(e.target).find('.business').val();
    const data = { tags,
                   testimonial: { positive: positive,
                                  anonymous: setAnonymous(),
                                  description: description,
                                  yelp_id: business} }

    $.ajax({
      method: "POST",
      url,
      data,
    }).done((response) => {
      $('.errors').empty();
      $('.no-testimonials').remove();
      $('.testimonial-list').prepend(response);
      $('.new_testimonial')[0].reset();
      $('.form-button').removeAttr('data-disable-with');
      $('.clicked').removeClass('clicked');

    }).fail((response) => {
      $('.errors').html(response.responseText);
    }).always(() => {
      $('input.submit-button').removeAttr('disabled');

    }) // end ajax response

  }) //end new testimonial listener

  // Adding the Google Chart API to Business Show Page

  // const data = new google.visualization.DataTable();

}); //end document ready
