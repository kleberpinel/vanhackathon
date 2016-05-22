(function() {
    'use strict';

    angular
        .module('yo')
        .controller('MainController', MainController);

    function MainController(StoreService, $log) {
        var vm = this;
        vm.doSearch = doSearch;
        vm.search = "shop";
        vm.icon = "assets/images/Shopify-icon.png";
        vm.map = {
            center: { latitude: 49.266292, longitude: -123.096226 },
            zoom: 13
        };
        vm.clickEventsObject = {
            click: markerClicked
        };

        vm.minus = function(i) {
            vm.selectedShop.data.products[i].qt--;
            showTotal();
        }

        vm.plus = function(i) {
            vm.selectedShop.data.products[i].qt++;
            showTotal();
        }
        function showTotal() {            
            var total = 0;
            angular.forEach(vm.selectedShop.data.products, function(item) {
                total += item.qt * item.price;
            })
            vm.total = total;
        }

        function markerClicked(marker) {
            if (vm.idKey != marker.model.idKey) {
                vm.showSide = true;
            } else {
                vm.showSide = !vm.showSide;
            }
            var data = "";
            angular.forEach(vm.markers, function(user, uId) {
                if (marker.model.idKey === vm.markers[uId].id) {
                    data = user;
                }
            });
            if (data) {            
                vm.selectedShop = {
                    id: marker.model.idKey,
                    data: data
                }
                angular.forEach(vm.selectedShop.data.products, function(item) {
                    item.qt = 0;
                })                   
            }
            vm.idKey = marker.model.idKey;
        }
        vm.closeSide = function() {
            vm.showSide = false;
        }

        function doSearch() {
            if (vm.search.length > 3) {
                if (vm.search.toLowerCase().indexOf('turtles:') != -1) {
                    vm.icon = 'assets/images/turtle@64.png';
                    vm.search = vm.search.replace(/turtles:/gi, "");
                }                
                StoreService.Search(vm.search).then(function(data) {
                    vm.markers = data;
                    angular.forEach(vm.markers, function(user, uId) {
                        vm.markers[uId].icon = vm.icon;
                    });
                }, function(error) {
                    $log.debug('error:' + error);
                });
                if (vm.search.toLowerCase().indexOf('shop') != -1) {
                    vm.search = "";                    
                }                
            }
        }
        activate();

        function activate() {
            angular.element('.search').trigger('focus');
            doSearch();
        }

        // $scope.totalItems = 64;
        // $scope.currentPage = 4;

        // $scope.setPage = function(pageNo) {
        //     $scope.currentPage = pageNo;
        // };

        // $scope.pageChanged = function() {
        //     $log.log('Page changed to: ' + $scope.currentPage);
        // };

        // $scope.maxSize = 5;
        // $scope.bigTotalItems = 175;
        // $scope.bigCurrentPage = 1;

    }
})();
