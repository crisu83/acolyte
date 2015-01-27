'use strict';

angular.module('acolyte')
  .controller('DashboardCtrl', function ($scope, authService, apiService, loaderService) {

    var state = authService.getState();

    $scope.follows = [];

    loaderService.load('follows');
    apiService.getFollows(state.user.name, state.token)
      .success(function (json) {
        loaderService.done('follows');
        if (json.success) {
          $scope.follows = json.data.follows;
        }
      })
      .error(function (json) {
        loaderService.done('follows');
      });

    loaderService.load('settings');
    apiService.getChannelSettings(state.user.name, state.token)
      .success(function (json) {
        loaderService.done('settings');
        if (json.success) {
          $scope.settings = json.data.settings;
        }
      })
      .error(function (json) {
        loaderService.done('settings');
      });

    $scope.save = function () {
      loaderService.load('save');
      apiService.setChannelSettings(state.user.name, state.token, $scope.settings)
        .success(function (json) {
          loaderService.done('save');
        })
        .error(function (json) {
          loaderService.done('save');
        });
    };

  });
