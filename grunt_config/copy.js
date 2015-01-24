module.exports = function (grunt, options) {
  return {
    assets: {
      files: [
        {
          expand: true,
          cwd: 'bower_components',
          src: ['bootstrap/fonts/*.{eot,svg,ttf,woff,woff2}'],
          dest: '<%= buildRoot %>/assets',
          filter: 'isFile'
        }
      ]
    },
    build: {
      files: [
        {
          expand: true,
          cwd: '<%= buildRoot %>',
          src: ['**/*.*'],
          dest: '<%= webRoot %>',
          filter: 'isFile'
        }
      ]
    },
    html: {
      files: [
        {
          expand: true,
          cwd: '<%= appRoot %>',
          src: ['**/*.html'],
          dest: '<%= buildRoot %>',
          filter: 'isFile'
        }
      ]
    },
    images: {
      files: [
        {
          expand: true,
          cwd: '<%= appRoot %>/img',
          src: ['**/*.{png,jpg,gif}'],
          dest: '<%= buildRoot %>/img',
          filter: 'isFile'
        }
      ]
    },
    misc: {
      files: [
        {
          expand: true,
          cwd: '<%= appRoot %>',
          src: ['robots.txt'],
          dest: '<%= buildRoot %>',
          filter: 'isFile'
        }
      ]
    },
    scripts: {
      files: [
        {
          expand: true,
          cwd: '<%= appRoot %>/js',
          src: ['*.js'],
          dest: '<%= buildRoot %>/js',
          filter: 'isFile'
        }
      ]
    }
  };
};
