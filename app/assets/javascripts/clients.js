function update_total(){
	var total = 0;
		$('.quote-fields').each(function(){
			total += $(this).find('.quote-price').val() * $(this).find('.quote-quantity').val();
		});
		$('#opportunity_price').val(total);
		var iva = $('#opportunity_price').val()*($('#opportunity_tax').val()/100)
		$('#iva').val(iva) 
}

function update_purchase_order_total(){
	var total =0;
	$('.purchase-item-fields').each(function(){
		total += $(this).find('.price').val() * $(this).find('.quantity').val();
	});
	total += parseFloat($("#purchase_order_shipping_and_handling").val());
	total += parseFloat($("#purchase_order_other_charges").val());
	$('#total').val(total);
}

function remove_fields(link){
	$(link).prev('input[type=hidden]').val(1);
	$(link).parents('.fields').hide();
}

function update_product_profit(){
	var total = 0;
	$('.cost-fields').each(function(){
		total -= parseFloat($(this).find('.total').val());
	});
	total -= parseFloat($("#product_investment").val());
	total += parseFloat($("#product_price").val());

	$('#product-profit').val(total);
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
  $('.quote-price, .quote-quantity').change(function(){
		update_total();
	});
  $('.total-change').change(function(){
		update_purchase_order_total();
	});
 	$('.product-code').change(function(){
		id = $(this).val();
		fields = $(this).parents('.fields');
		$.ajax({
			type: "GET",
			url: "/products.json",
			data: {code:id}
			})
			.done(function(data){
				fields.find('.quote-description').val(data["description"]);
				fields.find('.quote-quantity').val(1);
				fields.find('.quote-price').val(data["price"]);
				fields.find('.quote-product-id').val(data["id"]);
				update_total();
				});
		});
}

function updateURLParameter(url, param, paramVal){
    var newAdditionalURL = "";
    var tempArray = url.split("?");
    var baseURL = tempArray[0];
    var additionalURL = tempArray[1];
    var temp = "";
    if (additionalURL) {
        tempArray = additionalURL.split("&");
        for (i=0; i<tempArray.length; i++){
            if(tempArray[i].split('=')[0] != param){
                newAdditionalURL += temp + tempArray[i];
                temp = "&";
            }
        }
    }

    var rows_txt = temp + "" + param + "=" + paramVal;
    return baseURL + "?" + newAdditionalURL + rows_txt;
}


