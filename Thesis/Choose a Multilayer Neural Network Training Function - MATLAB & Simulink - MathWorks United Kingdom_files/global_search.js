	$(function(){
		clearTextOnFocus();
	});

    function clearTextOnFocus(){

        var text_fields_to_clear = ['.clear_text_onfocus','.clear_global_search_text_onfocus'];
        var submit_fields_to_clear = ['.clear_text_onsubmit','.clear_global_search_text_onsubmit'];

        function createfunc(i) {
               var clearMePrevious = "";
                
                // clear input on focus
                $(text_fields_to_clear[i]).focus(function() {
                    
                    if($(this).val()==$(this).attr('value')) {
                        
                        clearMePrevious = $(this).val();
                        $(this).val('');
                        $(this).addClass('search_not_empty');
                    }
                });

                // if field is empty afterward, add text again
                $(text_fields_to_clear[i]).blur(function()
                {
                    if($(this).val()=='') {
                        
                        $(this).val(clearMePrevious);
                        $(this).removeClass('search_not_empty');
                    }
                    
                });

                // prevent default text from being submitted on click of submit button  
                $(submit_fields_to_clear[i]).on("click", function() {
                    var searchbox = $(text_fields_to_clear[i]);
                    if(searchbox.val() == searchbox.attr('value')) {
                        searchbox.val('');
                    } 
                }); 

            return function() { 
            };
        }


        for (var i = 0; i<text_fields_to_clear.length; i++) {
                createfunc(i);
        }


    }