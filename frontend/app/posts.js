(function(){
	angular.module('app').controller('PostCtrl', ['$scope','$http', function ($scope,$http) {

		$http.get('api/post/myPosts').then(function(posts){
			$scope.posts = posts.data('name', 'value');
		});
	}]);
}());
