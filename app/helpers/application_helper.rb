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
	   
	   
	   #.innerHTML actualiza o contador (char_count_out_id no app/views/shared/_micropost_form.html.erb) com o número de caracteres 
	   #que ainda faltam para os 140.
     #innerHTML -> By manipulating an element's innerHtml you'll be able to change the contents of an HTML element.
	   
	   # javascript_tag() -> Returns a JavaScript tag with the content inside.
     # O que se esta aqui a fazer é a correr a função dentro de um Script. 
     # O número de caracteres que ainda faltam para atingir o maximo ou o número de carateres em excesso é colocado na var out.
     
     #A linha observe_field é reponsável pela actualização em real time do número de caracteres em falta ou em excesso.

	   
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
