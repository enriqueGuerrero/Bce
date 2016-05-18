Bce
===

Bce: Basic Chat in Erlang.

Warm up
====
You need two or more different computers.
I'm going to explain this example using two computers, their names are: pc1 and pc2.
  
Step 1: We need to know which are ours ip address in pc1 and pc2.
    
For example: 

	pc1 has got: 192.168.1.1
	pc2 has got: 192.168.1.2
  
Step 2: We need to edit ours /etc/hosts files.	  
For example in pc1:

	pc1@user#vi /etc/hosts
      
Then,  We need to type:

	192.168.1.2 pc2

Save changes.

In pc2:

	pc2@user#vi /etc/hosts

Now, We need to type:

	192.168.1.1 pc1

Step 3: To verify that  there is an connection; You need that your firewall is off.	  
In pc1 type:

	pc1@user#ping pc2

It should be successful.
	
In pc2 type:

	pc2@user#ping pc1

It should be successful, too.

Downloading and Using
====
In each computer, You need to download Bce from the git repo

	$git clone https://github.com/enriqueGuerrero/Bce

Let's into Bce directory

	$cd Bce
		
You can type three different commands.
	
	%This command compiles all .erl files located in src/ directory.
	$make compile  
	
	%This command erases all .beam files in ebin/ directory.
	$make clear 
	
	%This command starts an Erlang runtime system with the following arguments: erl -sname example -setcookie test -pa ebin/
	$make start 

But You just  type the following commands:
	
	$make compile

Now, in pc1 You need to type the following command:

	$erl -sname pc1 -setcookie test -pa ebin/

In pc2, You need to type:
	
	$erl -sname pc2 -setcookie test -pa ebin/
	
	
In this moment, your Prompt line:
	
in pc1 It'll be like: 

	(pc1@hostname)

in pc2 It'll be like: 

	(pc2@hostname)

Now, in pc1 and pc2 type: 
	
	$main:pid().

Then, in pc1 type:
	
	$node:connect(pc2@hostname).
	
After that command, pc1 will  do  replicate this message over all nodes:
	
	pc1 has been connected.

Now, If You want to send a message to all nodes, type the following command:
	
	main:public("Hello").
	
In pc1, If You want to send a private message, You need to list the connected users, type:

	node!show.

And You'll see all connected nodes. Then, selected someone (pc2) and type:
	
	node!{pc2,"Hello"}.

And only pc2 receives the message.


Author
====
Enrique Iván Guerrero Martínez <enrique.eigm@gmail.com>.

License
====
THIS SOFTWARE IS LICENSED UNDER BSD LICENSE. see LICENSE.txt for more info.
