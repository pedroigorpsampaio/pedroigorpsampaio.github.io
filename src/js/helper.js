$(document).ready(function(){
      // initializers
      $('#demo-carousel').carousel();
      $('#demo-carousel2').carousel();
      $('.materialboxed').materialbox();
      $('.tooltipped').tooltip();
      
      // page loaders
      $('#pucmonpage').click(function(e){
            $('#content').load('pucmon.html');
            e.preventDefault();        
      });
      
      $('#2dmbpage').click(function(e){
            $('#content').load('2dmb.html');
            e.preventDefault();        
      });
    
      $('#mcpage').click(function(e){
            $('#content').load('mc.html');
            e.preventDefault();        
      });
          
      $('#p3dpage').click(function(e){
            $('#content').load('pseudo3d.html');
            e.preventDefault();        
      });
    });
 
