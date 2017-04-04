jQuery.fn.passwordStrength = function() {
    $(this).live('keyup', function() {
        var pass = $.trim($(this).val());
        var numericTest = /[0-9]/;
        var lowerCaseAlphaTest = /[a-z]/;
        var upperCaseAlphaTest = /[A-Z]/;
        var symbolsTest = /[.,!@#$%^&*()}{:<>|]/;
        var score = 0;

        if (numericTest.test(pass)) {
            score++;
        }
        if (lowerCaseAlphaTest.test(pass)) {
            score++;
        }
        if (upperCaseAlphaTest.test(pass)) {
            score++;
        }
        if (symbolsTest.test(pass)) {
            score++;
        }
        if (pass.length == 0 || pass=='' || pass==null) {
           $("#pwdPower").attr({"style":"display:none"});
        }else{
           var s_level=score;
           switch(true){
           
           		case s_level==1 :
           			$("#pwdPower").attr({"style":"display:block"});
           			$("#pwdPower").attr({"class":"lenbox lenL"});
                 break; 
                 
                case s_level==2 :
                	$("#pwdPower").attr({"style":"display:block"});
       				$("#pwdPower").attr({"class":"lenbox lenM"});		    
           	      break;
           	      
                case s_level==3 :
                	$("#pwdPower").attr({"style":"display:block"});
       				$("#pwdPower").attr({"class":"lenbox lenH"});		    
           	      break;  
           	      
                case s_level==4 :
                	$("#pwdPower").attr({"style":"display:block"});
                	$("#pwdPower").attr({"class":"lenbox lenH"});		    
                break;  
                
           	     default :
           	    	 $("#pwdPower").attr({"style":"display:none"});   
           }        
        }
    });
};