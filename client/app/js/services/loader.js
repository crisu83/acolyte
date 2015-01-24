'use strict';

angular.module('acolyte')
.factory('loaderService', function ($rootScope, $timeout) {

  function load() {
    $rootScope.loading = true
  }

  function done() {
    $timeout(function () {
      $rootScope.loading = false
    }, 500);
  }

  return {
    load: load,
    done: done
  }

});
