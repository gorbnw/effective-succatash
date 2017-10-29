// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require jquery_ujs
//= require sweetalert
//= require_tree .

$(document).ready(() => {

  // let clickCounter = 0;

  $(".reg-container .input").on('focus', (e) => {
    let label = $(e.target).closest(".field").find('label');
    $(label).addClass('labelshift');
  })

  $(".reg-container .input").on('focusout', (e) => {
    let label = $(e.target).closest(".field").find('label');
      if ($(e.target).val() === "") {
      $(label).removeClass('labelshift');
    }
  })

  $(".reg-container .checkbox").change((e) => {
    let label = $(e.target).closest(".field").find('label');
    $(label).toggleClass('check-bold').css('color', '#0F1926');
  })

  $(".form-button").on('click', (e, clickCounter) => {
    // console.log(clickCounter)
    // debugger;
    // if(clickCounter === 0 || (clickCounter % 5)){
    swal("Please Consider Speaking Out!", "Show your solidarity by also sharing your experience; please consider adding a testimonial.");
    //   clickCounter += 1;
    // } else {
    //   clickCounter += 1;
    // }
  })

})
