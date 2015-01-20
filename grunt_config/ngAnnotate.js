module.exports = function (grunt, options) {
  return {
    options: {
      singleQuotes: true
    },
    app: {
      files: [
        {
          expand: true,
          src: ['<%= buildRoot %>/js/scripts.js'],
          ext: '.annotated.js',
          extDot: 'last'
        }
      ]
    }
  };
};
