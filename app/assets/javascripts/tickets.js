var ticketReady = function() {
  var $ticketStatus = $('#ticket-status'),
      $ticketDayClosed = $('#ticket-date-closed');
      $ticketRemedy = $('#ticket-remedy');
      $ticketStatus.change(function() {
        
          if ($ticketStatus.val() === 'CL' || $ticketStatus.val() === 'AB') {
              $ticketDayClosed.removeAttr('disabled').val('');
              $ticketRemedy.removeAttr('disabled').val('');
          } 
          else {
              $ticketDayClosed.attr('disabled', 'disabled').val('Ticket still in progress');
              $ticketRemedy.attr('disabled', 'disabled').val('Ticket still in progress');
          }
      })
      .trigger('change'); // added trigger to calculate initial state
    
};
// Load jQuery data 
$(document).ready(ticketReady);
$(document).on('turbolinks:load', ticketReady);
$(document).on('turbolinks:fetch', ticketReady);
$(document).on('turbolinks:change', ticketReady);
