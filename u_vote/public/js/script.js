"use strict";
(function(){
console.log("js loaded")

const am_i_registered = $("#am-i-registered");
const ive_registered = $("#ive-registered");
const need_to_register = $("#need-to-register");
const status_bar = $("#status-instruction");

$('#email-input').on("click", function(){
  if (this.value === "Ex: Homer.J.Simpson@SpringfieldUni.edu") {
       this.value = '';
       $(this).css("opacity", "1")
   };
   var buttons = $('.status-buttons');
})

})();
