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
  }
]);