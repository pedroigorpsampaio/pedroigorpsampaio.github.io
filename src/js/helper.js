$(document).ready(function(){
      $('#demo-carousel').carousel();
       $('#demo-carousel2').carousel();
       $('.materialboxed').materialbox();
      $('.tooltipped').tooltip();
      
      $('#pucmonpage').click(function(e){
          
            $('#content').load('pucmon.html');
            e.preventDefault();
        
    });
      
    });
 
