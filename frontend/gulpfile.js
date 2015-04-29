var gulp = require('gulp');
var webserver = require('gulp-webserver');
var bowerMainFiles = require('main-bower-files');
var inject = require('gulp-inject');
var del = require('del');
var _ = require('underscore');

var paths = {
	app:'app',
	index:'app/index.html',
	build:'build',
	buildStyle:'stylesheets',
	buildSCript:'javascripts',
	buildIndex:'build/index.html',
	appScript:['app/**/*.js','!main.js'],
	appStyle:['app/**/*.css','!main.css'],
	appTemplate:['app/**/*.html','!app/index.html'],
	srcStatic:'build/static'
}

gulp.task('default',['watch']);


gulp.task('watch',['serve'],function(){
	gulp.watch(paths.buildSCript,['scripts']);
	gulp.watch(paths.buildStyle,['style']);
	gulp.watch(paths.index,['copyAll']);
})

gulp.task('serve',['copyAll'],function(){
	gulp.src(paths.build).pipe(webserver({
		// livereload:true
		proxies:[{
			source:'/api',
			target:'http://localhost:3000'
		}]
	}));
});


gulp.task('html.copy', function () {
	return gulp.src(paths.appTemplate).pipe(gulp.dest(paths.build));
})

gulp.task('mainscripts.copy', function () {
	return gulp.src(paths.appScript).pipe(gulp.dest(paths.srcStatic));
})

gulp.task('mainstyle.copy', function () {
	return gulp.src(paths.appStyle).pipe(gulp.dest(paths.srcStatic));
})


gulp.task('style.copy',function(){
	var css = _.filter(bowerMainFiles(),function(i){
		return i.match(/.css$/);
	});
	gulp.src(css).pipe(gulp.dest(paths.srcStatic+"/"+paths.buildStyle));
});

gulp.task('scripts.copy',function(){
	var js = _.filter(bowerMainFiles(),function(i){
		return i.match(/.js$/);
	});
	gulp.src(js).pipe(gulp.dest(paths.srcStatic+"/"+paths.buildSCript));
});


// gulp.task('scripts', ['scripts.copy'], function () {

// 	var appScriptFiles = gulp.src([bowerScript], {
// 		read: false
// 	});

// 	return gulp.src(appScriptFiles)
// 		.pipe(gulp.dest(paths.static));
// });

// gulp.task('style', ['style.copy'], function () {

// 	var appStyleFiles = gulp.src([bowerScript], {
// 		read: false
// 	});

// 	return gulp.src(appStyleFiles)
// 		.pipe(gulp.dest(paths.static));
// });

gulp.task('copyAll', ['scripts.copy','style.copy','mainstyle.copy','mainscripts.copy','html.copy'], function () {
	var js = gulp.src([paths.srcStatic + '/javascripts/*',paths.srcStatic+'/stylesheets/*'], {
		read: false
	});

	var appFiles = gulp.src(['build/*.js','build/*.css'], {
		read: false
	});

	return gulp.src(paths.index)
		.pipe(gulp.dest(paths.build))
		.pipe(inject(js, {
			relative: true,
			name: 'resourceInject'
		}))
		.pipe(inject(appFiles, {
			relative: true,
		}))
		.pipe(gulp.dest(paths.build));

});