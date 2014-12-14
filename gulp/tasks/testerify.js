'use strict';

var gulp = require('gulp');
var browserify = require('browserify');
var source = require('vinyl-source-stream');
var browserifyShim = require('browserify-shim');
var coffeeify = require('coffeeify');


function onError(err) {
  //console.log(err.toString());
  if (!release) {
    this.emit('end');
  } else {
    // if you want to be really specific
    process.exit(1);
  }
}

module.exports = gulp.task('testerify', function () {
  return browserify({
      entries: [config.paths.src.testsuite],
      extensions: ['.coffee']
    })
    .transform(coffeeify)
    .transform(browserifyShim)
    .bundle()
    .pipe(source(config.filenames.test.scripts))
    .pipe(gulp.dest(config.paths.test.folder)).on('error', onError);
});



