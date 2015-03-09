var ready = function() {
  
  // Quick add new ticket for slider
  $("#ticket-quick-data").hide();
  
  $("#ticket-input").focusin(function() {
    $("#ticket-quick-data").slideDown();
  });
  
  $("#btn-ticket-close").click(function() {
    $("#ticket-quick-data").slideUp();
  });
    
  // Datetimepicker 
  $('.datetimepicker').datetimepicker({
      timepicker:true,
      format:'Y-m-d H:m'});
  $('.datepicker').datetimepicker({
      timepicker:false,
      format:'Y-m-d'});
      
  // close messages     
  $('.message .close').on('click', function() {
    $(this).closest('.message').fadeOut();
  });
  
  // ui dropdown for user profile
  $('.ui.dropdown').dropdown();
  
  // ui checkbox for user profile
  $('.ui.checkbox').checkbox();
  
  $('.field_with_errors').parent().addClass('error');
  
  // Search form.  
  $('#user_search').submit(function () {
    $.get(this.action, $(this).serialize(), null, 'script');
    return false;
  });
  
  // Phone no mask plugin
  $('.phone_no').mask('(000) 000-0000');
  $('#myForm').submit(function(event) {
    $('.phone_no').unmask();
  });

  // auto slideUp error message after 2 secs
  $('.alert-msg .header').delay(1800).fadeOut("fast");
  $('.alert-msg').delay(2000).slideUp();

  // popup avatar dashboard
  $('.avatar-popup')
    .popup();
    
  // intro effects
  //$('#intro-h1').addClass('animated bounceInLeft');  

  // sortable tables
  $('table').tablesort();

};

// Load jQuery data 
$(document).ready(ready);

// Enable loader and page dimmer on load
$(document).on('page:fetch', function() {
  $(".ui.active.inverted.dimmer").show();
  $('.intro-page-background').css({'height':(($(window).height()-50))+'px'});
});

$(document).on('page:change', function() {
  $(".ui.active.inverted.dimmer").hide();
  $('.intro-page-background').css({'height':(($(window).height()-50))+'px'});
});

// Search users 
$(document).on('submit', '#user_search', function () {
  $.get(this.action, $(this).serialize(), null, 'script');
  return false;
});

// Search users 
$(document).on('submit', '#asset_search', function () {
  $.get(this.action, $(this).serialize(), null, 'script');
  return false;
});

// Resize height of the background depending on the window size
$(window).resize(function(){
  $('.login-page-background').css({'height':(($(window).height()-50))+'px'});
  $('.intro-page-background').css({'height':(($(window).height()-50))+'px'});
  $('#login-page').css({'top':(($(window).height()*0.1))+'px'});
});

$(window).load(function(){ // On load
	$('.login-page-background').css({'height':(($(window).height()-50))+'px'});
  $('.intro-page-background').css({'height':(($(window).height()-50))+'px'});
  $('#login-page').css({'top':(($(window).height()*0.1))+'px'});
});
