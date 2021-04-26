$(document).ready(function(){
    var indexContent = $('#content').html();
    
      $('#demo-carousel').carousel();
      $('#demo-carousel2').carousel();
      $('.materialboxed').materialbox();
      $('.tooltipped').tooltip();
      
      $('#pucmonpage').click(function(e){
            $('#content').load('pucmon.html');
            e.preventDefault();        
      });
      
      $('#2dmbpage').click(function(e){
            alert(indexContent);
            $('#content').html(indexContent);
            e.preventDefault();        
      });
    
      
    });
 
