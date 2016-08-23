# docker-moinmoin19

```
sudo docker run -d --name moin \
-v moin-wiki:/srv/www/moin/wiki \
-e NGINX_SERVNAME=wiki.example.org \
-e WIKI_NAME="My Wiki" \
-e FRONT_PAGE="StartingPage" \
-e WIKI_SUPERUSER="MySuperUser" \
-e DEFAULT_LANG="ru" \
-p 80:80
jetrat/moinmoin19
```

After start you must create user from WIKI_SUPERUSER parameter using web interface - this user would get wiki admin access level.
