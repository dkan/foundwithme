var Search = {
  roles: [],
  skills: [],
  interests: [],
  statuses: [],
  milestones: [],
  lookingFor: [],
  location: ''
};

var SearchCache = {};

$(window).load(function () {
});

$(document).ready(function () {
  $('#skill_name, #interest_name').typeahead({
    source: function (query, process) {
      var type = $(this)[0].$element.attr('id').split('_')[0] + 's';

      if (type === 'skills') {
        var data = { skill_name: query };
      } else if (type === 'interests') {
        var data = { interest_name: query };
      }

      return $.ajax({
        async: true,
        type: 'get',
        url: '/' + type + '/search',
        dataType: 'json',
        data: data,
        success: function (data, textStatus, xhr) {
          SearchCache = {};
          for (var i = 0, d; d = data[i]; i++) {
            SearchCache[d.name] = d;
          }

          return process(data);
        }
      });
    },
    items: 10,
    matcher: function (item) {
      return ~item.name.toLowerCase().indexOf(this.query.toLowerCase());
    },
    sorter: function (items) {
      var beginswith = [];
      var caseSensitive = [];
      var caseInsensitive = [];
      var item;

      while (item = items.shift()) {
        if (!item.name.toLowerCase().indexOf(this.query.toLowerCase())) beginswith.push(item.name)
        else if (~item.name.indexOf(this.query)) caseSensitive.push(item.name)
        else caseInsensitive.push(item.name)
      }

      return beginswith.concat(caseSensitive, caseInsensitive);
    },
    updater: function (item) {
      var type = $(this)[0].$element.attr('id').split('_')[0] + 's';

      if (type === 'skills') {
        var _item = new Skill(SearchCache[item]);
        if (Search.skills.indexOf(_item) === -1) {
          Search.skills.push(_item);
        }
        ajaxSearch();
      } else if (type === 'interests') {
        var _item = new Interest(SearchCache[item]);
        if (Search.interests.indexOf(_item) === -1) {
          Search.interests.push(_item);
        }
        ajaxSearch();
      }
    }
  });

  $('div[id^=search-]').on('click', function (event) {

    if ($(event.target).is('span.checkbox')) {
      if ($(event.target).hasClass('checked')) {
        $(event.target).removeClass('checked');
      } else {
        $(event.target).addClass('checked');
      }
    }
  });

  $('#search-results').on('click', function (event) {
    if ($(event.target).is('.contact-user, .contact-user i')) {
      if (App.User.paid === true) {
        $('#email-button').data('id', $(event.target).data('id'));
        $('#contactModalLabel').html('Email ' + $(event.target).data('name'));
        $('#contactModal').modal();
      } else {
        StripeCheckout.open({
          key:         stripePublicKey,
          address:     false,
          amount:      500,
          name:        'You need to pay for that!',
          description: "We value our user's privacy so we make sure everyone's emails are kept safe. Simply subscribe for $5 per month and we'll send messages to your potential co-founders on your behalf!",
          panelLabel:  'Subscribe',
          token:       token
        });
      }
    }
    if ($(event.target).is('.show-user, .show-user i')) {
      console.log('show user');
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

  $('#search-role').on('click', function (event) {
    var roles = [];
    var roleChecks = $('#search-role').children('span');

    for (var i = 0, rc; rc = roleChecks[i]; i++) {
      if ($(rc).hasClass('checked')) roles.push($(rc).attr('name'));
    }

    Search.roles = roles;
    ajaxSearch();
    return false;
  });

  $('#search-status').on('click', function (event) {
    var statuses = [];
    var statusChecks = $('#search-status').children('span');

    for (var i = 0, sc; sc = statusChecks[i]; i++) {
      if ($(sc).hasClass('checked')) statuses.push($(sc).attr('name'));
    }

    Search.statuses = statuses;
    ajaxSearch();
    return false;
  });

  $('#search-milestone').on('click', function (event) {
    var milestones = [];
    var milestonesChecks = $('#search-milestone').children('span');

    for (var i = 0, mc; mc = milestonesChecks[i]; i++) {
      if ($(mc).hasClass('checked')) milestones.push($(mc).attr('name'));
    }

    Search.milestones = milestones;
    ajaxSearch();
    return false;
  });

  $('#search-looking-for').on('click', function (event) {
    var lookingFor = [];
    var lookingForChecks = $('#search-looking-for').children('span');

    for (var i=0,lfc;lfc=lookingForChecks[i];i++) {
      if ($(lfc).hasClass('checked')) lookingFor.push($(lfc).attr('name'));
    }

    Search.lookingFor = lookingFor;
    ajaxSearch();
    return false;
  });
});

var ajaxSearch = function (){
  Search.location = $('input#location').val();
  $.ajax({
    type: 'get',
    url: '/users',
    data: { query: Search },
    beforeSend: function (xhr) {
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    },
    success: function (data, stat, xhr) {
      $('#search-results').html('')
      for (var i in data) {
        $('#search-results').append(
          '<div class="person clearfix">' +
            '<div class="pull-right">' +
              '<a href="" class="btn btn-info pull-right"><i class="icon-user icon-white"></i> Profile</a><br>' +
              '<a class="btn btn-info pull-right contact-user" data-id="' + data[i].id + '" data-name="' + data[i].first_name + '"><i class="icon-envelope icon-white"></i> Message</a>' +
            '</div>' +
            '<div class="pull-left">' +
              '<img src="http://placehold.it/64x64" alt="Person\'s Name" class="user-avatar">' +
            '</div>' +
            '<div class="pull-left">' +
              '<p>' +
                '<span class="user-full-name">' + data[i].first_name + ' ' + data[i].last_name + '</span><br>' +
                '<span class="user-location">' + data[i].location + '</span><br>' +
                '<span class="user-role">' + data[i].role + '</span> looking for <span class="user-role-want">' + data[i].looking_for + '</span><br>' +
                '<span class="user-current-status"><i class="status green"></i>' + data[i].status + '</span>' +
              '</p>' +
            '</div>' +
          '</div>'
        )
      }
    },
    dataType: 'json'
  });
}
