module.exports = function (grunt, options) {
  return {
    all: {
      files: {
        '<%= buildRoot %>/css/styles.css': '<%= appRoot %>/styles/imports.less'
      }
    }
  };
};
