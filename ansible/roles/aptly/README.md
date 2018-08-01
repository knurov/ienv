#aptly
mkdir /var/aptly
apt-get install aptly
# gpg
gpg --gen-key
gpg --armor --export a.aleshkin@rc.center > .aptly/public/rc.center.sc.gpg.key

#gpg без пароля
nano aptly-key
	%echo Generating a default key
	Key-Type: default
	Subkey-Type: default
	Name-Real: Aptly Api
	Name-Comment: Ninja
	Name-Email: aptly@rc.local
	Expire-Date: 0
	%no-ask-passphrase
	%no-protection
	#%pubring aptly.pub
	#%secring aptly.sec
	# Do a commit here, so that we can later print "done" :-)
	%commit
	%echo done
gpg --batch --gen-key aptly-key
gpg --armor --export aptly@rc.local  > .aptly/public/rc.center.sc.gpg.key

aptly repo create -distribution=SC -component=main main-sc
aptly repo create -distribution=SC -component=testing testing-sc
aptly repo add testing ./*.deb
aptly repo add main ./*.deb
aptly publish repo -component=, main-sc testing-sc

#move config
mv ~/.aptly.conf /etc/aptly.conf
nano /etc/aptly.conf
	  "rootDir": "/var/aptly",
mv ~/.aptly /var/aptly


#rename, edit, etc.
aptly repo rename main main-sc
aptly repo edit -distribution="SC" main-sc
aptly repo show main-sc
aptly repo drop
aptly publish drop ...

#remove package
aptly repo remove main-sc cassandra_3.3_all
aptly publish update SC
aptly db cleanup

#nginx
apt-get install nginx
nano /etc/nginx/sites-available/aptly
	server {
	      root /var/aptly/public;
	      server_name aptly.rc.local;

	      location / {
		      autoindex on;
	      }
	}
ln -s /etc/nginx/sites-available/aptly /etc/nginx/sites-enabled/

#test
aptly serve

#add repo
wget -O - http://aptly.rc.local/rc.center.sc.gpg.key | apt-key add -
nano /etc/apt/sources.list

deb http://aptly.rc.local/ sc main testing
apt-get update

#API'
$ curl -X POST -F file=@<name>.deb http://aptly.rc.local:8080/api/files/<name>
$ curl -X POST http://aptly.rc.local:8080/api/repos/main-sc/file/<name>
$ curl -X PUT -H 'Content-Type: application/json' --data '{}' http://aptly.rc.local:8080/api/publish/:./SC
