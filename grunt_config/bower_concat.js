module.exports = function (grunt, options) {
  return {
    all: {
      dest: '<%= buildRoot %>/js/vendor.js',
      dependencies: {
        'angular': 'jquery'
      },
      bowerOptions: {
        relative: false
      }
    }
  };
};
