module.exports = function (grunt, options) {
  return {
    dist: {
      files: [
        {
          expand: true,
          cwd: '<%= appRoot %>/img',
          src: ['**/*.{png,jpg,gif}'],
          dest: '<%= buildRoot %>/img'
        }
      ]
    }
  };
};