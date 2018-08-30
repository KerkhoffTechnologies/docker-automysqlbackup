# docker-automysqlbackup

Alpine-based Docker that includes OpenSSH and automysqlbackup script.

The `automysqlbackup` script was taken from 
[Debian](https://packages.debian.org/stretch/automysqlbackup) and not its home at [SourceForge](https://sourceforge.net/projects/autopgsqlbackup/)
because the Deb version has sensible improvements, such as commenting out some example configurations, and loading settings from `/etc/default/automysqlbackup`.

Key environment variables:

* `DBHOST`: hostname of MySQL server
* `USERNAME`: MySQL username
* `PASSWORD`: MySQL password
* `DBNAMES`: space-separated list of DBs to back up (omit to back up everything)

See `backup-mysql` and configure-automysqlbackup for a more complete list of variables.

These files should be mounted from somewhere persistent:

* `/root/.ssh/authorized_keys`
* `/etc/ssh/ssh_host_dsa_key`
* `/etc/ssh/ssh_host_dsa_key.pub`
* `/etc/ssh/ssh_host_ecdsa_key`
* `/etc/ssh/ssh_host_ecdsa_key.pub`
* `/etc/ssh/ssh_host_ed25519_key`
* `/etc/ssh/ssh_host_ed25519_key.pub`
* `/etc/ssh/ssh_host_rsa_key`
* `/etc/ssh/ssh_host_rsa_key.pub`


#### Usage:

ssh into the container and run `backup-mysql`.  Backup files will be placed in /backups or as defined by _${BACKUPDIR}_.
