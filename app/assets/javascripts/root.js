var Root = {
  initAttribute: function (attributes) {
    var obj = [];

    for (var i = 0, attribute; attribute = attributes[i]; i++) {
      obj.push(attribute);
    }

    return obj;
  }
}
