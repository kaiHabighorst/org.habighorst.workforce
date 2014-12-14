'use strict';

var gulp = require('gulp');
var watch = require('gulp-watch');
var runSequence = require('run-sequence');

module.exports = gulp.task('tests', function () {
  watch({ glob: [config.paths.src.scripts]}, [
      'lint', 'unittests']
    );
});
