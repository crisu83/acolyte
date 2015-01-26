'use strict';

angular.module('acolyte')
  .controller('MainCtrl', function ($scope, authService, apiService, loaderService) {

    function init() {
      if (!authService.isGuest()) {
        var user = authService.getUser();
        var token = authService.getToken();
        loaderService.load();
          apiService.getStatus(user.name, token)
          .success(function (data) {
            loaderService.done();
            $scope.status = data.status;
          })
          .error(function (data) {
            loaderService.done();
          });
      }
    }

    function join() {
      if (!authService.isGuest()) {
        var user = authService.getUser();
        var token = authService.getToken();
        loaderService.load();
          apiService.joinChannel(user.name, token)
          .success(function (data) {
            loaderService.done();
            $scope.status = data.status;
          })
          .error(function (data) {
            loaderService.done();
          });
      }
    }

    function part() {
      if (!authService.isGuest()) {
        var user = authService.getUser();
        var token = authService.getToken();
        loaderService.load();
          apiService.partChannel(user.name, token)
          .success(function (data) {
            loaderService.done();
            $scope.status = data.status;
          })
          .error(function (data) {
            loaderService.done();
          });
      }
    }

    $scope.join = join;
    $scope.part = part;

    init();

  });
