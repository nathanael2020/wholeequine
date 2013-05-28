// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require ./jquery
//= require jquery_ujs

//= require store/spree_core
//= require store/spree_promo
//= require store/ingredients
//= require jquery.rating
//= require jquery-ui.min
//= require ./spree_fancy

//= require_self

$(function(){
  $("#tabs").tabs();

  $("#link-to-cart a").on('click', function(event){
    if (!!$('#cart_bag:hidden').length){
      $('#cart_bag').load('/orders/bag.js',function(){ $('#cart_bag').fadeToggle() })
    } else { $('#cart_bag').fadeToggle(); }
    return false;
  })

})
