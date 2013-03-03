function User (currentUser) {
  this.id = null;
  this.email = null;

  this.first_name = null;
  this.last_name = null;
  this.bio = null;
  this.paid = null;

  this._location = null;
  this.latitude = null;
  this.longitude = null;

  this._status = null;

  var initialize = function (obj, currentUser) {
    if (currentUser !== null) {
      obj.id = currentUser['id'];
      obj.email = currentUser['email'];

      obj.first_name = currentUser['first_name'];
      obj.last_name = currentUser['last_name'];
      obj.bio = currentUser['bio'];
      obj.paid = currentUser['paid'];

      obj._location = currentUser['location'];
      obj.latitude = currentUser['latitude'];
      obj.longitude = currentUser['longitude'];

      obj._status = currentUser['status'];
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
