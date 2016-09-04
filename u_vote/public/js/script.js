"use strict";
(function(){
console.log("js loaded")

var email = $('#email-input').val()
var status_buttons = $('.status-buttons')

$('#email-input').on("click", function(){
  if (this.value === "Ex: homer.simpson@springfielduni.edu") {
       this.value = '';
   }
   var buttons = $('.status-buttons')
   buttons.css("opacity", "1")
})

})();
