# Quickstart for a WebSphere Liberty Collective: one member joined to one collective

## For the Impatient
You likely reached this page because you are looking for a sample command.  Within this page search for  
`>>>`  
that signals the next line is a command example.  There is a script that generates the command.  The scripts are written for ease of modification and review.  This design allows for experimentation and iterative development. 

## Introduction

The golden path to a IBM WebSphere Liberty collective is constructed by a series of commands each with a number of tokens.

This project is an end-to-end sample implementation for a WLP collective.  The code and explanations provided here are what I wanted to read when I began an WLP collective implementation.  It assumes the operating system is in place and nothing else.

The work is done on with 
*  VMWare Fusion for the hypervisor on an Apple macOS machine
*  Red Hat Enterprise Linux 8 for x86_64 licensed and subscribed with a Developer Subscription 
*  [Microsoft PowerShell for RHEL](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-linux?view=powershell-7.1#red-hat-enterprise-linux-rhel)
*  IBM id with PartnerWorld privileges provided by my employer
*  [IBM Installation Manager IIM](https://www.ibm.com/support/pages/installation-manager-19)
*  [IBM Packaging Utility](https://www.ibm.com/support/pages/packaging-utility-189)
*  [IBM WebSphere Liberty Profile](https://www.ibm.com/docs/en/was-liberty)

The WLP commands run on a variety of operating systems.  RHEL is the operating system I have readily at hand.  The WLP command text can be constructed by a variety of means.  The commands can be over with 300 characters and ten options, so keying it all out every time is beyond my patience.  I have a project coming out with WLP running on Windows Server 2019.  An ideal time to begin learning PowerShell by doing.  

The more I use it, the more I find PowerShell to be readable and expressive.  It also is multiplatform; Windows, macOS and Linux.

This WLP collective administration setup example is designed to be a platform for learning and improvement.  Hopefully it reduces the time and effort to reach your objective.

Two RHEL 8.4 virtual machines provided the execution environment:
*  vmrhcll for the a single collective controller
*  vmrhmbr for the first collective member.

The virtual machines are network connected with a VMWare Fusion subnet.  The vms share the macOS internet connection.  Two lines are appended to each vm’s `/etc/hosts` file to configure the network environment:
```bash
172.16.106.6     vmrhcll.prj61801  vmrhcll  # appended 2021-10-07
172.16.106.7     vmrhmbr.prj61801  vmrhmbr  # appended 2021-10-07
```

The code is organized in a project: a unit or organization for actions and resources.  Project prj61801 refers to the United States Postal Service Zone Improvement Code for the county where I reside.  A few Bash scripts to start the configuration process; defining firewall rules and installing PowerShell.  A view of the file hierarchy:
```bash
[virtuser@vmrhcll PRJ61801]$ tree -d /home/virtuser/PRJ61801/
/home/virtuser/PRJ61801/
├── PS1
└── SH
```


# Suggested Task List
## vmrhcll collective controller

### 001  as root `chown virtuser:virtuser /opt`
```bash
[virtuser@vmrhcll ~]$ ls -ld /opt
drwxr-xr-x. 2 root root 6 Apr 23  2020 /opt
[virtuser@vmrhcll ~]$ sudo su --login root
[root@vmrhcll ~]# chown virtuser:virtuser /opt
[root@vmrhcll ~]# exit
logout
[virtuser@vmrhcll ~]$ ls -ld /opt
drwxr-xr-x. 2 virtuser virtuser 6 Apr 23  2020 /opt
```

### 002  from dev’s machine `scp -p CLL/prj61801_cll_dirs.sh virtuser@vmrhcll:/home/virtuser/.`
```bash
% scp -p CLL/prj61801_cll_dirs.sh virtuser@vmrhcll:/home/virtuser/.
prj61801_cll_dirs.sh                                           100%  567   116.6KB/s   00:00 
```

### 003  `/home/virtuser/prj61801_dirs.sh`
```bash
[virtuser@vmrhcll ~]$ /home/virtuser/prj61801_cll_dirs.sh

***  -- 2021-10-07T15:48:00+00:00 -- Creates directories for prj61801. ***
---  /home/virtuser/PRJ61801/CLL/SH
drwxrwxr-x. 2 virtuser virtuser 6 Oct  7 15:48 /home/virtuser/PRJ61801/CLL/SH

---  /home/virtuser/PRJ61801/CLL/PS1
drwxrwxr-x. 2 virtuser virtuser 6 Oct  7 15:48 /home/virtuser/PRJ61801/CLL/PS1

---  /opt/PRJ61801/SHBX
drwxrwxr-x. 2 virtuser virtuser 6 Oct  7 15:48 /opt/PRJ61801/SHBX
```

### 004  copy CLL scripts from dev’s machine to vmrhcll
```sh
% rsync --archive ./CLL virtuser@vmrhcll:/home/virtuser/PRJ61801
```

### 005 `SH/config_firewalld_cll.sh`
```sh
[virtuser@vmrhcll CLL]$ SH/config_firewalld_cll.sh

*** 2021-10-07T16:11:52+00:00 Configure firewalld for minimal number of open ports.  ***
success
success

*** 2021-10-07T16:11:53+00:00 Show firewalld settings for vmrhcll ***

---  firewall-cmd --list-services  ---
     1	cockpit
     2	dhcpv6-client
     3	ssh

---  firewall-cmd --list-ports  ---
     1	9443/tcp
    9080 -- no
    9443 -- yes
   10010 -- no
```

###  006  `SH/rpm_powershell.sh` > Install PowerShell on RHEL
See `SCRIPT_MESSAGESS/rpm_powershell.sh.txt`.

###  007 ssh key pairs for prj61801
The following is one approach.
```bash
$ ssh-keygen -b 4096 -N '' -f prj61801
% ssh-copy-id -n -i ~/.ssh/prj61801 virtuser@vmrhcll 
% ssh-copy-id -i ~/.ssh/prj61801 virtuser@vmrhcll
% scp -p -i ~/.ssh/prj61801 ~/.ssh/prj61801/  virtuser@vmrhcll:/home/virtuser/.ssh/.
% scp -p -i ~/.ssh/prj61801 ~/.ssh/prj61801.pub/  virtuser@vmrhcll:/home/virtuser/.ssh/.
```

### 007 on dev machine download IBM Installation Manager
Review IBM Support doc “[Installation Manager and Packaging Utility download documents](https://www.ibm.com/support/pages/installation-manager-and-packaging-utility-download-documents)”
Follow the steps for downloading from IBM an IIM .zip to your dev machine.

### 008 from the dev’s machine push the IIM .zip to vmrhcll
`/opt/PRJ61801/SHBX/IBM/IIM_dir` is my suggestion for the target directory.


### 009 setup IIM install `PS1/expand_iim-zip_from_stgng-hst.ps1`
```
[virtuser@vmrhcll CLL]$ PS1/expand_iim-zip_from_stgng-hst.ps1

    Directory: /opt/PRJ61801/SHBX/IBM/IIM_ZIP

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d----           10/7/2021  8:24 PM                XTRCT

*** 2021-10-07T20:24:10+00:00 --  Expands IBM Installation Manager .zip.  ***

Installation Manager (install kit)                                                                                                                         Version: 1.9.1.6                                                                                                                                           Internal Version: 1.9.1006.20210614_1906                                                                                                                   Architecture: 64-bit
No installed Installation Manager was detected.
```

### 010 install IIM `PS1/install_iim_userinstc.ps1`
```bash
[virtuser@vmrhcll CLL]$ PS1/install_iim_userinstc.ps1

*** 2021-10-07T20:39:56+00:00 --  Installs IBM Installation Manager for the current user with userinstc.  ***

>>>
/opt/PRJ61801/SHBX/IBM/IIM_ZIP/XTRCT/userinstc -acceptLicense -accessRights nonAdmin -dataLocation /home/virtuser/IIM_DL
<<<
Installed com.ibm.cic.agent_1.9.1006.20210614_1906 to the /home/virtuser/IBM/InstallationManager/eclipse directory.
Installation Manager (installed)
Version: 1.9.1.6
Internal Version: 1.9.1006.20210614_1906
Architecture: 64-bit
```

### 011 create credential files to access IBM IIM packages
```bash
[virtuser@vmrhcll CLL]$ PS1/create_iim_crdntl.ps1

    Directory: /home/virtuser/PRJ61801

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-----           10/7/2021  8:52 PM             38 iim.passphrase

*** 2021-10-07T20:52:54+00:00 --  Creates the IIM credential files.  ***

>>>
/home/virtuser/IBM/InstallationManager/eclipse/tools/imutilsc saveCredential -accessRights nonAdmin -masterPasswordFile /home/virtuser/PRJ61801/iim.passphrase -secureStorageFile /home/virtuser/PRJ61801/iim.secureStorageFile -userName REDACTED -userPassword REDACTED -url http://www.ibm.com/software/repositorymanager/com.ibm.cic.packagingUtility/repository.config -verbose
<<<
The provided URL exists.
Successfully saved the credential to the secure storage file.
Authorization Information:
REDACTED
```

### 012 Use IIM to install IBM Packaging Utility from ibm.com
This command may take a minute.
```bash
[virtuser@vmrhcll CLL]$ PS1/install_pu.ps1

*** 2021-10-07T21:24:07+00:00 --  Install IBM Packaging Utility with Installation Manager imcl.  ***

>>>
/home/virtuser/IBM/InstallationManager/eclipse/tools/imcl install com.ibm.cic.packagingUtility -repositories http://www.ibm.com/software/repositorymanager/com.ibm.cic.packagingUtility/repository.config -accessRights nonAdmin -masterPasswordFile /home/virtuser/PRJ61801/iim.passphrase -secureStorageFile /home/virtuser/PRJ61801/iim.secureStorageFile -acceptLicense
<<<
Installed com.ibm.cic.packagingUtility_1.9.1006.20210614_1945 to the /home/virtuser/IBM/PackagingUtility directory.
[virtuser@vmrhcll CLL]$
```


### 013 What IIM packages may I download with my credential?  `PS1/show_IBM_pkgs.ps1`
This command takes several minutes to complete.  A file of the available packages is created in `/home/virtuser/PRJ61801`.
```bash
[virtuser@vmrhcll CLL]$ PS1/show_IBM_pkgs.ps1

*** 2021-10-08T01:08:19+00:00 --  Creates a file of available IIM packages to then filter for packages of interest.  ***

>>>
/home/virtuser/IBM/PackagingUtility/PUCL listAvailablePackages -repositories http://www.ibm.com/software/repositorymanager/com.ibm.websphere.liberty.ND -masterPasswordFile /home/virtuser/PRJ61801/iim.passphrase -secureStorageFile /home/virtuser/PRJ61801/iim.secureStorageFile
<<<

> /home/virtuser/PRJ61801/ibm_pkgs_2021-10-08T010819.txt:50:com.ibm.java.jdk.v8_8.0.6036.20210920_0725
  /home/virtuser/PRJ61801/ibm_pkgs_2021-10-08T010819.txt:51:com.ibm.websphere.liberty.BASE_16.0.3.20160831_1733
> /home/virtuser/PRJ61801/ibm_pkgs_2021-10-08T010819.txt:438:com.ibm.websphere.liberty.ND_21.0.10.20210920_1901
  /home/virtuser/PRJ61801/ibm_pkgs_2021-10-08T010819.txt:439:com.ibm.websphere.liberty.ND.v85_8.5.16003.20160831_1733
> /home/virtuser/PRJ61801/ibm_pkgs_2021-10-08T010819.txt:222:com.ibm.websphere.liberty.CORE_21.0.10.20210920_1901
  /home/virtuser/PRJ61801/ibm_pkgs_2021-10-08T010819.txt:223:com.ibm.websphere.liberty.DEVELOPERS.v85_8.5.16003.20160831_1733
```

### 014 fetch packages of interest:  `PS1/fetch_pkgs.ps1`
This command takes ten, or so, minutes to complete.  A good time for a stretch break.  The installation binaries for IIM to accomplish are provided to the IIM repository.  The collective controller requires a WLP Network Deployment ND install.  The collective member will be WLP CORE.

For the complete set of messages see `SCRIPT_MESSAGES/PS1/fetch_pkgs.ps1.txt`.  The following is a represetavie command string.
```bash
>>>
/home/virtuser/IBM/PackagingUtility/PUCL copy com.ibm.websphere.liberty.ND_21.0.10.20210920_1901 -repositories http://www.ibm.com/software/repositorymanager/com.ibm.websphere.liberty.ND -masterPasswordFile /home/virtuser/PRJ61801/iim.passphrase -secureStorageFile /home/virtuser/PRJ61801/iim.secureStorageFile -platform os=linux,arch=x86_64 -target /opt/PRJ61801/SHBX/WLP_PKGS -acceptLicense
<<<
```

### 015 install WLP ND to provide OSGi bundle to load `collectiveController-1.0`
[The `collectiveController-1.0` feature and its capabilities are available only in WebSphere® Application Server Network Deployment Liberty and WebSphere Application Server for z/OS® Liberty.](https://www.ibm.com/docs/en/was-liberty/core?topic=collectives-configuring-liberty-collective)

This install script does invokes IIM `imcl` three times
*  foundation package for the IBM product
*  current release of the package
*  current IBM JDK

The command takes several minutes to complete.  For the complete set of messages see `SCRIPT_MESSAGES/PS1/install_wlp_nd.ps1.txt`.  The following is a representative command string.
```bash
>>>
/home/virtuser/IBM/InstallationManager/eclipse/tools/imcl install com.ibm.websphere.liberty.ND_21.0.10.20210920_1901 -repositories /opt/PRJ61801/SHBX/WLP_PKGS -installationDirectory /opt/PRJ61801/WLPND -acceptLicense
<<<
``` 

### 016 `report_WLPND_config.ps1`
Review the descriptions of the installed binaries provided by WLP.  For the complete set of messages see `SCRIPT_MESSAGES/PS1/report_WLPND_config.ps1.txt`.
Results are shown for the following commands
*  `/opt/PRJ61801/WLPND/bin/productInfo version --verbose`
*  `/opt/PRJ61801/WLPND/java/8.0/bin/java -version`
*  `Get-Content -Path /opt/PRJ61801/WLPND/java/java.env`

### 017 create WLP key file to encrypt passwords in server.xml
```bash
[virtuser@vmrhcll CLL]$ PS1/create_wlp_key_file.ps1

*** 2021-10-08T10:40:18+00:00 --  Creates the file /home/virtuser/PRJ61801/wlp_key.xml containing a key for WLP encyrption.  ***

>>>
chmod 600 /home/virtuser/PRJ61801/wlp_key.xml
<<<
```

### 018 encrypt the password visible in the server.xml file
```bash
[virtuser@vmrhcll CLL]$ PS1/encode_wlp_admin_pw.ps1

*** 2021-10-08T13:34:55+00:00 --  Encodes a password for server.xml to provide the WLP Admin password.  ***

>>>
/opt/PRJ61801/WLPND/bin/securityUtility  encode --encoding=aes --key=prj61801
<<<
Enter text:
Re-enter text:
{aes}AJdsYJ8VoZ3T1IHwKWce0Rp4hZkkiZRSSpttS9xAv7Ja
```

### 019 `PS1/create_srvCLL01.ps1`
```bash
[virtuser@vmrhcll CLL]$ PS1/create_srvCLL01.ps1

*** 2021-10-08T14:38:24+00:00 --  Runs WLP ND "create server srvCLL01" to provide a collective controller pre-req.  ***

>>>
/opt/PRJ61801/WLPND/bin/server create srvCLL01
<<<

Server srvCLL01 created.

    Directory: /opt/PRJ61801/WLPND/usr/servers/srvCLL01

Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-----           10/8/2021  2:38 PM             37 bootstrap.properties
>>>
cp -p /opt/PRJ61801/WLPND/usr/servers/srvCLL01/server.xml /opt/PRJ61801/WLPND/usr/servers/srvCLL01/server.xml.000
<<<
>>>
cp -p /opt/PRJ61801/WLPND/usr/servers/srvCLL01/server.xml /opt/PRJ61801/WLPND/usr/servers/srvCLL01/server.xml.001
<<<
```

### 020 `PS1/create_cll_ctrlr.ps1`
```bash
[virtuser@vmrhcll CLL]$ PS1/create_cll_ctrlr.ps1

*** 2021-10-08T14:45:02+00:00 --  Runs WLP ND "collective create srvCLL01" to provide a collective controller.  ***

>>>
/opt/PRJ61801/WLPND/bin/collective create srvCLL01 --keystorePassword=kspw --collectiveName=cntrllr01 --createConfigFile=/opt/PRJ61801/WLPND/usr/servers/srvCLL01/cntrllr01.xml
<<<
Creating required certificates to establish a collective...
This may take a while.
Successfully generated the controller root certificate.
Successfully generated the member root certificate.
Successfully generated the server identity certificate.
Successfully generated the HTTPS certificate.

Successfully set up collective controller configuration for srvCLL01.

Add the following lines to the server.xml to enable:

    <include location="${server.config.dir}/cntrllr01.xml" />

Please ensure administrative security is configured for the server.
An administrative user is required to join members to the collective.
```


### 021 communicate the desired configuraiton to WLP with the `server.xml` file
WLP’a configuration, with the exception of bootstrap.properties, is in `server.xml`.  The file `CLL/protype_server.xml` provides an example.  Please modify this file for your needs.
*  use the encrypted password for the WLP administrator-role user Alice
*  review `/opt/PRJ61801/WLPND/usr/servers/srvCLL01/cntrllr01.xml`.  This content is part of `CLL/protype_server.xml`.

From the admin’s machine push the `CLL/protype_server.xml` renamed to `server.xml` to vmrhcll `/opt/PRJ61801/WLPND/usr/servers/srvCLL01`.

```bash
% scp -p CLL/protoype_server.xml virtuser@vmrhcll:/opt/PRJ61801/WLPND/usr/servers/srvCLL01/server.xml
protoype_server.xml                                                  100% 2884     1.1MB/s   00:00 
```


### 022 `CLL/PS1/start_srvCLL01.ps1`
Please see `CLL/SCRIPT_MESSAGES/PS1/start_srvCLL01.ps1.txt`.

From the WLP admin’s machine:

```bash
% grep CWWKX9003I  CLL/SCRIPT_MESSAGES/PS1/start_srvCLL01.ps1.txt
[2021-10-08T16:50:44.327+0000] 0000002e llective.repository.internal.CollectiveRegistrationMBeanImpl 
I CWWKX9003I: CollectiveRegistration MBean is available.
```

```bash
% sed -n '79 p' CLL/SCRIPT_MESSAGES/PS1/start_srvCLL01.ps1.txt 
[2021-10-08T16:50:41.212+0000] 00000031 com.ibm.ws.http.internal.VirtualHostImpl                     
A CWWKT0016I: Web application available (default_host): https://vmrhcll.prj61801:9443/adminCenter/
```

### 023 review WLP’s Admin Center 
[https://vmrhcll.prj61801:9443/adminCenter/#serverConfig/vmrhcll.prj61801,/opt/PRJ61801/WLPND/usr,srvCLL01](https://vmrhcll.prj61801:9443/adminCenter/#serverConfig/vmrhcll.prj61801,/opt/PRJ61801/WLPND/usr,srvCLL01)
![Enjoy the results of your work](CLL/img/cll_admincetner.001jpg.jpg)

