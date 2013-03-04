//= require jquery-1.9.1.js
//= require jquery_ujs
//= require jquery_nested_form
//= require bootstrap
//= require_tree .

var App = {
  User: new User(currentUser),
  version: 0.1
};

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
        App.User.paid = true;
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
        )
      }
    },
    dataType: 'json'
  });
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
  $('#customStripeButton').click(function(){

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

$(document).on('ready', function () {

});
