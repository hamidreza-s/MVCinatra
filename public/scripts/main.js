require.config({
  baseUrl: '/scripts',
  paths: {
    jquery: 'libraries/jquery/jquery',
    underscore: 'libraries/underscore/underscore',
    backbone: 'libraries/backbone/backbone'
  },
  shim: {
    underscore: {
      exports: '_'
    },
    backbone: {
      deps: ["underscore", "jquery"],
      exports: "Backbone"
    }
  }
});

require(['jquery', 'modules/notes', 'modules/users'], function($, notes, users, users){
  // not yet!
});
