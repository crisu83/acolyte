module.exports = function (grunt, options) {
  return {
    all: {
      expand: true,
      cwd: '<%= buildRoot %>/css',
      src: ['*.css', '!*.min.css'],
      dest: '<%= buildRoot %>/css'
    }
  };
};