module.exports = function (grunt, options) {
  return {
    options: {
      inlineCSS: false
    },
    all: {
      src: [
      'bower_components/bootstrap/less/bootstrap.less',
      '<%= appRoot %>/styles/**/*.less',
      '!<%= appRoot %>/styles/imports.less'
      ],
      dest: '<%= appRoot %>/styles/imports.less'
    }
  };
};
