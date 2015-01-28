'use strict';

angular.module('acolyte')
  .controller('SettingsCtrl', function ($scope, authService, apiService, loaderService) {

    var state = authService.getState();

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
