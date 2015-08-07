'use strict';

/**
 * @ngdoc function
 * @name demoApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the demoApp
 */
angular.module('demoApp')
  .controller('HomeCtrl', ['$scope', '$http', '$modal', '$state', '$auth', '$stateParams',
   function ($scope, $http, $modal, $state, $auth, $stateParams) {
   	$scope.state = $state;
   	$scope.docs = [];

   	$http.get('/api/v1/documents')
      .success(function(data, status, headers, config){
        console.log(data);
        $scope.docs = data;
      })
      .error(function(data, status, headers, config){

      });

  }
]);