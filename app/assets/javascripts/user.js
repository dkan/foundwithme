function User (currentUser) {
  this.first_name = null;
  this.last_name = null;

  var initialize = function (currentUser) {
    if (currentUser !== null) {
      // Do stuff with JSON.
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

  initialize();
}
