(function() {
    'use strict';
    angular
        .module('yo')
        .factory('authInterceptor', authInterceptor);

    function authInterceptor($q, $log) {
        return {
            request: function(config) {
                config.headers = config.headers || {};
                //config.addHeader("Access-Control-Allow-Origin", "*");
                config.headers.Authorization = 'Bearer 60f96cd1c0918bcb1dd835bcb872eb6a13c71ac054cb0abf2405450cdef29b74';
                return config;
            },
            response: function(response) {
                return response || $q.when(response);
            },
            responseError: function(rejection) {
                $log.debug('Error', rejection);
            }
        };
    }   
})();
