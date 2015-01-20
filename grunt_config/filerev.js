module.exports = function (grunt, options) {
  return {
    options: {
      algorithm: 'md5',
      length: 8
    },
    dist: {
      src: [
        '<%= buildRoot %>/img/*.{png,jpg,gif}',
        '<%= buildRoot %>/js/*.js',
        '<%= buildRoot %>/partials/**/*.html',
        '<%= buildRoot %>/css/*.css'
      ]
    }
  }
};