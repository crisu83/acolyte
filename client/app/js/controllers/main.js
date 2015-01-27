'use strict';

angular.module('acolyte')
  .controller('MainCtrl', function ($scope, authService, apiService, loaderService) {

    function init() {
      var state = authService.getState();
      if (authService.isAuthenticated(state)) {
        loaderService.load('init');
        apiService.getStatus(state.user.name, state.token)
          .success(function (json) {
            loaderService.done('init');
            if (json.success) {
              $scope.status = json.data.status;
            }
          })
          .error(function (json) {
            loaderService.done('init');
          });
      }
    }

    function joinChannel() {
      var state = authService.getState();
      if (authService.isAuthenticated(state)) {
        loaderService.load('joinChannel');
        apiService.joinChannel(state.user.name, state.token)
          .success(function (json) {
            loaderService.done('joinChannel');
            if (json.success) {
              $scope.status = json.data.status;
            }
          })
          .error(function (json) {
            loaderService.done('joinChannel');
          });
      }
    }

    function leaveChannel() {
      var state = authService.getState();
      if (authService.isAuthenticated(state)) {
        loaderService.load('leaveChannel');
        apiService.partChannel(state.user.name, state.token)
          .success(function (json) {
            loaderService.done('leaveChannel');
            if (json.success) {
              $scope.status = json.data.status;
            }
          })
          .error(function (json) {
            loaderService.done('leaveChannel');
          });
      }
    }

    $scope.joinChannel = joinChannel;
    $scope.leaveChannel = leaveChannel;

    init();

  });
