module.exports = function (grunt, options) {
  return {
    files: ["<%= appRoot %>/js/**/*.js"],
    options: {
      jshintrc: ".jshintrc"
    }
  };
};