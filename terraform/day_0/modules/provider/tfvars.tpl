token="${token}"
cloud_id="${cloud_id}"
admin_bgw_external_ip = "${admin_bgw_external_ip}"
admin_bgw_internal_ip = "${admin_bgw_internal_ip}"
%{for folder in folders~}
folder_id_${folder.description}="${folder.id}"
%{endfor~}
