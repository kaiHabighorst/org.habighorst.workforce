'use strict';

var gulp = require('gulp');
var git = require('gulp-git');


function onError(err) {
  //console.log(err.toString());
  if (!release) {
    this.emit('end');
  } else {
    // if you want to be really specific
    process.exit(1);
  }
}

module.exports = gulp.task('git', function () {

  return gulp.src(config.paths.src.gitArray)
    .pipe(git.add());

});



