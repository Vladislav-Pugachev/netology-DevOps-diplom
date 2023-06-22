 sudo mkdir -p /var/www/dyplompugachevvv.freedynamicdns.org/html

sudo chown -R $USER:$USER /var/www/dyplompugachevvv.freedynamicdns.org/html
sudo chmod -R 755 /var/www/dyplompugachevvv.freedynamicdns.org
sudo vi  /var/www/dyplompugachevvv.freedynamicdns.org/html/index.html
```
<html>
    <head>
        <title>Welcome to diplom2!</title>
    </head>
    <body>
        <h1>Success!  The diplom server block is working!</h1>
    </body>
</html>

```
sudo vi /etc/nginx/sites-available/dyplompugachevvv.freedynamicdns.org
```
server {
        listen 80;
        listen 443;


        root /var/www/dyplompugachevvv.freedynamicdns.org/html;
        index index.html index.htm index.nginx-debian.html;

        server_name dyplompugachevvv.freedynamicdns.org;

        location / {
                try_files $uri $uri/ =404;
        }
}

```

sudo ln -s /etc/nginx/sites-available/dyplompugachevvv.freedynamicdns.org /etc/nginx/sites-enabled/

sudo systemctl restart nginx

sudo certbot --nginx -d dyplompugachevvv.freedynamicdns.org