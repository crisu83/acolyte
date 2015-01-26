'use strict';

angular.module('acolyte')
  .controller('DashboardCtrl', function ($scope, $rootScope, $timeout, authService, apiService, loaderService) {

    var user = authService.getUser();
    var token = authService.getToken();

    loaderService.load();

    apiService.getChannelSettings(user.name, token)
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
      loaderService.load();
      apiService.setChannelSettings(user.name, token, $scope.settings)
        .success(function (data) {
          loaderService.done();
        })
        .error(function (data) {
          loaderService.done();
        });
    };

  });
