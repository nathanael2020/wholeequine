//= require admin/spree_core
console.log('dffffffffffffffffffffffffffff')
function cleanIngredientsTaxons(data) {
  var taxons = $.map(data['taxons'], function(result) {
    return result
  })
  return taxons;
}

$(document).ready(function() {
  if ($("#ingredient_taxon_ids").length > 0) {
    $("#ingredient_taxon_ids").select2({
      placeholder: Spree.translations.taxon_placeholder,
      multiple: true,
      initSelection: function(element, callback) {
        return $.getJSON(Spree.routes.taxon_search + "?ids=" + (element.val()), null, function(data) {
          return callback(self.cleanIngredientsTaxons(data));
        })
      },
      ajax: {
        url: Spree.routes.taxon_search,
        datatype: 'json',
        data: function(term, page) {
          return { q: term }
        },
        results: function (data, page) {
          return { results: self.cleanIngredientsTaxons(data) }
        }
      },
      formatResult: function(taxon) {
        return taxon.pretty_name
      },
      formatSelection: function(taxon) {
        return taxon.pretty_name
      }
    })
  }
})