var client_ready = function(){
	$('.date').datetimepicker({
		language: 'es',
		pickTime: false,
		autoclose: true
		});
	$(document).on('change', '.profit-change',  function(){
		update_product_profit();
	});
	$('.total-change').change(function(){
		update_purchase_order_total();
	});

	$('.quote-price, .quote-quantity').change(function(){
		update_total();
	});

 	$('.product-code').change(function(){
		id = $(this).val();
		fields = $(this).parents('.fields');
		$.ajax({
			type: "GET",
			url: "/products.json",
			data: {code:id}
			})
			.done(function(data){
				fields.find('.quote-description').val(data["description"]);
				fields.find('.quote-quantity').val(1);
				fields.find('.quote-price').val(data["price"]);
				fields.find('.quote-product-id').val(data["id"]);
				update_total();
				});
		});
	$('.file-input-link').click(function(){
		$('.hidden-file-input').trigger('click');
	});
	$('.hidden-file-input').change(function(){
		$(this).parents('form').submit();
	});

	var clients = new Bloodhound({
	  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
	  queryTokenizer: Bloodhound.tokenizers.whitespace,
	  prefetch: {
	    // url points to a json file that contains an array of country names, see
	    // https://github.com/twitter/typeahead.js/blob/gh-pages/data/countries.json
	    url: '/clients/list',
	    // the json file contains an array of strings, but the Bloodhound
	    // suggestion engine expects JavaScript objects so this converts all of
	    // those strings
	    ttl: 60,
	    filter: function(list) {
	      return $.map(list, function(client) { return { name: client }; });
	    }
	  }
	});
	 

	 var suppliers = new Bloodhound({
	  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
	  queryTokenizer: Bloodhound.tokenizers.whitespace,
	  prefetch: {
	    // url points to a json file that contains an array of country names, see
	    // https://github.com/twitter/typeahead.js/blob/gh-pages/data/countries.json
	    url: '/suppliers/list',
	    // the json file contains an array of strings, but the Bloodhound
	    // suggestion engine expects JavaScript objects so this converts all of
	    // those strings
	    ttl: 60,
	    filter: function(list) {
	      return $.map(list, function(supplier) { return { name: supplier }; });
	    }
	  }
	});
	// kicks off the loading/processing of `local` and `prefetch`
	clients.initialize();

	suppliers.initialize();
	 
	// passing in `null` for the `options` arguments will result in the default
	// options being used
	$('#clients .typeahead').typeahead(null, {
	  name: 'clients',
	  displayKey: 'name',
	  // `ttAdapter` wraps the suggestion engine in an adapter that
	  // is compatible with the typeahead jQuery plugin
	  source: clients.ttAdapter()
	});

	$('#suppliers .typeahead').typeahead(null, {
	  name: 'suppliers',
	  displayKey: 'name',
	  // `ttAdapter` wraps the suggestion engine in an adapter that
	  // is compatible with the typeahead jQuery plugin
	  source: suppliers.ttAdapter()
	});


	var mexico_states = ['Aguascalientes','Baja California','Baja California Sur','Campeche','Chiapas','Chihuahua','Coahuila','Colima','Distrito Federal','Durango','Estado de México','Guanajuato','Guerrero','Hidalgo','Jalisco','Michoacán','Morelos','Nayarit','Nuevo León','Oaxaca','Puebla','Querétaro','Quintana Roo','San Luis Potosí','Sinaloa','Sonora','Tabasco','Tamaulipas','Tlaxcala','Veracruz','Yucatán','Zacatecas'];
	var us_states = ['Alabama','Alaska','Arizona','Arkansas','California','Colorado','Connecticut','Delaware','Florida','Georgia','Hawaii','Idaho','Illinois','Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Maryland','Massachusetts','Michigan','Minnesota','Mississippi','Missouri','Montana','Nebraska','Nevada','New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota','Ohio','Oklahoma','Oregon','Pennsylvania','Rhode Island','South Carolina','South Dakota','Tennessee','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming','District of Columbia','Puerto Rico','Guam','American Samoa','U.S. Virgin Islands','Northern Mariana Islands'];
	var empty_states = [''];
	var states;
	$('#form-country').change(function(){
		var name = $(this).attr('name').replace("[country]",'');
		$('#form-state').empty();
		$('#other-country').empty();
		$('#other-state').empty();
		if($('#form-country').val() == 'Estados Unidos'){
			states = us_states;
		}else if($('#form-country').val() == 'México'){
			states = mexico_states;
		}else{
			states = empty_states;
			$('#other-country').append('<input class="form-control" type="text" name="'+name+'[country]">');
			$('#other-state').append('<input class="form-control" type="text" name="'+name+'[state]">');
		}
		$.each(states, function(key, value) {   
		     $('#form-state')
		         .append($("<option></option>")
		         .attr("value",value)
		         .text(value)); 
		});
	});

	$('#state').change(function(){
		$('#state_form').submit();
	});

	$('#import-file').click(function(){
		$('#file').trigger('click');
	});

	$('#file').change(function(){
		$('#file-form').submit();
	});

	$('#per_page').change(function(){
		var per_page = $('#per_page').val();
		if($('#per_page').val() == 'Ver todos'){
			per_page = 10000;
		}

		var url = window.location.href

		if(url.indexOf('per_page') === -1){
			if(url.indexOf('?') === -1){
				url += '?per_page=' + per_page;
			}else{
				url += '&per_page=' + per_page;
			}
			window.location.href = url;
		}else{
			window.location.href = updateURLParameter(window.location.href, 'per_page', per_page);
		}
	});


	function h(e) {
  $(e).css({'height':'auto','overflow-y':'hidden'}).height(e.scrollHeight);
}
$('textarea').each(function () {
  h(this);
}).on('input', function () {
  h(this);
});
};

$(document).ready(client_ready);
$(document).on('turbolinks:load', client_ready);
