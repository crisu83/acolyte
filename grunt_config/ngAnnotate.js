module.exports = function (grunt, options) {
  return {
    options: {
      singleQuotes: true
    },
    app: {
      files: [
        {
          expand: true,
          src: ['build/js/scripts.js'],
          ext: '.annotated.js',
          extDot: 'last'
        }
      ]
    }
  };
};