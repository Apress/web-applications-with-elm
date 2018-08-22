#!/usr/bin/env node
var jsdom = require("jsdom");
var Promise = require('promise');
//var Elm = require('./elm.js');

// var window = jsdom.jsdom(
//   '<!DOCTYPE html><html><head></head><body><script>if (typeof module === "object") {window.module = module; module = undefined;}</script><script src="./elm.js"></script><script>if (window.module) module = window.module;</script><script type="text/javascript">var app=Elm.ShellScript.fullscreen()</script></body></html>').defaultView;

jsdom.env({
            html: '<!DOCTYPE html><html><head></head><body><script>if (typeof module === "object") {window.module = module; module = undefined;}</script><script src="./elm.js"></script><script>if (window.module) module = window.module;</script><script type="text/javascript">var app=Elm.ShellScript.fullscreen();af=function(word) {console.log(word);};app.ports.check.subscribe(af);</script></body></html>',
            scripts: [],
            features : {
              FetchExternalResources : ['script'],
              ProcessExternalResources : ['script']
            },
            virtualConsole: jsdom.createVirtualConsole().sendTo(console),
            done: function (err, window) {
              done = false;
              //console.log(window.app);
              // window.app.ports.check.subscribe(function(word) {
              //   var ret = "Got it:  " + word;
              //   done = true;
              //   console.log(ret);
              // });
              var _flagCheck = setInterval(function() {
                  if (done === true) {
                      clearInterval(_flagCheck);
                      callbackf; // the function to run once all flags are true
                  }
              }, 100);
              s = "Hi from Node";
              window.app.ports.suggestions.send(s);
              // while (!done) {
              // }
              //console.log(window.af);
            }
          });
callbackf = function(){};

//vc = jsdom.getVirtualConsole(window);
// function CallElm(word){
//   return new Promise(function (fulfill, reject){
//     window.app.ports.check.subscribe(function(word) {
//       var ret = "Got it:  " + word;
//       console.log(ret);
//     });
//     window.app.ports.suggestions.send(word).done(function (res){
//       try {
//         fulfill(console.log("fulfilled"));
//       } catch (ex) {
//         reject(ex);
//       }
//     }, reject);
//   });
// }





// console.log(window.app);
// console.log(Elm.ShellScript);
// var app = Elm.ShellScript.fullscreen();
// app.ports.suggestions.send("hi");
// app.ports.check.subscribe(function(s) {
//   console.log(s);
// });
