#!/bin/bash

# Brief: This is a php-fpm start and stop program.
# System: unbuntu 14.04
# Author: Japin
# Binary: /usr/local/sbin/php-fpm & /usr/local/bin/php-fpm
# Config: /usr/local/etc/php-fpm.conf

prefix=/usr/local/var/
pidfile=run/php-fpm.pid

function show_usage()
{
	echo "usage: $0 start|stop|quit|restart|status|help"
	if [[ $1 -eq 1 ]]; then
		echo "       start   Start php-fpm server"
		echo "       stop    Quick shutdown php-fpm server"
		echo "       quit    Graceful shutdown php-fpm server"
		echo "       restart Restart php-fpm server"
		echo "       status  Show php-fpm status"
		echo "       help    Show command information"
	fi
}

function php_fpm_start()
{
	if [ -f /usr/local/bin/php-fpm ]; then
		sudo /usr/local/bin/php-fpm
		if [ $? -eq 0 ]; then
			echo "Succeed to start php-fpm"
		else
			echo "Failed to start php-fpm"
		fi
	elif [ -f /usr/local/sbin/php-fpm ]; then
		sudo /usr/local/bin/php-fpm
		if [ $? -eq 0 ]; then
			echo "Succeed to start php-fpm"
		else
			echo "Failed to start php-fpm"
		fi
	else
		echo "Can not find php-fpm"
	fi
}

function php_fpm_stop()
{
	# Whether the /usr/local/var/run/php-fpm.pid file exists
	if [ -f $prefix$pidfile ]; then
		sudo kill $1 `cat $prefix$pidfile`
		if [ $? -eq 0 ]; then
			echo "Succeed to stop php-fpm"
		else
			echo "Failed to stop php_fpm"
		fi
	else
		echo "file not exists"
	fi
}

function php_fpm_restart()
{
	# Whether the /usr/local/var/run/php-fpm.pid file exists
	if [ -f $prefix$pidfile ]; then
		sudo kill -USR `cat $prefix$pidfile`
		if [ $? -eq 0 ]; then
			echo "Succeed to restart php-fpm"
		else
			echo "Failed to restart php_fpm"
		fi
	else
		echo "file not exists"
	fi
}

function php_fpm_status()
{
	if [ -f $prefix$pidfile ]; then
		echo "php-fpm is running"
	else
		echo "php-fpm is not running"
	fi
}

if [ $# -ne 1 ] ; then
	show_usage
else
	case $1 in
	start)
		php_fpm_start
	;;
	stop)
		php_fpm_stop -INT
	;;
	quit)
		php_fpm_stop -QUIT
	;;
	restart)
		php_fpm_restart
	;;
	status)
		php_fpm_status
	;;
	help)
		show_usage 1
	;;
	*)
		show_usage
	;;
	esac
fi



