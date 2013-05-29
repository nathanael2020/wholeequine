$(function(){
var open_tooltip_in_window = function (options){
  var height =  options["height"]||300;
  var width =  options["width"]||450;
  var content = options["content"];
  var window_name = options["window_name"]||'Ingredient';

	if (window.innerWidth) {
	  LeftPosition =(window.innerWidth-width)/2;
	  TopPosition =((window.innerHeight-height)/4)-50;
	}	else {
	  LeftPosition =(parseInt(window.screen.width)-	width)/2;
	  TopPosition=((parseInt(window.screen.height)-height)/2)-50;
	}
	attr = 'resizable=no,scrollbars=yes,width=' + width + ',height=' +height + ',screenX=300,screenY=200,left=' + LeftPosition + ',top=' +	TopPosition + '';
	ingredientWindow=open('', window_name, attr);
	ingredientWindow.document.write('<head><title>'+window_name+'</title>');

	ingredientWindow.document.write('<style>');
  ingredientWindow.document.write('body {border: 1px solid; cursor: default;background-color: white;background-color: white;border-radius: 6px;color: #000;padding: 10px 10px 15px 10px; position: absolute;z-index: 2147483647; font-family: "Gill Sans"; font-size: 11pt; line-height: 24px; width:410px; white-space: wrap}')

	ingredientWindow.document.write('.button{ border: 0.1em solid gray ; background-color: #ccc; padding: 5px; box-shadow: 2px 2px 4px #666; border-radius: 6px}');
	ingredientWindow.document.write('</style>');
	ingredientWindow.document.write('</head>');
	ingredientWindow.document.write('<body>');
	ingredientWindow.document.write(content);
	ingredientWindow.document.write("<hr/><span class='button' onClick='window.close();'>Close</span>");
  ingredientWindow.document.write('</body></html>');
  ingredientWindow.document.close();
  
	};

  var init_tooltip =  function(){
    $('.ingredient_tooltips').data('powertip', function( el) {
      var html = ["<div><span class='ingredient-name'>"]
      html.push($(el).data('powertip_name'))
      html.push("</span><hr/><span class='ingredient-desc'>")
      html.push($(el).data('powertip_desc'))
      html.push("</span><hr/>")
      html.push("<a href='#' class='open-tooltip-ingredient'>Open in window</a>")
      html.push("<a style='margin-left: 15px;' href='../products?utf8=✓&keywords=" + $(el).data('powertip_name') + "'>See everything with " + $(el).data('powertip_name') + "</a>")
      html.push("</html>")
	    return html.join('');
    });
    $('.ingredient_tooltips').powerTip({ 	mouseOnToPopup: true, placement: 'e' });
  };

  init_tooltip();

  $('body').on('click', '.open-tooltip-ingredient', function(e){
    var tooltipContent = $(e.currentTarget).parents("#powerTip");
    var ingredient_name = $('.ingredient-name', tooltipContent).text();
    var ingredient_desc = $('.ingredient-desc', tooltipContent).text();
    open_tooltip_in_window({window_name: 'Ingredient: '+ingredient_name, content: [ingredient_name, '<hr/>', 'Description: ', ingredient_desc ].join(' ')})
    return false;
  })

  var amount_ingredient = function(list_ingredients, calculate_ingredient ){
    var sum = 0;
    $.each(list_ingredients, function(i, item){
      var v = item.product_ingredient
      if (v.ingredient_id == calculate_ingredient.id){
        sum = sum + v.amount_per_serving;
      }
    })
    return sum;
  }
  $('#cart-toggle-ingredients-table').click(function(){
    $('#cart-ingredients').toggle();
    return false;
  })

  $("#update-ingredients-table").click(function(){
    $('#ingredients-table-container').load(window.location.href+'.js')
    return false;
  })

  $("#ingredient_taxon").on("change", function(){
    $('.ingredient_tooltips').powerTip('destroy')
    var current_taxon_id = $(this).val();
    var table = ("table.table-search-result-ingredients:first")
    var tr = ["<tr>"];
    tr.push('<th style="min-width: 200px">Ingredient</th>');
    var product_ids = []
    var products = $.map(supplment_products, function(i){
      var taxon_ids = i.taxon_ids
      if ($.inArray(parseInt(current_taxon_id), taxon_ids) != -1){
        product_ids.push(i.id)
        return i
      }
    })
         
    $.each(products, function(i, item){
      tr.push('<th style="min-width: 200px"><a href="../products/'+item.permalink+'">'+item.name+'</a></th>');
    })

    tr.push("</tr>");

    var servings = $.map(servings_data, function(item){
      if ($.inArray(item.product_id, product_ids ) != -1){
        return item
      }
    });

    /* Servings Per Container */
    tr.push("<tr>");
    tr.push("<td>Servings Per Container</td>");
    $.each(servings, function(i, item){
      tr.push("<td>"+item.cost+"</td>");
    });
    tr.push("</tr>");

    /* Price Per Serving */
    tr.push("<tr>");
    tr.push("<td>Price Per Serving</td>");
    $.each(servings, function(i, item){
      tr.push("<td>"+(item.price||'')+"</td>");
    });

    tr.push("</tr>");

         tr.push('<tr style="height:35px;"><td></td><td></td><td></td></tr>');

    var ingredients = $.map(ingredients_table, function(item){
      var show_item = false
      $.each(item[1], function(i, _item){
        if ($.inArray(_item.product_id, product_ids ) != -1){
          show_item = true;
        }
      });
      if (show_item){
        return [item]
      }
    });

    $.each(ingredients, function(i, item){
      tr.push('<tr>')

      tr.push('<td>')
      tr.push('<span class="ingredient_tooltips" data-powertip_name="'+item[0].ingredient.name+'" data-powertip_desc="'+item[0].ingredient.description+'" >')
      tr.push(item[0].ingredient.name)
      tr.push('</span>')
      tr.push('</td>')

      $.each(products, function(i, _item){
        var item_products = item[1]
        var current_item_product =  null;
        $.each(item_products,function(v, v_item){
          if (v_item.product_id == _item.id){
            current_item_product = v_item;
          }
        })
        tr.push('<td>')
        if (current_item_product){
          tr.push(amount_ingredient(current_item_product.product_ingredients, item[0].ingredient))
          tr.push(" "+item[0].ingredient.unit)
        }
        tr.push('</td>')
      })

      tr.push('</tr>')
    });
    $("tr, thead, tbody", table).remove();
    $(table).append(tr.join(''));

    init_tooltip()
  });




})