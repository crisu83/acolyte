'use strict';

angular.module('acolyte')
  .controller('LoginCtrl', function ($scope, $window, authService) {

    authService.getAuthUrl()
      .then(function (authUrl) {
        $window.location.href = authUrl;
      }, function (error) {
        console.log('ERROR: ' + error);
      });

  });
