# wake_on_cloud
My wake on cloud script

Script : réveil d'ordinateur contrôlé par le cloud (Dropbox…) 

Script : cloud controled computer wake up (Dropbox…) 

Je suis un grand voyageur et j'ai appris de mes erreurs de toujours avoir une copie de ses photos. J'ai donc installé un vieux PC pour un accès à distance quand j'en ai besoin, c'est le serveur. Pour des raisons écologiques et économique je souhaite mettre le serveur en veille quand on ne l'utilise pas. Malheureusement le Wake On Lan, technologie qui permet de réveiller un PC distant nécessite une carte ethernet compatible (sûrement pas le cas en wifi) et il faut configurer le routeur ce qui n'est pas toujours possible. 

I'm a big traveler and I learned from my mistakes to always have a copy of my pictures. I therefore installed an old computer for remote access when I need it, let's call it a server. For ecological and economical reasons I want to put the server into sleep when I don't use it. Unfortunately the Wake On Lan, technology that allows to wake up a remote computer requires a compatible ethernet card (unlikely compatible with wifi) and the router needs to be configured wich is not always possible. 
Une alternative au Wake On Lan :
Réveil d'ordinateur contrôlé par le cloud ! 
Pas de configuration du routeur. 
Fonctionne en wifi. 

An alternative to the Wake On Lan:
cloud controled computer wake up! 
No router configuration. 
Works with wifi. 

Le principe :
Un fichier texte contrôle l'allumage et mise en veille du serveur. 
Un autre fichier indique l’état du serveur pour information seulement. 

The principles:
A text file controls the wake up and sleep of the server. 
Another text file indicates the server state for information only. 

La mécanique :
Le serveur se réveille périodiquement et se connecte à internet, 
Le cloud (Dropbox) met à jour le fichier de commande, 
un script va scanner le fichier de commande et soit retourner à la veille, soit garder le serveur en ligne. Le fichier d’état est mis à jour pour information. 

How it works :
The server periodically wakes up and connects to Internet, 
The cloud (Dropbox) updates the command file, 
A script will scan the command file and either bring the server back to sleep, or keep the server online.  The feedback file is updated accordingly for information. 

Ce qu'il faut :
Ajouter une tâche planifiée, qui exécute le script périodiquement, en réveillant le serveur de sa veille. La période dépend du temps maximum que l'on accepte d'attendre avant le réveil du serveur, pour ma part 4h.

Requirements :
Add a scheduled task, wich will periodically execute the script, waking up the server from sleep. The period depends on the maximum time we would consider fair to wait before the server is online, for my use 4h is great. 

