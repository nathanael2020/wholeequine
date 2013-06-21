module ApplicationHelper
  def sort_products(params = {})
    content_tag :select, :id => "sort-products" do
      option = content_tag(:option, option_options(:date, :asc, params)) do
        'Date Added (oldest first)'
      end
      option << content_tag(:option, option_options(:name, :asc, params)) do
        'Alphabetical (increasing)'
      end
      option << content_tag(:option, option_options(:name, :desc, params)) do
        'Alphabetical (decreasing)'
      end
      option << content_tag(:option, option_options(:date, :desc, params)) do
        'Date Added (newest first)'
      end
      option << content_tag(:option, option_options(:price, :asc, params)) do
        'Price (low to high)'
      end
      option << content_tag(:option, option_options(:price, :desc, params)) do
        'Price (high to low)'
      end
      option << content_tag(:option, option_options(:rating, :desc, params)) do
        'Rating (high to low)'
      end
      option << content_tag(:option, option_options(:rating, :asc, params)) do
        'Rating (low to high)'
      end

    end

  end

  def option_options(field, target, params = {})
    {:value => url_for(option_url_params(field, target, params)), :selected => current_sort?(field, target, params)}
  end

  def option_url_params(field, target, params = {})
    _options = { :sort => field, :ordering => target }
    _options[:keywords] = params[:keywords] if params.has_key? :keywords
    _options[:taxon] = params[:taxon] if params.has_key? :taxon
    _options[:page] = params[:page] if params.has_key? :page
    _options
  end
  def current_sort?(field, target, params = {})
    params.has_key?(:sort) &&
      (params[:sort].to_s == field.to_s) &&
      params.has_key?(:ordering) &&
      (params[:ordering].to_s == target.to_s)
  end

  def type_address(addr)
    case addr.position.to_i
    when 0
      "primary"
    when 1
      "second"
    else
      "other"
    end
  end

  def custom_address_field(form, method, id_prefix = "b", &handler)
    id_prefix = id_prefix == 'bill_address' ? 'b' : 's'
    content_tag :p, :id => [id_prefix, method].join, :class => "field" do
      if handler
        handler.call
      else
        is_required = Spree::Address.required_fields.include?(method)
        separator = is_required ? '<span class="required">*</span>' : ''
        
        if method == :name
        
	        form.label(method, 'Address Nickname') + separator.html_safe +
			form.text_field(method, :class => is_required ? 'required' : nil)
			
		else

	        form.label(method) + separator.html_safe +
			form.text_field(method, :class => is_required ? 'required' : nil)

		end
      end
    end
  end
end
