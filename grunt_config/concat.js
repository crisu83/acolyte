module.exports = function (grunt, options) {
  return {
    scripts: {
      src: [
        '<%= appRoot %>/js/app.js',
        '<%= appRoot %>/js/utils/**/*.js',
        '<%= appRoot %>/js/filters/**/*.js',
        '<%= appRoot %>/js/services/**/*.js',
        '<%= appRoot %>/js/directives/**/*.js',
        '<%= appRoot %>/js/models/**/*.js',
        '<%= appRoot %>/js/controllers/**/*.js'
      ],
      dest: '<%= buildRoot %>/js/scripts.js'
    }
  };
};
