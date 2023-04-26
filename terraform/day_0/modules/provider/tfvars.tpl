token="${token}"
cloud_id="${cloud_id}"
bgw_ip_ext = "${bgw_ip_ext}"
%{for folder in folders~}
folder_id_${folder.description}="${folder.id}"
%{endfor~}
