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
//= require jquery-ui.min
//= require jquery.rating
//= require store/spree_address_book
//= require ./spree_fancy
//= require store/user_addresses
//= require_self

$(function(){

    $("#sort-products").on("change", function(event){
        window.location.href = $(this).val();
    });
    
    
    $("#tabs").tabs();
    if (window.show_popup_user_info){
        if (!$("#user-info-popup").length){  $("body").append("<div id='user-info-popup'></div>"); }
        $("#user-info-popup").load("/account/info", function(){
            $("#user-info-popup").dialog({
                dialogClass: "previewPopulator",
                width: '50%',
                height: '600',
                title: "1 ITEM ADDED TO YOUR BAG",
                modal: true});
            $("#close-user-info-popup").on("click", function(){
            $("#user-info-popup").dialog('close'); })

        })

    };
    $("#link-to-cart a").on('click', function(event){
        if (!!$('#cart_bag:hidden').length){
            $('#cart_bag').load('/orders/bag.js',function(){ $('#cart_bag').fadeToggle() })
        } else { $('#cart_bag').fadeToggle(); }
        return false;
    })

    $("#add_new_horse").on("click", function(){
        var t = $("#table-horses tr:eq(1)").clone();
        var n = $("#table-horses tr").size() - 1;
        t.find("td:last").empty();
        $.each($("input", t), function(i, item){
            $(item).attr("name", $(item).attr('name').replace(/\d/, n));
            $(item).val('')
        });
        $("#table-horses").append(t)
        return false;
    });
    
})
