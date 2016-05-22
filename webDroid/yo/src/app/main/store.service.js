(function() {
    'use strict';
    angular
        .module('yo')
        .service('StoreService', StoreService);

    function StoreService($http, $log, API) {
        var service = {};
        service.Search = Search;
        return service;

        function Search() {
            return $http.get(url()).then(handleSuccess, handleError('Error getting stores'));          
        }

        function url() {
            return API;
        }
        

        function handleSuccess(res) {
            return res.data;            
        }

        function handleError(error) {
            return function() {
                return {
                    success: false,
                    message: error
                };
            };
        }
    }
})();
