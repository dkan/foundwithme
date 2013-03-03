//= require jquery-1.9.1.js
//= require jquery_ujs
//= require_tree .

var App = {
  User: new User(currentUser),
  Interests: [],
  Skills: Root.initAttribute(currentUser.skills),
  Employments: Root.initAttribute(currentUser.employments),
  Educations: Root.initAttribute(currentUser.educations)
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
