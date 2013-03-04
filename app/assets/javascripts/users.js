var Search = {
  roles: [],
  skills: [],
  interests: [],
  statuses: [],
  milestones: [],
  lookingFor: [],
  location: ''
};

$(window).load(function () {
});

$(document).ready(function () {
  $('div[id^=search-]').on('click', function (event) {

    if ($(event.target).is('span.checkbox')) {
      if ($(event.target).hasClass('checked')) {
        $(event.target).removeClass('checked');
      } else {
        $(event.target).addClass('checked');
      }
    }
  });

  $('.contact-user').on('click', function (event) {
    if (App.User.paid === true) {
      $('#email-button').data('id', $(this).data('id'));
      $('#contactModalLabel').html('Email ' + $(this).data('name'));
      $('#contactModal').modal();
    } else {
      StripeCheckout.open({
        key:         stripePublicKey,
        address:     false,
        amount:      500,
        name:        'Monthly Subscription',
        panelLabel:  'Subscribe',
        token:       token
      });
    }
  });

  $('#email-button').on('click', function (event) {
    $.ajax({
      type: 'post',
      url: '/messages',
      data: {
        message: {
          sender_id: App.User.id,
          recipient_id: $('#email-button').data('id'),
          body: $('.email-body').val()
        }
      },
      beforeSend: function (xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      success: function (data, stat, xhr) {
        if (data['success']) {
          $('.email-body').val('');
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
        $('#contactModal').modal('toggle')
      },
      dataType: 'json'
    });
  });

  $('#search-button').on('click', function (event) {
    Search.location = $('input#location').val();
    $.ajax({
      type: 'get',
      url: '/users',
      data: { query: Search },
      beforeSend: function (xhr) {
        xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
      },
      success: function (data, stat, xhr) {
        console.log(data);
      },
      dataType: 'json'
    });

  });

  $('#search-role').on('click', function (event) {
    var roles = [];
    var roleChecks = $('#search-role').children('span');

    for (var i = 0, rc; rc = roleChecks[i]; i++) {
      if ($(rc).hasClass('checked')) roles.push($(rc).attr('name'));
    }

    Search.roles = roles;

    return false;
  });

  $('#search-status').on('click', function (event) {
    var statuses = [];
    var statusChecks = $('#search-status').children('span');

    for (var i = 0, sc; sc = statusChecks[i]; i++) {
      if ($(sc).hasClass('checked')) statuses.push($(sc).attr('name'));
    }

    Search.statuses = statuses;

    return false;
  });

  $('#search-milestone').on('click', function (event) {
    var milestones = [];
    var milestonesChecks = $('#search-milestone').children('span');

    for (var i = 0, mc; mc = milestonesChecks[i]; i++) {
      if ($(mc).hasClass('checked')) milestones.push($(mc).attr('name'));
    }

    Search.milestones = milestones;

    return false;
  });

  $('#search-looking-for').on('click', function (event) {
    var lookingFor = [];
    var lookingForChecks = $('#search-looking-for').children('span');

    for (var i=0,lfc;lfc=lookingForChecks[i];i++) {
      if ($(lfc).hasClass('checked')) lookingFor.push($(lfc).attr('name'));
    }

    Search.lookingFor = lookingFor;

    return false;
  });
});
