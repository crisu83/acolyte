'use strict';

angular.module('acolyte', [
  'ngRoute',
  'ui.bootstrap',
  'toggle-switch',
  'LocalStorageModule'
])
  .value('config', {
    authScope: 'user_read channel_editor channel_commercial channel_subscriptions'
  })
  .config(function (localStorageServiceProvider) {
    localStorageServiceProvider.setPrefix('acolyte');
  })
  .config(function ($routeProvider) {
    function ensureAuthenticated($q, authService) {
      var user = authService.getUser();
      if (user) {
        return $q.when(user);
      } else {
        return $q.reject({auth: false});
      }
    }

    $routeProvider.when('/', {
      templateUrl: 'partials/index.html',
      controller: 'IndexCtrl'
    });

    $routeProvider.when('/login', {
      templateUrl: 'partials/loading.html',
      controller: 'LoginCtrl'
    });

    $routeProvider.when('/auth', {
      templateUrl: 'partials/loading.html',
      controller: 'AuthCtrl'
    });

    $routeProvider.when('/logout', {
      templateUrl: 'partials/loading.html',
      controller: 'LogoutCtrl'
    });

    $routeProvider.when('/settings', {
      templateUrl: 'partials/settings.html',
      controller: 'SettingsCtrl',
      resolve: {
        auth: ensureAuthenticated
      }
    });

    $routeProvider.when('/memory', {
      templateUrl: 'partials/memory.html',
      controller: 'MemoryCtrl'
    });

    $routeProvider.otherwise({redirectTo: '/'});
  })
  .run(function ($rootScope, $location, authService) {
    $rootScope.user = authService.getUser();

    $rootScope.$on('#routeChangeError', function (name, current, previous, event) {
      if (event.auth === false) {
        $location.path('/login');
      }
    });
  });
