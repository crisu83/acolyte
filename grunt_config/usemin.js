module.exports = function (grunt, options) {
  return {
    options: {
      assetsDirs: [
        '<%= buildRoot %>',
        '<%= buildRoot %>/assets',
        '<%= buildRoot %>/css',
        '<%= buildRoot %>/img',
        '<%= buildRoot %>/js',
        '<%= buildRoot %>/partials'
      ],
      patterns: {
        partials: [
          [/(partials\/.*?\.html)/gm, 'Update the reference to our revved template file']
        ],
        images: [
          [/(img\/.*?\.(?:gif|jpeg|jpg|png|webp))/gm, 'Update the reference to our revved image file']
        ]
      }
    },
    html: [
      '<%= buildRoot %>/index.html',
      '<%= buildRoot %>/partials/**/*.html'
    ],
    css: [
      '<%= buildRoot %>/css/*.css'
    ],
    partials: [
      '<%= buildRoot %>/partials/**/*.html',
      '<%= buildRoot %>/js/**/*.js'
    ],
    images: [
      '<%= buildRoot %>/js/**/*.js'
    ]
  };
};
