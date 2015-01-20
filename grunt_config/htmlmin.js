module.exports = function (grunt, options) {
  return {
    dist: {
      options: {
        removeComments: true,
        collapseWhitespace: true
      },
      files: [
        {
          expand: true,
          cwd: '<%= appRoot %>',
          src: ['**/*.html'],
          dest: '<%= buildRoot %>'
        }
      ]
    }
  };
};