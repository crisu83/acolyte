'use strict';

angular.module('acolyte')
.controller('AuthCtrl', function ($scope, hubotService) {

  var url = '';
  var scope = 'user_read';

  hubotService.auth()
    .success(function (data) {
      $scope.AuthCtrl.url = data.url + '&scope=' + scope;
    })
    .error(function (error, data) {
      console.log('ERROR: ' + error);
    });

  $scope.AuthCtrl = {
    url: url,
    scope: scope
  };

});
