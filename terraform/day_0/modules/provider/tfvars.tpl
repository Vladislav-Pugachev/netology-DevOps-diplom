token="${token}"
cloud_id="${cloud_id}"
%{for folder in folders~}
folder_id_${folder.description}="${folder.id}"
%{endfor~}
