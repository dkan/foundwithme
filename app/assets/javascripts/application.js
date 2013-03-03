//= require jquery-1.9.1.js
//= require jquery_ujs
//= require_tree .

var App = {
  User: new User(currentUser),
  Interests: [],
  Skills: [],
  Employments: [],
  Educations: []
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
});
