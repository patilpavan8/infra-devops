app.controller('TaskController', function($scope) {
    $scope.tasks = [];
    $scope.addTask = function() {
        if ($scope.newTask) {
            $scope.tasks.push({name: $scope.newTask, completed: false});
            $scope.newTask = '';
        }
    };
    $scope.removeTask = function(index) {
        $scope.tasks.splice(index, 1);
    };
});
