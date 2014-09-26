Netflix USA proxy with Google Compute Engine
============================================

This bash script allows you to automatically create a GCloud instance in the USA and use it as a SOCKS proxy to get access to the US Netflix's catalog. 

The script works in three steps :

* Instance creation
* Connection
* Instance deletion


##Requires

* [GCloud SDK](https://cloud.google.com/sdk/) and an account.
* A client proxy (I use [Tunnel Switch](https://github.com/oylbin/tunnel-switch) Chrome extension)


##Use

Simply run the bash script and wait for the VM's prompt. Then go to Netflix's website using a SOCKS 5 proxy configured on **127.0.0.1:1080** and enjoy your movie. Once you want to shut down the server, exit the prompt (`exit`/`logout`/`ctrl+d`) and answer "yes" to delete the instance.


##Cost

It depends on the type of VM you choose but for the **n1-standard-1** (by default), count 0,07$ per hour.


##Not happy ?

Feel free to fork, I'll be happy to get the script improved :smile: