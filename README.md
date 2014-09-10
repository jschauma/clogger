Clogger - A Chat Logger
=======================
clogger(1) implements a simple logging/messaging interface analogous to the
common logger(1) command.  However, instead of logging messages to
syslog(3), clogger(1) will write the message to Campfire or HipChat.

Who wrote this tool?
--------------------
'clogger' was originally written by Jan Schaumann (jschauma@twitter.com) in
November 2013.

What do I need to run this?
---------------------------
You want to create a configuration file containing at least the following
lines:

```
campfire_token = 1a2b3c4d5e6f71a2b3c4d5e6f71a2b3c4d5e6f71a2b3c4d5e6f7
campfire_host = yoursite.campfirenow.com
```

or, for HipChat:

```
hipchat_token = 1a2b3c4d5e6f71a2b3c4d5e6f71a2b3c4d5e6f71a2b3c4d5e6f7
hipchat_host = api.hipchat.com
```

If you are using an HTTP proxy to access the internet, you can also add
the required url and credentials in that file.

See the manual page for details.

How do I use it?
----------------
Just like logger(1):

```
echo "Good news, everybody!" | clogger -r 1234
clogger -r 1234 -r 56789 <config.xml
clogger -r 1234 $(uptime)
```
