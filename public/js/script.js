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

var redirectToken = $(".redirect-token");

if (redirectToken.length > 0){
  console.log("token found")
}

am_i_registered.on("click", function(){
  var url = 'http://www.rockthevote.com/get-informed/elections/am-i-registered-to-vote/'
  var win = window.open(url, '_blank');
  win.focus();
})

need_to_register.on("click", function(){
  var url = '/register'
  var win = window.open(url, '_blank');
  win.focus();
})

ive_registered.on("click", function(){
  var url = "/rankings"
  var win = window.open(url, '_blank');
  win.focus();
})

$(".search_form").on("click", function(){
  if (this.value === "Search schools by name, zip, or county!") {
       this.value = '';
       $(this).css("opacity", "1")
   };
})

})();
