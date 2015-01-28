'use strict';

angular.module('acolyte')
  .controller('AuthCtrl', function ($scope, $rootScope, $timeout, $routeParams, $location, authService) {

    if ($routeParams.code) {
      authService.login($routeParams.code)
        .then(function (data) {
          $rootScope.user = data;
          $location.url('/');
        }, function (error) {
          console.log('ERROR: ' + error);
        });
    }

  });
