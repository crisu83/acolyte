module.exports = function (grunt, options) {
  return {
    html: '<%= appRoot %>/**/*.html',
    options: {
      dest: '<%= buildRoot %>'
    }
  };
};