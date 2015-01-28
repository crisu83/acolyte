'use strict';

angular.module('acolyte')
.factory('noteService', function ($rootScope, $timeout) {

  var timeout = null;

  $rootScope.note = { state: 'default', message: null, visible: false };

  function set(state, message) {
    $rootScope.note = { state: state, message: message, visible: true };
    if (timeout) {
      $timeout.cancel(timeout);
    }
    timeout = $timeout(function () {
      $rootScope.note.visible = false;
    }, 3000);
  }

  function success(message) {
    set('success', message);
  }

  function warning(message) {
    set('warning', message);
  }

  function error(message) {
    set('error', message);
  }

  return {
    success: success,
    warning: warning,
    error: error
  };

});
