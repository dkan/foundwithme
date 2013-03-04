function Skill (skill) {
  this.id = null;
  this.name = null;

  var initialize = function (obj, skill) {
    if (skill !== null) {
      obj.id = skill.id;
      obj.name = skill.name;
    }
  };

  initialize(this, skill);
}
