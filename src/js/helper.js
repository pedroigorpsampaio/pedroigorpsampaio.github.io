$(document).ready(function(){
      // initializers
      $('#demo-carousel').carousel({duration:170});
      $('#demo-carousel2').carousel({duration:170});
      $('.materialboxed').materialbox();
      $('.tooltipped').tooltip();
      $('.carousel.carousel-slider').carousel({
        fullWidth: true,
        indicators: true
      });      
      
      // page loaders
      $('#pucmonpage').click(function(e){
            e.preventDefault();   
            $('#content').load('pucmon.html');     
            return false;
      });
      
      $('#2dmbpage').click(function(e){
            e.preventDefault();   
            $('#content').load('2dmb.html');     
            return false;
      });
    
      $('#mcpage').click(function(e){
            e.preventDefault();   
            $('#content').load('mc.html');     
            return false;   
      });
          
      $('#p3dpage').click(function(e){
            e.preventDefault();   
            $('#content').load('pseudo3d.html');     
            return false;      
      });
      
      $('#egamespage').click(function(e){
            e.preventDefault();   
            $('#content').load('egames.html');     
            return false;      
      });  

      $('#zeldapage').click(function(e){
            e.preventDefault();   
            $('#content').load('zelda.html');     
            return false;      
      });
      
      $('#otherpage').click(function(e){
            e.preventDefault();   
            $('#content').load('other.html');     
            return false;      
      });
      
      // nav-bar timer for materialboxed toggle check
      setInterval(function(){ 
          if($(".materialboxed.active").length) {
            $('.navbar-fixed').css({'display': 'none'});       
          } 
          else {
            $('.navbar-fixed').css({'display': 'initial'});  
          }
      }, 200);

    
    });
 
