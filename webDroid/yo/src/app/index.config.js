(function() {
  'use strict';

  angular
    .module('yo')
    .config(config);

  /** @ngInject */
  function config($logProvider, toastrConfig, uiGmapGoogleMapApiProvider,$httpProvider) {
    // Enable log
    //$httpProvider.defaults.useXDomain = true;
    //delete $httpProvider.defaults.headers.common['X-Requested-With'];    
    $httpProvider.defaults.useXDomain = true;
    $httpProvider.defaults.withCredentials = true;
    delete $httpProvider.defaults.headers.common["X-Requested-With"];
    $httpProvider.defaults.headers.common["Accept"] = "application/json";
    $httpProvider.defaults.headers.common["Content-Type"] = "application/json";

    // Set options third-party lib
    toastrConfig.allowHtml = true;
    toastrConfig.timeOut = 3000;
    toastrConfig.positionClass = 'toast-top-right';
    toastrConfig.preventDuplicates = true;
    toastrConfig.progressBar = true;

    uiGmapGoogleMapApiProvider.configure({
        key: 'AIzaSyBti25iE4KvCCkCmtZYhkezaV0gPeXI21g',
        v: '3.20'//, //defaults to latest 3.X anyhow
        //libraries: 'weather,geometry,visualization'
    });    
  }
// Key  AIzaSyBti25iE4KvCCkCmtZYhkezaV0gPeXI21g
// Type  Browser
// Creation date  Oct 24, 2012, 1:58:48 PM

})();