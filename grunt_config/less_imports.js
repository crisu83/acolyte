module.exports = function (grunt, options) {
  return {
    options: {
      inlineCSS: false
    },
    styles: {
      files: {
        '<%= appRoot %>/styles/imports.less': [
          'bower_components/bootstrap/less/bootstrap.less',
          '<%= appRoot %>/styles/**/*.less',
          '!<%= appRoot %>/styles/imports.less'
        ]
      }
    }
  };
};