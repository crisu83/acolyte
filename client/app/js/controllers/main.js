'use strict';

angular.module('acolyte')
  .controller('MainCtrl', function ($scope, $location, authService, apiService, loaderService, noteService) {

    function init() {
      var state = authService.getState();
      if (authService.isAuthenticated(state)) {
        loaderService.load('init');
        apiService.getStatus(state.user.name, state.token)
          .success(function (json) {
            loaderService.done('init');
            if (json.success) {
              $scope.status = json.data.status;
            } else {
              noteService.error(json.error);
              $location.path('/logout');
            }
          })
          .error(function (json) {
            loaderService.done('init');
            noteService.error(json.error);
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
              noteService.success('Acolyte joined your channel');
            } else {
              noteService.error(json.error);
              $location.path('/logout');
            }
          })
          .error(function (json) {
            loaderService.done('joinChannel');
            noteService.error(json.error);
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
              noteService.warning('Acolyte left your channel');
            } else {
              noteService.error(json.error);
              $location.path('/logout');
            }
          })
          .error(function (json) {
            loaderService.done('leaveChannel');
            noteService.error(json.error);
          });
      }
    }

    $scope.joinChannel = joinChannel;
    $scope.leaveChannel = leaveChannel;

    init();

  });
