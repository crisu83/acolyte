'use strict';

angular.module('acolyte')
  .controller('MemoryCtrl', function ($scope, $interval, apiService, loaderService) {

    $scope.memory = {};

    function loadMemory() {
      loaderService.load();

      apiService.dumpMemory()
        .success(function (data) {
          loaderService.done();
          if (data.success) {
            $scope.memory = data.memory;
          }
        })
        .error(function (data) {
          loaderService.done();
        });
    }

    function deleteEntry(id) {
      loaderService.load();

      apiService.deleteMemoryEntry(id)
        .success(function (data) {
          loaderService.done();
          if (data.success) {
            delete $scope.memory[id]
          }
        })
        .error(function (data) {
          loaderService.done();
        });
    }

    loadMemory();

    $interval(loadMemory, 1000 * 30);

    $scope.deleteEntry = deleteEntry;

  });
