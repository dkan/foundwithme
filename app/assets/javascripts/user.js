function User (currentUser) {
  this.id = null;
  this.email = null;

  this.first_name = null;
  this.last_name = null;
  this.bio = null;
  this.paid = null;

  this.location = null;
  this.latitude = null;
  this.longitude = null;

  this.status = null;

  this.Interests = [];
  this.Skills = [];
  this.Employments = [];
  this.Educations = [];

  var initialize = function (obj, currentUser) {
    if (currentUser !== null) {
      obj.id = currentUser['id'];
      obj.email = currentUser['email'];

      obj.first_name = currentUser['first_name'];
      obj.last_name = currentUser['last_name'];
      obj.bio = currentUser['bio'];
      obj.paid = currentUser['paid'];

      obj.location = currentUser['location'];
      obj.latitude = currentUser['latitude'];
      obj.longitude = currentUser['longitude'];

      obj.status = currentUser['status'];

      obj.Skills = Root.initAttribute(currentUser.skills);
      obj.Employments = Root.initAttribute(currentUser.employments);
      obj.Educations = Root.initAttribute(currentUser.educations);
    }
  };

  User.prototype.full_name = function () {
    var first_name = this.first_name;
    var last_name = this.last_name;

    return first_name.charAt(0).toUpperCase() + first_name.slice(1) + ' ' +
      last_name.charAt(0).toUpperCase() + last_name.slice(1);
  };

  User.prototype.public_name = function () {
    var first_name = this.first_name;
    var last_name = this.last_name;

    return first_name.charAt(0).toUpperCase()  + first_name.slice(1) + ' ' +
      last_name.charAt(0).toUpperCase() + '.';
  };

  initialize(this, currentUser);
}

var showUserInfo = function(){
  $('.user-status-edit').hide();
  $('.user-status').show();
  
  $('.looking-for-edit').hide();
  $('.looking-for').show();
  
  $('#profile-edit-row').hide();
  $('#user_info').show();
  return false;
}

var showUserEdit = function(){
  $('.user-status-edit').show();
  $('.user-status').hide();
  
  $('.looking-for-edit').show();
  $('.looking-for').hide();
  
  $('#profile-edit-row').show();
  $('#user_info').hide();
  return false;
}

var submitUserForms = function(){
  $('#user-basic-form').submit();
  $('#user-statuses-form').submit();
  $('#skills-form').submit();
  $('#user-edit-form').submit();
  $('#interests-form').submit();
  
  // for now until Jeff updates loading other users
  location.reload();
  return false;
}