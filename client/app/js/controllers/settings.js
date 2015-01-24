'use strict';

angular.module('acolyte')
  .controller('SettingsCtrl', function ($scope, $rootScope, $timeout, apiService, loaderService) {

    var user = $rootScope.user;

    loaderService.load();

    apiService.getUserSettings(user.name)
      .success(function (data) {
        loaderService.done();
        if (data.success) {
          $scope.settings = data.settings;
        }
      })
      .error(function (data) {
        loaderService.done();
      });

    $scope.save = function () {
      $rootScope.loading = true;
      apiService.setUserSettings(user.name, $scope.settings)
        .success(function (data) {
          loaderService.done();
        })
        .error(function (data) {
          loaderService.done();
        });
    };

  });
