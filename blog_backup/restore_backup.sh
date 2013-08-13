# pull in the backup, untar and expand it, copy the website files, import the db
mkdir /tmp/restore
cd /tmp/restore
tar -zxvf /var/blog_backup/rposbowordpressrestoredemo.*.tar.gz
sudo cp -Rf /tmp/restore/var/www/wordpress/* /var/www/wordpress/
mysql -uroot -pmyrootpwd wordpress < /tmp/restore/home/vagrant/_backup/rposbowordpressrestoredemo.*.sql

# create the .htaccess to support mod_rewrite for pretty permalinks
sudo cp /var/blog_backup/.htaccess /var/www/wordpress/
sudo chmod 644 /var/www/wordpress/.htaccess

# set the default site to locahost for testage
mysql -uroot -pmyrootpwd wordpress -e "UPDATE wp_options SET option_value='http://localhost:8080' WHERE wp_options.option_name='siteurl'"
mysql -uroot -pmyrootpwd wordpress -e "UPDATE wp_options SET option_value='http://localhost:8080' WHERE wp_options.option_name='home'"