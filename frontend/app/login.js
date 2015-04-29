(function(){


	var login = angular.module('app');
	login.controller('LoginCtrl', ['$scope','$auth','$http','toastr', function ($scope,$auth,$http,toastr) {
		$scope.login = function(){
			$auth.authenticate('twitter');
		}

		$scope.logout = function(){
			$auth.logout();
			toastr.success('logout success');
		}

		$scope.isAuthenticated = $auth.isAuthenticated;
		console.warn($auth.isAuthenticated());

	}]);

}());

