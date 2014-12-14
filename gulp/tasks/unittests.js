'use strict';

var gulp = require('gulp');
var coffee = require('gulp-coffee');
var mocha = require('gulp-mocha');
var m = require('coffee-script/register');


function onError(err) {
  console.log(err.toString());
  if (!release) {
    this.emit('end');
  } else {
    // if you want to be really specific
    process.exit(1);
  }
}

module.exports = gulp.task('unittests', function () {
  return gulp.src(config.paths.src.unittests, { read: false }   )
  .pipe( coffee( { bare: true } ).on('error', console.log ) )
  .pipe( mocha( { reporter: 'spec' } )).on('error', onError );
});
