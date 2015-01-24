'use strict';

angular.module('acolyte')
  .controller('SettingsCtrl', function ($scope, $timeout) {

    $scope.loading = false;

    $scope.config = {
      show_greet: false,
      show_follows: false
    };

    $scope.save = function () {
      $scope.loading = true;
      $timeout(function () {
        console.log('saved');
        $scope.loading = false;
      }, 1000);
    };

  });
