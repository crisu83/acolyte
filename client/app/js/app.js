'use strict';

angular.module('acolyte', [
  'ngRoute',
  'ui.bootstrap'
])
  .value('config', {

  })
  .config(function ($routeProvider) {

    $routeProvider.when('/index', {
      templateUrl: 'partials/index.html',
      controller: 'IndexCtrl'
    });

    $routeProvider.when('/auth', {
      templateUrl: 'partials/auth.html',
      controller: 'AuthCtrl'
    });

    $routeProvider.otherwise({redirectTo: '/index'});

  });
