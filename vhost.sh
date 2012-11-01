#!/bin/bash
echo "Informe o nome do server (Ex.: projeto.local) :"
read server

echo "Informe o caminho do site (Ex.: /var/www/adler) :"
read path

echo "Criando configuração de VHost para o server"

echo "<VirtualHost *:80>
	ServerAdmin webmaster@localhost
	ServerName $server
	ServerAlias www.$server

	DocumentRoot \"$path\"

	<Directory \"$path\">
		Options Indexes FollowSymLinks MultiViews
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>
     </VirtualHost>" > /etc/apache2/sites-available/$server

echo "Ativando VHOST $server"
ln -s /etc/apache2/sites-available/$server /etc/apache2/sites-enabled/$server

echo "Atualizando arquivo hosts"
echo "127.0.1.1		$server	www.$server" >> /etc/hosts

echo "Reiniciando apache";
/etc/init.d/apache2 restart

echo "VHOST criado";
