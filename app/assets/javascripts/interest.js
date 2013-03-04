function Interest (interest) {
  this.id = null;
  this.name = null;

  var initialize = function (obj, interest) {
    if (interest !== null) {
      obj.id = interest.id;
      obj.name = interest.name;
    }
  };

  initialize(this, interest);
}
