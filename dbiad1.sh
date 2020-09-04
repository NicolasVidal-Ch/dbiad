# Installer prérequis
apt install -y krb5-user realmd adcli sssd sssd-tools samba-common samba-libs resolvconf samba-common-bin ntp packagekit samba winbind wget git

# Nommer le poste
read -p Quel est le nom du poste ? varr
echo nom=dopt380$varr


# Edition fichier hostname

echo $nom.bt8it.afpa  > nano /etc/hostname
echo $nom            >> nano /etc/hostname
echo bt8it.afpa          >> nano /etc/hostname


# Edition fichier hosts

echo 127.0.0.1 localhost >  nano /etc/hosts
echo 127.0.1.1 $nom >> nano /etc/hosts
echo # The following lines are desirable for IPv6 capable hosts >> nano /etc/hosts
echo ::1     >> nano /etc/hosts
echo ff02::1 >> nano /etc/hosts
echo ff02::2 >> nano /etc/hosts


# Edition du fichier krb5.conf

echo [libdefaults] >  nano /etc/krb5.conf
echo default_realm = BT8IT.AFPA  >> nano /etc/krb5.conf

echo # The following krb5.conf variables are only for MIT Kerberos. >> nano /etc/krb5.conf
echo        kdc_timesync = 1                                        >> nano /etc/krb5.conf
echo        ccache_type = 4                                         >> nano /etc/krb5.conf
echo        forwardable = true                                      >> nano /etc/krb5.conf
echo -e     proxiable = true"\n"                                    >> nano /etc/krb5.conf

echo    # The following encryption type specification will be used by MIT Kerberos     >> nano /etc/krb5.conf
echo    # if uncommented.  In general, the defaults in the MIT Kerberos code are       >> nano /etc/krb5.conf
echo    # correct and overriding these specifications only serves to disable new       >> nano /etc/krb5.conf
echo -e # encryption types as they are added, creating interoperability problems."\n"  >> nano /etc/krb5.conf

echo    # The only time when you might need to uncomment these lines and change                                  >> nano /etc/krb5.conf
echo    # the enctypes is if you have local software that will break on ticket                                   >> nano /etc/krb5.conf
echo -e # caches containing ticket encryption types it doesn't know about (such asold versions of Sun Java)."\n" >> nano /etc/krb5.conf
                                           

echo    #  default_tgs_enctypes = des3-hmac-sha1   >> nano /etc/krb5.conf
echo    #  default_tkt_enctypes = des3-hmac-sha1   >> nano /etc/krb5.conf
echo -e #  permitted_enctypes = des3-hmac-sha1"\n" >> nano /etc/krb5.conf

echo    # The following libdefaults parameters are only for Heimdal Kerberos. >> nano /etc/krb5.conf
echo -e        fcc-mit-ticketflags = true"\n"                                 >> nano /etc/krb5.conf

echo    [realms]                                                           >> nano /etc/krb5.conf
echo        BT8IT.AFPA = {                                                 >> nano /etc/krb5.conf
echo        admin_server = rpidc0.bt8it.afpa                               >> nano /etc/krb5.conf
echo        kdc = rpidc0.bt8it.afpa                                        >> nano /etc/krb5.conf
echo        }"\n"                                                          >> nano /etc/krb5.conf     

echo [domain_realm]                                                        >> nano /etc/krb5.conf
echo        .rpidc0.bt8it.afpa = RPIDC0.BT8IT.AFPA"\n"                     >> nano /etc/krb5.conf

echo [logging]                                                             >> nano /etc/krb5.conf
echo        default = SYSLOG                                               >> nano /etc/krb5.conf


# Edition du fichier ntp.conf

echo -e # /etc/ntp.conf, configuration for ntpd; see ntp.conf(5) for help"\n" > nano /etc/ntp.conf

echo -e driftfile /var/lib/ntp/ntp.drift >> nano /etc/ntp.conf"\n"

echo   # Leap seconds definition provided by tzdata     >> nano /etc/ntp.conf
echo -e  leapfile /usr/share/zoneinfo/leap-seconds.list"\n" >> nano /etc/ntp.conf

echo    # Enable this if you want statistics to be logged. >> nano /etc/ntp.conf
echo -e # statsdir /var/log/ntpstats/"\n" >> nano /etc/ntp.conf

echo statistics loopstats peerstats clockstats >> nano /etc/ntp.conf
echo filegen loopstats file loopstats type day enable >> nano /etc/ntp.conf
echo filegen peerstats file peerstats type day enable >> nano /etc/ntp.conf
echo filegen clockstats file clockstats type day enable"\n" >> nano /etc/ntp.conf 

echo    # You do need to talk to an NTP server or two (or three). >> nano /etc/ntp.conf
echo -e # server ntp.your-provider.example"\n" >> nano /etc/ntp.conf

echo    # pool.ntp.org maps to about 1000 low-stratum NTP servers.  Your server will >> nano /etc/ntp.conf
echo    # pick a different set every time it starts up.  Please consider joining the >> nano /etc/ntp.conf
echo -e server 10.2.0.1 "\n"                                                         >> nano /etc/ntp.conf

echo    # Note that "restrict" applies to both servers and clients, so a configuration >> nano /etc/ntp.conf
echo    # that might be intended to block requests from certain clients could also end >> nano /etc/ntp.conf
echo -e # up blocking replies from your own upstream servers."\n"                      >> nano /etc/ntp.conf 

echo  # By default, exchange time with everybody, but don't allow configuration. >> nano /etc/ntp.conf
echo    restrict -4 default kod notrap nomodify nopeer noquery limited           >> nano /etc/ntp.conf
echo -e restrict -6 default kod notrap nomodify nopeer noquery limited"\n"           >> nano /etc/ntp.conf

echo  # Local users may interrogate the ntp server more closely. >> nano /etc/ntp.conf
echo    restrict 127.0.0.1                                       >> nano /etc/ntp.conf
echo -e restrict ::1"\n"                                         >> nano /etc/ntp.conf
 
echo    # Needed for adding pool entries             >> nano /etc/ntp.conf
echo -e restrict source notrap nomodify noquery"\n"  >> nano /etc/ntp.conf

echo    # Clients from this (example!) subnet have unlimited access, but only if >> nano /etc/ntp.conf
echo    # cryptographically authenticated.                                       >> nano /etc/ntp.conf
echo -e #restrict 192.168.123.0 mask 255.255.255.0 notrust"\n"                   >> nano /etc/ntp.conf


echo    # If you want to provide time to your local subnet, change the next line. >> nano /etc/ntp.conf
echo    # (Again, the address is an example only.)                                >> nano /etc/ntp.conf
echo -e #broadcast 192.168.123.255"\n"                                            >> nano /etc/ntp.conf
  
echo # If you want to listen to time broadcasts on your local subnet, de-comment the >> nano /etc/ntp.conf
echo # next lines.  Please do this only if you trust everybody on the network!       >> nano /etc/ntp.conf
echo #disable auth                                                                   >> nano /etc/ntp.conf
echo #broadcastclient >> nano /etc/ntp.conf                                          >> nano /etc/ntp.conf

systemctl restart ntp.service

reboot 
