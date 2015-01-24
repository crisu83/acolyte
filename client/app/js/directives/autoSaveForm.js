'use strict';

angular.module('acolyte')
  .directive('autoSaveForm', function ($timeout) {
    return {
      restrict: 'A',
      require: '^form',
      scope: {
        callback: '=autoSaveForm',
        delay: '=autoSaveDelay'
      },
      link: function (scope, element, attrs, formCtrl) {
        var timeout = null;
        scope.$watch(function () {
          if (formCtrl.$dirty) {
            if (timeout) {
              $timeout.cancel(timeout);
            }
            timeout = $timeout(function () {
              if (angular.isFunction(scope.callback)) {
                scope.callback();
                formCtrl.$setPristine();
              }
            }, scope.delay || 1000);
          }
        });
      }
    }
  });
