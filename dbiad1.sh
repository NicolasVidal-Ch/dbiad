# Installer prérequis
apt install -y krb5-user realmd adcli sssd sssd-tools samba-common samba-libs resolvconf samba-common-bin ntp packagekit samba winbind wget git

# Nommer le poste
read -p "Quel est le nom du poste ?" varr
nom=dopt380$varr


# Edition fichier hostname
> /etc/hostname
echo $nom.bt8it.afpa  >> /etc/hostname
echo $nom            >> /etc/hostname
echo bt8it.afpa          >> /etc/hostname


# Edition fichier hosts

echo 127.0.0.1 localhost >    /etc/hosts
echo 127.0.1.1 $nom.bt8it.afpa >>   /etc/hosts
echo # The following lines are desirable for IPv6 capable hosts >>   /etc/hosts
echo ::1     >>   /etc/hosts
echo ff02::1 >>   /etc/hosts
echo ff02::2 >>   /etc/hosts


# Edition du fichier krb5.conf

echo [libdefaults] >    /etc/krb5.conf
echo default_realm = BT8IT.AFPA  >>   /etc/krb5.conf

echo # The following krb5.conf variables are only for MIT Kerberos. >>   /etc/krb5.conf
echo        kdc_timesync = 1                                        >>   /etc/krb5.conf
echo        ccache_type = 4                                         >>   /etc/krb5.conf
echo        forwardable = true                                      >>   /etc/krb5.conf
echo        proxiable = true                                        >>   /etc/krb5.conf

echo    # The following encryption type specification will be used by MIT Kerberos     >>   /etc/krb5.conf
echo    # if uncommented.  In general, the defaults in the MIT Kerberos code are       >>   /etc/krb5.conf
echo    # correct and overriding these specifications only serves to disable new       >>   /etc/krb5.conf
echo    # encryption types as they are added, creating interoperability problems."\n"  >>   /etc/krb5.conf

echo    # The only time when you might need to uncomment these lines and change                                  >>   /etc/krb5.conf
echo    # the enctypes is if you have local software that will break on ticket                                   >>   /etc/krb5.conf
echo    # caches containing ticket encryption types it doesn't know about (such asold versions of Sun Java)."\n" >>   /etc/krb5.conf
                                           

echo    #  default_tgs_enctypes = des3-hmac-sha1   >>   /etc/krb5.conf
echo    #  default_tkt_enctypes = des3-hmac-sha1   >>   /etc/krb5.conf
echo    #  permitted_enctypes = des3-hmac-sha1"\n" >>   /etc/krb5.conf

echo    # The following libdefaults parameters are only for Heimdal Kerberos. >>   /etc/krb5.conf
echo           fcc-mit-ticketflags = true                                  >>   /etc/krb5.conf

echo    [realms]                                                           >>   /etc/krb5.conf
echo        BT8IT.AFPA = {                                                 >>   /etc/krb5.conf
echo        admin_server = rpidc0.bt8it.afpa                               >>   /etc/krb5.conf
echo        kdc = rpidc0.bt8it.afpa                                        >>   /etc/krb5.conf
echo        }                                                              >>   /etc/krb5.conf     

echo [domain_realm]                                                        >>   /etc/krb5.conf
echo        .rpidc0.bt8it.afpa = RPIDC0.BT8IT.AFPA                         >>   /etc/krb5.conf

echo [logging]                                                             >>   /etc/krb5.conf
echo        default = SYSLOG                                               >>   /etc/krb5.conf


# Edition du fichier ntp.conf

echo    # /etc/ntp.conf, configuration for ntpd; see ntp.conf(5) for help"\n" >   /etc/ntp.conf

echo    driftfile /var/lib/ntp/ntp.drift >>   /etc/ntp.conf

echo   # Leap seconds definition provided by tzdata     >>   /etc/ntp.conf
echo    leapfile /usr/share/zoneinfo/leap-seconds.list  >>   /etc/ntp.conf

echo    # Enable this if you want statistics to be logged. >>   /etc/ntp.conf
echo    # statsdir /var/log/ntpstats/"\n" >>   /etc/ntp.conf

echo statistics loopstats peerstats clockstats >>   /etc/ntp.conf
echo filegen loopstats file loopstats type day enable >>   /etc/ntp.conf
echo filegen peerstats file peerstats type day enable >>   /etc/ntp.conf
echo filegen clockstats file clockstats type day enable"\n" >>   /etc/ntp.conf 

echo    # You do need to talk to an NTP server or two (or three). >>   /etc/ntp.conf
echo    # server ntp.your-provider.example"\n" >>   /etc/ntp.conf

echo    # pool.ntp.org maps to about 1000 low-stratum NTP servers.  Your server will >>   /etc/ntp.conf
echo    # pick a different set every time it starts up.  Please consider joining the >>   /etc/ntp.conf
echo    server 10.2.0.1                                                              >>   /etc/ntp.conf

echo    # Note that "restrict" applies to both servers and clients, so a configuration >>   /etc/ntp.conf
echo    # that might be intended to block requests from certain clients could also end >>   /etc/ntp.conf
echo    # up blocking replies from your own upstream servers."\n"                      >>   /etc/ntp.conf 

echo  # By default, exchange time with everybody, but don't allow configuration. >>   /etc/ntp.conf
echo    restrict -4 default kod notrap nomodify nopeer noquery limited           >>   /etc/ntp.conf
echo    restrict -6 default kod notrap nomodify nopeer noquery limited           >>   /etc/ntp.conf

echo  # Local users may interrogate the ntp server more closely. >>   /etc/ntp.conf
echo    restrict 127.0.0.1                                       >>   /etc/ntp.conf
echo    restrict ::1                                             >>   /etc/ntp.conf
 
echo    # Needed for adding pool entries             >>   /etc/ntp.conf
echo    restrict source notrap nomodify noquery      >>   /etc/ntp.conf

echo    # Clients from this (example!) subnet have unlimited access, but only if >>   /etc/ntp.conf
echo    # cryptographically authenticated.                                       >>   /etc/ntp.conf
echo    #restrict 192.168.123.0 mask 255.255.255.0 notrust"\n"                   >>   /etc/ntp.conf


echo    # If you want to provide time to your local subnet, change the next line. >>   /etc/ntp.conf
echo    # (Again, the address is an example only.)                                >>   /etc/ntp.conf
echo    #broadcast 192.168.123.255"\n"                                            >>   /etc/ntp.conf
  
echo # If you want to listen to time broadcasts on your local subnet, de-comment the >>   /etc/ntp.conf
echo # next lines.  Please do this only if you trust everybody on the network!       >>   /etc/ntp.conf
echo #disable auth                                                                   >>   /etc/ntp.conf
echo #broadcastclient >>   /etc/ntp.conf                                          >>   /etc/ntp.conf

systemctl restart ntp.service
