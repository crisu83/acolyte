'use strict';

angular.module('acolyte')
.factory('loaderService', function ($rootScope, $timeout) {

  var events = [];
  var timeout = null;

  function load(name) {
    $rootScope.loading = true;
    events.push(name || 'global');
    update();
  }

  function done(name) {
    events.splice(events.indexOf(name || 'global'), 1);
    update();
  }

  function update() {
    if (timeout) {
      $timeout.cancel(timeout);
    }
    timeout = $timeout(function () {
      $rootScope.loading = events.length > 0;
    }, 500);
  }

  return {
    load: load,
    done: done
  };

});
