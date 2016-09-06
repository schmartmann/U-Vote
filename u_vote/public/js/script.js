"use strict";
(function(){
console.log("js loaded")

var email = $('#email-input').val();
var status_buttons = $('.status-buttons');

$('#email-input').on("click", function(){
  if (this.value === "Ex: homer.simpson@springfielduni.edu") {
       this.value = '';
       $(this).css("opacity", "1")
   };
   var buttons = $('.status-buttons');
   buttons.css("opacity", "1");
   var status = $("#status-instruction");
   status.show();
})


})();
