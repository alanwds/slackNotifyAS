# slackNotifyAS
A simple service that make an slack notification when a EC2 instance scale down or scale up.

The message can be easily changed edint the script and adding the custom mensage. 

The default for scalling DOWN is:

####time - :arrow_down::arrow_down: - Scaling DOWN - hostname.with.fqdn (ip)

For scalling UP:

####time - :arrow_up::arrow_up: - Scaling UP - hostname.with.fqdn (ip)

###Install

- Put the script at /etc/init.d/ path (the path depends of the flavior)
- Set the permissions

`chmod 755 /etc/init.d/slacknotify.sh`

- Use chkconfig for set the service to correct run-levels.

`chkconfig --add slacknotify`

If you have any doubts, please, let me know
