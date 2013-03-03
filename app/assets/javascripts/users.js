var Search = {
  roles: [],
  skills: [],
  interests: [],
  statuses: [],
  milestones: [],
  lookingFor: [],
  location: ''
};

$(document).ready(function(){
  $('div[id^=search-]').on('click', function(event){

    if ($(event.target).is('span.checkbox')) {
      if ($(event.target).hasClass('checked')) {
        $(event.target).removeClass('checked');
      } else {
        $(event.target).addClass('checked');
      }
    }
  });

  $('#search-button').on('click', function(){
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

  $('#search-role').on('click', function(event){
    var roles = []
    var roleChecks = $('#search-role').children('span')
    for (var i=0,rc;rc=roleChecks[i];i++) {
      if ($(rc).hasClass('checked')){
        roles.push($(rc).attr('name'));
      }
    }
    Search.roles = roles;
    return false;
  });

  $('#search-status').on('click', function(){
    var statuses = []
    var statusChecks = $('#search-status').children('span')
    for (var i=0,sc;sc=statusChecks[i];i++) {
      if ($(sc).hasClass('checked')){
        statuses.push($(sc).attr('name'));
      }
    }
    Search.statuses = statuses;
    return false;
  });

  $('#search-milestone').on('click', function(){
    var milestones = []
    var milestonesChecks = $('#search-milestone').children('span')

    for (var i=0,mc;mc=milestonesChecks[i];i++) {
      if ($(mc).hasClass('checked')){
        milestones.push($(mc).attr('name'));
      }
    }
    Search.milestones = milestones;
    return false;
  });

  $('#search-looking-for').on('click', function(){
    var lookingFor = []
    var lookingForChecks = $('#search-looking-for').children('span')

    for (var i=0,lfc;lfc=lookingForChecks[i];i++) {
      if ($(lfc).hasClass('checked')){
        lookingFor.push($(lfc).attr('name'));
      }
    }
    Search.lookingFor = lookingFor;
    return false;
  });
});