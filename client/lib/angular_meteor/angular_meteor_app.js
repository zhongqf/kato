var meteorApp = angular.module( "meteorApp", ['hashKeyCopier'] );

meteorApp.config(['$interpolateProvider', function($interpolateProvider){
  $interpolateProvider.startSymbol('[[').endSymbol(']]');
}]);

meteorApp.run(['$templateCache', function($templateCache){

  angular.forEach(Template, function(template, name) {
    var error, node;
    if (name.charAt(0) !== '_' && name !== 'prototype') {
      node = document.createElement('div');
      try {
        Blaze._throwNextException = true;
        Blaze.render(template, node);

        return $templateCache.put(name, node.innerHTML);
      } catch (_error) {
        error = _error;
        return console.log("Can not render template '" + name + "': " + error);
      }
    }
  });

}]);


meteorApp.factory('meteor', ['HashKeyCopier', function(HashKeyCopier){
  return {
    autorun: function(scope, fn) {

      //wrapping around Deps.autorun
      var comp;
      comp = Deps.autorun(function(c) {
        fn(c);

        // this is run immediately for the first call
        // but after that, we need to $apply to start Angular digest
        if (!c.firstRun) {

          return setTimeout(function() {

            // wrap $apply in setTimeout to avoid conflict with
            // other digest cycles
            return scope.$apply();
          }, 0);

        }
      });

      // stop autorun when scope is destroyed
      scope.$on("$destroy", function() {
        return comp.stop();
      });

      // return autorun object so that it can be stopped manually
      return comp;
    },

    bind: function(scope, collection, name) {

      if (!angular.isArray(collection)) {
        if (typeof collection.fetch === 'function') {
          collection = collection.fetch()
        }
        else{
          throw new TypeError("The second parameter must be a cursor or an array.")
        }
      }

      scope[name] = HashKeyCopier.copyHashKeys(scope[name], collection, ["_id"]);
    }

  }

}]);