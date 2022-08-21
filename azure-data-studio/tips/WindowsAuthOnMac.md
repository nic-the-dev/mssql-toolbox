# Using Windows Auth on a Mac with Azure Data Studio

1. Open a terminal window 
2. Type the below command with your username/doman

``` kinit <username>@<domain>.local ```

``` ex. kinit nic@NIC-THE-DEV.local ```

3. Enter password when prompted
4. Open a new connection, selecting Windows Authentication

Note: It's possible to create multiple kerberos tickets. Follow steps about and utilize below command to switch between the different accounts

``` kswitch -i ```