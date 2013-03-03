//= require jquery-1.9.1.js
//= require jquery_ujs
//= require_tree .

var App = {
  User: new User(currentUser),
  version: 0.1
};

$(window).on('load', function () {
  /*
  $.ajax({
    async: true,
    type: 'get',
    url: 'user/SOME ID',
    dataType: 'json',
    data: null,
    success: function (data, textStatus, xhr) {
      // Do something.
    }
  });
  */
});

$(document).on('ready', function () {
  $('#customStripeButton').click(function(){
    var token = function(res){
      $.ajax({
        type: 'post',
        url: '/charges',
        data: { stripe_token: res.id },
        beforeSend: function (xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        },
        success: function (data, stat, xhr) {
          if (data['success']) {
            $('#flash').html(
              '<div class="alert alert-success">' +
                  data["success"] +
                  '<a class="close" data-dismiss="alert">&#215;</a>' +
              '</div>'
            )
          } else {
            $('#flash').html(
              '<div class="alert alert-error">' +
                  data["error"] +
                  '<a class="close" data-dismiss="alert">&#215;</a>' +
              '</div>'
            )          }
        },
        dataType: 'json'
      });
    };

    StripeCheckout.open({
      key:         stripePublicKey,
      address:     false,
      amount:      500,
      name:        'Monthly Subscription',
      panelLabel:  'Subscribe',
      token:       token
    });

    return false;
  });
});
