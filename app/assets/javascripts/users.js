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
  $('#search-button').on('click', function(){
    console.log('SEARCH!!');
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

  $('#search-role').on('change', function(){
    var roles = []
    var roleChecks = $('#search-role').children('input')

    for (var i=0,rc;rc=roleChecks[i];i++) {
      if ($(rc).is(':checked')){
        roles.push(rc.id);
      }
    }
    Search.roles = roles;
    return false;
  });

  $('#search-status').on('change', function(){
    var statuses = []
    var statusChecks = $('#search-status').children('input')

    for (var i=0,sc;sc=statusChecks[i];i++) {
      if ($(sc).is(':checked')){
        statuses.push(sc.id);
      }
    }
    Search.statuses = statuses;
    return false;
  });

  $('#search-milestone').on('change', function(){
    var milestones = []
    var milestonesChecks = $('#search-milestone').children('input')

    for (var i=0,mc;mc=milestonesChecks[i];i++) {
      if ($(mc).is(':checked')){
        milestones.push(mc.id);
      }
    }
    Search.milestones = milestones;
    return false;
  });

  $('#search-looking-for').on('change', function(){
    var lookingFor = []
    var lookingForChecks = $('#search-looking-for').children('input')

    for (var i=0,lfc;lfc=lookingForChecks[i];i++) {
      if ($(lfc).is(':checked')){
        lookingFor.push(lfc.id);
      }
    }
    Search.lookingFor = lookingFor;
    return false;
  });
});