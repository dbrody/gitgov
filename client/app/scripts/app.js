'use strict';
/* global ga: false */
/**
 * @ngdoc overview
 * @name demoApp
 * @description
 * # demoApp
 *
 * Main module of the application.
 */
var app = angular.module('demoApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ng-token-auth',
    'restangular',
    'ui.router',
    'ui.utils',
    'ui.bootstrap',
    'angulartics',
    'angulartics.google.analytics'
  ]);

app.config(function ($provide, $stateProvider, $urlRouterProvider, $authProvider, RestangularProvider) {

  RestangularProvider.setBaseUrl('/api/v1');

  // For any unmatched url, redirect to /state1
  $urlRouterProvider.otherwise('/');

  // Now set up the states
  $stateProvider
    .state('root', {
      url: '/',
      templateUrl: 'views/home.html',
      controller: 'HomeCtrl'
    })
    .state('doc', {
      url: '/doc/:id',
      templateUrl: 'views/doc.html',
      controller: 'DocCtrl'
    });

  // Configure authentication endpoints / prefix
  $authProvider.configure({
      apiUrl: '/api/v1'
  });
});



app.run(['$rootScope', '$location', '$state', '$analytics', function($rootScope, $location, $state, $analytics) {

  $rootScope.$on('auth:logout-success', function(/* ev , reason */) {
    $state.go('root.home');
  });

  $rootScope.$on('auth:login-success', function(/*ev , reason */) {
    $analytics.pageTrack('/user/login/' + $rootScope.user.id + '/' + $rootScope.user.name);
    $analytics.eventTrack('/user/login/' + $rootScope.user.id + '/' + $rootScope.user.name);
  });

  $rootScope.$on('auth:validation-success', function(/* ev, reason */) {
    if(!$rootScope.user.name){
      $state.go('root.register.start');
    } else {
      // Set userID for analytics tracking
      ga('set', 'userId', $rootScope.user.id);
      $analytics.pageTrack('/reload/' + $rootScope.user.id + '/' + $rootScope.user.name);
      $analytics.eventTrack('/reload/' + $rootScope.user.id + '/' + $rootScope.user.name);
    }
  });

  $rootScope.$on('auth:validation-error', function(/* ev, reason */) {
    console.log('Bad validation.');
    $state.go('root.home');
  });
}]);