  	$(document).ready(function() {
	
		// check servers status to update link of map
		function server_map_redirect(){  
		    // get all servers listed through the status attribute
			var list = document.getElementsByClassName("status");
			
			// iterates each server found to update its map link based on current server status (online/offline)
			for (var i = 0; i < list.length; i++) {
	
				var sv_ip = $(list[i]).attr("data-playercounter-ip");
				var is_online = $(list[i]).text() == 'online' ? true : false;
				var res = sv_ip.split(":");
				var sv_port = res[1];
				// calculates dynmap port using the relation with sv ports
				var sv_dynport = 8100 + (parseInt(sv_port)-25500); 

				// if online, sets the link to the dynmap sv
				if(is_online) {
					// updates page
					$(list[i]).parents('.col.l4.s12').find('#dynmap').attr('href', 'http://omnium.serveminecraft.net:'+sv_dynport);
				} // if offline, link to error page
				else {
					$(list[i]).parents('.col.l4.s12').find('#dynmap').attr('href', 'error.php?did='+sv_dynport);
				}
			}
		}
		
		 // use setTimeout() to execute initial checks
		 setTimeout(server_map_redirect, 200)
		 setTimeout(server_map_redirect, 500)
		 setTimeout(server_map_redirect, 1000)
		 setTimeout(server_map_redirect, 2000)
		 
		// constant checking of servers state
		var myVar = setInterval(server_map_redirect, 60000);
	});