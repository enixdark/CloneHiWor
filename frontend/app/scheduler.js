(function(){

	angular.module('app').controller('SchedulerCtrl', ['$scope','$http','$location','toastr',
		function ($scope,$http,$location,toastr) {

		var id = $location.search().id;

		if(idEdit()){
			getPost();
			$scope.save = editPost;
		}
		else{
			$scope.save = newPost;
		}

		function editPost(){
			var datetime = new Date($scope.date.getFullYear(),$scope.date.getMonth(),$scope.date.getDate(),
			$scope.time.getHours(),$scope.time.getMinutes(),$scope.time.getSeconds());
			$http.post('/api/post/update/' + id,{
				message:$scope.message,
				datetime:datetime
			}).then(function(){
				toastr.success('edit success');
			})
		}

		function newPost(){
			var datetime = new Date($scope.date.getFullYear(),$scope.date.getMonth(),$scope.date.getDate(),
			$scope.time.getHours(),$scope.time.getMinutes(),$scope.time.getSeconds());
			$http.post('/api/post/twitter',{
				message:$scope.message,
				datetime:datetime
			}).then(function(){
				toastr.success('new post create success');
			});
		}

		function deletePost(){
			$http.post('/api/post/destroy/' + id).then(function(){
				toastr.success('delete id: '+ id + ' success');
			});
		}

		function getPost(){
			$http.get('api/post/' + id).then(function(post){
				$scope.message = post.data.message;

				var time = new Date(post.data.datetime);
				$scope.date = time;
				$scope.time = time;
			});
		}

		function idEdit(){
			return id;
		}

		$scope.detete = deletePost;

		$scope.date = new Date();

		$scope.time = new Date();
		$scope.opened = false;

		$scope.minDate = new Date();

		$scope.open = function($event){
			$event.preventDefault();
			$event.stopPropagation();
			$scope.opened = !$scope.opened;
		}


	}]);

	angular.module('app').directive('datepickerPopup', [function () {
		return {
			restrict: 'EAC',
			require:'ngModel',
			link: function (scope, element, attrs,controller) {
				controller.$formatters.shift();
			}
		};
	}])
}());
