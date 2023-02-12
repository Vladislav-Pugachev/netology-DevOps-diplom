token="${token}"
cloud_id="${cloud_id}"
%{for folder in folders~}
%{if folder.description != "admin"}
folder_id_${folder.description}="${folder.id}"
%{endif}
%{endfor~}
