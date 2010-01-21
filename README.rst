======
Readme
======

:Authors: peter.vizi@gmail.com

Description
===========

check_mail
----------

Use this script to get the number of new messages on set of IMAP
servers.

Download this python daemon_ library.

Create configuration file, default is ~/.check_mail.rc::

  [gmail]
  user = yourname@gmail.com
  passwd = ****
  mailbox = INBOX
  host = imap.gmail.com
  port = 993

Start the daemon with ``$ check_mail start``.

Use backtick_ in .screenrc::

  backtick 1 30 30 cat /tmp/check_gmail
  caption always "%{+b rk}$USER@%{wk}%H | gmail: %1` %-21=%{wk}%D %d.%m.%Y %0c"

finch_status
------------

Display the number of unseen messages in your finch_ session.

Use backtick_ in .screenrc::

  backtick 1 10 10 $HOME/bin/finch_status
  caption always "%{+b rk}$USER@%{wk}%H | im: %1` %-21=%{wk}%D %d.%m.%Y %0c"

get_cputemp1, get_cputemp2
--------------------------

Get the temperature of CPU with sensors_.

Use backtick_ in .screenrc::

  backtick 1 60 60 $HOME/bin/get_cputemp1
  backtick 2 60 60 $HOME/bin/get_cputemp2
  caption always "%{+b rk}$USER@%{wk}%H | cpu: %1` %2` %-21=%{wk}%D %d.%m.%Y %0c"

get_hddtemp
-----------

Get the temperature of the HDD with hddtemp_.

Use backtick_ in .screenrc::

  backtick 1 60 60 $HOME/bin/get_hddtemp
  caption always "%{+b rk}$USER@%{wk}%H | hdd: %1` %-21=%{wk}%D %d.%m.%Y %0c"

.. _daemon: http://www.jejik.com/articles/2007/02/a_simple_unix_linux_daemon_in_python/
.. _backtick: http://www.gnu.org/software/screen/manual/html_node/Backtick.html
.. _finch: http://developer.pidgin.im/wiki
.. _sensors: http://www.lm-sensors.org/
.. _hddtemp: https://savannah.nongnu.org/projects/hddtemp/
