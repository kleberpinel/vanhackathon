(function() {
    'use strict';
    angular
        .module('yo')
        .service('StoreService', StoreService);

    function StoreService($http, API, $log) {
        var service = {};
        service.Search = Search;
        return service;

        function Search(q) {
            var u = url(q);
            $log.debug(u);
            return $http.get(u).then(handleSuccess, handleError('Error getting stores'));          
        }

        function url(q) {
            return API + '?q=' + q;
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
