module.exports = function (grunt, options) {
  return {
    options: {
    },
    scripts: {
      files: {
        '<%= buildRoot %>/js/scripts.js': 'build/js/scripts.annotated.js'
      }
    },
    vendor: {
      files: {
        '<%= buildRoot %>/js/vendor.js': 'build/js/vendor.js'
      }
    }
  };
};