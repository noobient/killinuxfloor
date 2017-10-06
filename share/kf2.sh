#!/bin/sh

case $1 in
    start)
        sudo /bin/systemctl start kf2.service
        ;;

    stop)
        sudo /bin/systemctl stop kf2.service
        ;;

    restart)
        sudo /bin/systemctl restart kf2.service
        ;;

    status)
        sudo /bin/systemctl status kf2.service
        ;;

    update)
        steamcmd.sh +login anonymous +force_install_dir ./KF2Server +app_update 232130 +exit
        ;;

    log)
        sudo /bin/journalctl --system --unit=kf2.service --follow
        ;;

    *)
        echo "Usage: $0 {start|stop|restart|status|update|log}"
        exit 1

esac
