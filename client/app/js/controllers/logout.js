'use strict';

angular.module('acolyte')
  .controller('LogoutCtrl', function ($scope, $rootScope, $timeout, $location, authService) {

    authService.logout();
    $rootScope.user = null;
    $location.path('/');

  });
