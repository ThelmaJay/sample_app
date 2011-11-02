module ApplicationHelper
	def logo
		logo = image_tag("logo.png", :alt => "Sample App", :class => "round")
	end


	# Return a title on a per-page basis.
	def title
		base_title = "Ruby on Rails Tutorial Sample App"
		if @title.nil?
	         base_title
		else
	  	 "#{base_title} | #{@title}"
		end
	end
	
	#Exercise CH11 - Ex 1
	def warn_if_char_count_exceeded(field_id, update_id, maximum_number_of_chars, options = {})
	  #First attempt - Simple Counter
	   #var field_id => Conteúdo escrito até agora.
	   #var update_id => campo que mostra qtos caracteres faltam para atingir o max.
	   
    function = "var out = []; 
                var remaining_chars = $(#{maximum_number_of_chars}) - $F('#{field_id}').length; 
                
                if (remaining_chars >= 0) { 
                  out = remaining_chars; 
                  document.getElementById('#{field_id}').style.backgroundColor='white' 
                } 
                else { 
                  out = 'Too long by ' + remaining_chars; 
                  document.getElementById('#{field_id}').style.backgroundColor='red' 
                }

                $('#{update_id}').innerHTML = out;"

    out = javascript_tag(function)
    out += observe_field(field_id, options.merge(:function => function))
	end
end
