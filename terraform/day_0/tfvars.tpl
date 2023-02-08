token=${token}
cloud_id=${cloud_id}
mikrotik_login=${mikrotik_login}
mikrotik_pass=${mikrotik_pass}
%{for folder in folders~}
%{if folder.description != "admin"}
folder_id_${folder.description}="${folder.id}"
%{endif}
%{endfor~}
