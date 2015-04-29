
var app = angular.module('app', ['satellizer','ui.bootstrap',
	'ui.router','toastr','ngAnimate','ngRoute']);

// function Redirect(){
// 	this.path = function(name){
// 		$location.path(name);
// 	}
// }

// app.service('Redirect',Redirect);

app.config(['$stateProvider','$routeProvider',
	function($stateProvider,$routeProvider){
		// $locationProvider.hashPrefix('!');
		$routeProvider
		.when('/', {
			templateUrl: 'countries/index.html',
			controller: 'MainCtrl',
			// resolve: {
   //    	delay: function($q, $timeout) {
	  //     	var delay = $q.defer();
	  //     	$timeout(delay.resolve, 1000);
	  //     	return delay.promise;
   //    }
  	// }
	}).
	when('/countries/new', {
			templateUrl: 'countries/new.html',
			controller: 'MainCtrl',
  		}
	);
	
	// $stateProvider
	// .state('index',{
	// 	url:'/',
	// 	templateUrl:'countries/index.html',
	// 	controller:'MainCtrl'
	// })
	// .state('new',{
	// 	url:'/countries/new',
	// 	templateUrl:'countries/new.html',
	// 	controller:'MainCtrl'
	// })
}])
.controller('MainCtrl', ['$scope','$http','$location',
	function($scope,$http,$location){

	$scope.fileChanged = function(){
		console.log($scope.file);
	}

	$scope.path = function(name){
		$location.path(name);
		// $scope.$apply();
	};
	// $scope.path = function(name){
	// 	scope.$apply(
	// 		function() { 
	// 			$location.path(name); 
	// 		});
	// }

	// $scope.$watch(function() { return $location.path(); }, function(newValue, oldValue){  
 //    if ($scope.loggedIn == false && newValue != '/login'){  
 //            $location.path('/login');  
 //    	}  
	// });

	$http.get("http://localhost:8000/api/json").
	success(function(data, status, headers, config) {
		$scope.countries = data;
	}).
	error(function(data, status, headers, config) {

	});
}])
.controller('HeaderCtrl', ['$scope','$http','$location',
	function($scope,$http,$location){
		$scope.path = function(name){
			$location.path(name);
		};
	}
]);
