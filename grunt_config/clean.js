module.exports = function (grunt, options) {
  return {
    build: '<%= buildRoot %>',
    web_root: "<%= webRoot %>"
  };
};