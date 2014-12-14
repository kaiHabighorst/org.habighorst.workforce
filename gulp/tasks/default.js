'use strict';

var gulp = require('gulp');
var runSequence = require('run-sequence');



function onError(err) {
  //console.log(err.toString());
  if (!release) {
    this.emit('end');
  } else {
    // if you want to be really specific
    process.exit(1);
  }
}



module.exports = gulp.task('default', function () {
  if (release) {
    runSequence(
      'clean',
      ['index', 'styles', 'images', 'assets', 'templates', 'lint','unittests' ],
      'browserify', 'testerify',
      ['minify', 'serve']
    );
  } else {
    runSequence(
      'clean',
      ['index', 'styles', 'images', 'assets', 'templates', 'lint', 'unittests' ],
      'browserify', 'testerify',
      ['watchify', 'watch', 'serve']
    );
  }
}).on('error', onError);
