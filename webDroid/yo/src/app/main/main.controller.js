(function() {
    'use strict';

    angular
        .module('yo')
        .controller('MainController', MainController);

    function MainController(StoreService, $log, $filter, $scope) {
        var vm = this;
        activate();

        function activate() {
            angular.element('.search').trigger('focus');
            doSearch();
        }
        vm.doSearch = doSearch;
        vm.search = "";
        vm.icon = "";
        vm.map = {
            center: { latitude: 49.266292, longitude: -123.136226 },
            zoom: 15
        };
        vm.clickEventsObject = {
            click: markerClicked
        };

        function markerClicked(marker, e) {
            if (vm.idKey != marker.model.idKey) {
                vm.showSide = true;
            } else {
                vm.showSide = !vm.showSide;
            }
            vm.selectedShop = {
                id: marker.model.idKey,
                data: vm.markers[marker.model.idKey]
            }
            vm.idKey = marker.model.idKey;
        }
        vm.closeSide = function() {
            vm.showSide = false;
        }

        function doSearch(vm.search) {
            StoreService.Search().then(function(data) {
                vm.markers = data;
                //$log.debug("data", data);                        
                var icon = "../assets/images/Shopify-icon.png";
                if (vm.search.toLowerCase().indexOf('turtles:') != -1) {
                    icon = '../assets/images/turtle@64.png';
                }
                angular.forEach(vm.markers, function(user, uId) {
                    vm.markers[uId].icon = icon;
                });
            }, function(error) {
                $log.debug('error:' + error);
            });
        }
    }
})();
