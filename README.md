# Challenge-git
challenge git avec utilisation de `$ git rebase -i`

Avant tout, recréer l'historique en utilisant le script bash.

## Travail demandé
1. Corriger les typos du message du commit 03. Le message doit être redressé comme suit: 03- Started Hello World Feature

2. Permuter l'ordre des commits 02 et 03 de manière à ce que le commit Started Hello ... apparaisse avant Finished Hello... dans l'historique. On doit faire ici une permutation des transactions de commit et non pas juste la permutation des messages.
En effet, l'effet de l'actuelle transaction 2762d2bd doit apparaitre avant l'effet de la transaction 87da3d43 et portera le message 02- Started Hello World Feature. La transaction 87da3d43 portera alors le message 03- Finished Hello World Feature.

3. Changer l'auteur du commit 05 pour qui'il soit Me, the Challenger. On veut cacher que Pompier était à notre secours !  
 
4. Ecraser l'actuel commit numéro 06. On ne veut pas divulguer cette opération critique dans l'historique par peur que certains curieux viendront y chercher des données sensibles. 

5. Fusionner les 3 commits 07, 08, et 09 en un seul commit portant le message Add doc.

6. Faire en sorte que le commit 11 soit une continuité du commit 10 et qu'il en conserve le message.

### Commençons par l'espace de travail

- Se placer dans un dossier contenant le script bash, ouvrir un terminal au même endroit et lancer `$ ./setup-repository.bash`
un répertoire "repo-challenge" se crée. 
- Via le terminal, se déplacer dans ce dossier: `$ cd repo-challenge`

-----
#### 1. Corriger les typos du message du commit  03- Started Hello World Feature
commencer par faire un:

    $ git log --oneline
    8de5950 (HEAD -> master) 11- I forgot a semicolon
    ab1d065 10- Test for feature hello world
    16e9b63 09- Add doc - step 3
    fdde433 08- Add doc - step 2
    d288e14 07- Add doc - step 1
    d0b9c8d 06- important secret
    7455d6d 05- debugging
    0b98050 04- Really made the thingy done
    873b9c5 03- StArrtid Helo Volrd feature
    c6c92d6 02- Finished Hello World feature
    4be5fb2 01- Initial commit

suivi d'un `$ git rebase -i HEAD~9` **
** nous avons 11 commits, donc pour attraper le 3ème, je fais 11-3 = 8 + 1 = 9 

dans l'éditeur, tape "i" et remplacer pick par reword sur le commit 03:

    reword 9e05cba 03- StArrtid Helo Volrd feature
faite ESCAPE + :wq pour sauver et quitter.
Il reste dans vim, refaites la même opération: tape "i", changer le texte du message en "Started Hello World" + ESC + :wq pour sauver et quitter.

résultat de la manœuvre:

    $ git rebase -i HEAD~9
    [detached HEAD 8640415] 03- Started Hello World Feature
     Date: Thu Dec 31 10:01:45 2020 +0100
     1 file changed, 1 insertion(+)
     create mode 100644 hello.code
    Successfully rebased and updated refs/heads/master.

refaites un `$ git log --oneline` pour vérifier


-----
#### 2. Permuter l'ordre des commits 02 et 03...

Faites un    `$ git log --oneline`

    8640415 03- Started Hello World Feature
    c6c92d6 02- Finished Hello World feature
    4be5fb2 01- Initial commit

Suivi d'un `$ git rebase -i HEAD~10`
Dans vim, tape "i" et copier le commit started World **au dessus** du commit Finished World, positionnez-vous ensuite sur la ligne du 1er Started World et faire: ESC+ d + d pour le supprimer
remplacer les 2 `pick` par des `reword` directement sur les 2commits pour modifier leurs messages, changer le 02 en 03 et vice versa
ESC + :wq pour sauver et revenir a la console

résultat: 

    $ git rebase -i HEAD~10
    [detached HEAD 5d2f8d1] 022- Started Hello World Feature
     Date: Thu Dec 31 10:01:45 2020 +0100
     1 file changed, 1 insertion(+)
     create mode 100644 hello.code
    [detached HEAD fc11560] 03- Finished Hello World feature
     Date: Thu Dec 31 10:01:44 2020 +0100
     1 file changed, 1 insertion(+)
     create mode 100644 other.code
    Successfully rebased and updated refs/heads/master.

vérification avec 

    $ git log --oneline
    ...
    fd8e10f 03- Finished Hello World feature
    e300d86 02- Started Hello World Feature
    4be5fb2 01- Initial commit

-----
#### 3. Changer l'auteur du commit 05
vue de la situation toujours avec $ git log --oneline : 

    $ git log --oneline
    ...
    64fddfa 05- debugging
    dda305c 04- Really made the thingy done
    fd8e10f 03- Finished Hello World feature
    ...
État de l'auteur du commit 05:

    $ git log 64fddfa
    commit 64fddfadbef1ffdde5d1485b19adb9e14aee4067
    Author: LE Pompier <super.pompier@debugland.com>
    Date:   Thu Dec 31 10:01:45 2020 +0100
        05- debugging

On veut changer le commit 5, donc 11-5=6+1=7 

Soit : faire un `$ git rebase -i HEAD~7`
soit: sélectionner le parent de celui que l'on veut changer:

     $ git rebase -i dda305c 

Dans vim: Taper 'i' et remplacer `pick` par `edit` sur le commit 05 + ESC + :wq

Entrer ensuite un  `$ git add .`   
Suivi d'un `$ git commit –amend –author "Me, the challenger"` 

    [detached HEAD 7d437e9] 05- debugging
     Date: Thu Dec 31 10:01:45 2020 +0100
     1 file changed, 1 insertion(+), 1 deletion(-)

 
Dans vim, juste faire ESC+ :wq pour sauver et quitter.

Terminer avec un  `$ git rebase –continue`  pour valider les changements:   

     Successfully rebased and updated refs/heads/master.

Faire un git log ID pour vérifier l'auteur du commit 05:

    $ git log 64fddfa
    commit 7e03f758a8d140e2adbde8615e05c54c9a887f16
    Author: Me, the Challenger <challenger@challengeland.com>
    Date:   Thu Dec 31 10:01:45 2020 +0100
    05- debugging

tape "q" to quit

-----
#### 4. Ecraser l'actuel commit numéro 06

Ici nous allons l'écraser avec le commit 05- debugging

        $ git log --oneline
        98c2ba0 (HEAD -> master) 11- I forgot a semicolon
        3c2e91e 10- Test for feature hello world
        4012c22 09- Add doc - step 3
        fb635e7 08- Add doc - step 2
        1478fe6 07- Add doc - step 1
        07827eb 06- important secret
        7d437e9 05- debugging
        dda305c 04- Really made the thingy done
        ...

Sélectionner le parent de debugging:     `$ git rebase -i dda305c`

Dans vim: tape 'i' + Remplacet pick par "fixup" sur 06 Important secret + ESC + :wq

    $ git rebase -i dda305c
    Successfully rebased and updated refs/heads/master.

Vérifier avec: 
il ne se trouve plus dans la liste:
   

     $ git log --oneline
        5d005d3 (HEAD -> master) 11- I forgot a semicolon
        8297918 10- Test for feature hello world
        a28f865 09- Add doc - step 3
        fb9be0a 08- Add doc - step 2
        e6aad46 07- Add doc - step 1
        7e03f75 05- debugging
        dda305c 04- Really made the thingy done
        ...
    
    $ git show 7e03f75
    commit 7e03f758a8d140e2adbde8615e05c54c9a887f16
    Author: Me, the Challenger <challenger@challengeland.com>
    Date:   Thu Dec 31 10:01:45 2020 +0100
        05- debugging
        diff --git a/hello.code b/hello.code
        index 980a0d5..9bf5f0d 100644
        --- a/hello.code
        +++ b/hello.code
        @@ -1 +1 @@
        -Hello World!
        +println DEBUG
        diff --git a/private.secret b/private.secret
        new file mode 100644
        index 0000000..4e18191
        --- /dev/null
        +++ b/private.secret
        @@ -0,0 +1 @@
        +4321pass
-----
#### 5. Fusionner les commits 07, 08, et 09 en un seul portant le message Add doc

    $ git log --oneline
    5d005d3 (HEAD -> master) 11- I forgot a semicolon
    8297918 10- Test for feature hello world
    a28f865 09- Add doc - step 3
    fb9be0a 08- Add doc - step 2
    e6aad46 07- Add doc - step 1
    7e03f75 05- debugging
    dda305c 04- Really made the thingy done
    fd8e10f 03- Finished Hello World feature
    e300d86 02- Started Hello World Feature
    4be5fb2 01- Initial commit

11 – 7 = 4 + 1 = 5 donc:  `$ git rebase -i HEAD~5`

dans vim: taper "i", et remplacer `pick` par `squash` sur les 2derniers commits:

    pick e6aad46 07- Add doc - step 1
    squash fb9be0a 08- Add doc - step 2
    squash a28f865 09- Add doc - step 3

esc + :wq
Il nous montre la fusion dans vim: 

    # This is a combination of 3 commits.
    7->9 Add doc
    
    # This is the 1st commit message:
    #07- Add doc - step 1
    
    # This is the commit message #2:
    #08- Add doc - step 2
    
    # This is the commit message #3:
    #09- Add doc - step 3

J'ai mis en commentaire tous les autres messages et ajouter au dessus: 
7->9 Add doc pour valider les changements et le nouveau message Add doc

résultat des commandes réussies: 

    $ git rebase -i HEAD~5
    [detached HEAD 204725f] 7->9- Add doc
     Date: Thu Dec 31 10:01:46 2020 +0100
     1 file changed, 3 insertions(+)
     create mode 100644 README.md
    Successfully rebased and updated refs/heads/master.
    
    $ git log --oneline
    23cbe64 (HEAD -> master) 11- I forgot a semicolon
    42b221d 10- Test for feature hello world
    204725f 7->9- Add doc
    7e03f75 05- debugging
    dda305c 04- Really made the thingy done
    fd8e10f 03- Finished Hello World feature
    e300d86 02- Started Hello World Feature
    4be5fb2 01- Initial commit
    
    $ git show 204725f
    commit 204725ffaa9fa760c873bc8bac0a440b3052fc27
    Author: Me, the Challenger <challenger@challengeland.com>
    Date:   Thu Dec 31 10:01:46 2020 +0100
        7->9- Add doc
    
    diff --git a/README.md b/README.md
    new file mode 100644
    index 0000000..288ab4f
    --- /dev/null
    +++ b/README.md
    @@ -0,0 +1,3 @@
    +# THE Ultimate Hello World program
    +
    +This program does exactly what it says


-----
#### 6.  Faire en sorte que le commit 11 soit une continuité du commit 10 et qu'il en conserve le message.

    $ git log --oneline
    23cbe64 (HEAD -> master) 11- I forgot a semicolon
    42b221d 10- Test for feature hello world
    204725f 7->9- Add doc
    7e03f75 05- debugging
    dda305c 04- Really made the thingy done
    fd8e10f 03- Finished Hello World feature
    e300d86 02- Started Hello World Feature
    4be5fb2 01- Initial commit


    $ git rebase -i HEAD~3

dans vim: Taper "i" + changer `pick` en `merge` sur le dernier commit

    pick 204725f 7->9- Add doc
    pick 42b221d 10- Test for feature hello world
    merge 23cbe64 11- I forgot a semicolon
 
 dans la console:     `$ git rebase --edit-todo`

 dans vim:  Taper "i" et changer le `merge` en `pick` + ESC + :wq
 
Valider ensuite les changements avec: 

    $ git rebase --continue
    Successfully rebased and updated refs/heads/master

Vérification:

    $ git log --oneline
    23cbe64 (HEAD -> master) 11- I forgot a semicolon
    42b221d 10- Test for feature hello world
    
    $ git show 23cbe64
    commit 23cbe640cb45ce01d904a06d9dbf84ad19915d2f (HEAD -> master)
    Author: Me, the Challenger <challenger@challengeland.com>
    Date:   Thu Dec 31 10:01:47 2020 +0100
            11- I forgot a semicolon
    
    diff --git a/hello.test b/hello.test
    index d5c5954..222032e 100644
    --- a/hello.test
    +++ b/hello.test
    @@ -1 +1 @@
    -should_return_true(hello.code)
    +should_return_true(hello.code);
    
    $ git show 42b221d
    commit 42b221dc77d9e290ef6b82435fa948413581b7fd
    Author: Me, the Challenger <challenger@challengeland.com>
    Date:   Thu Dec 31 10:01:46 2020 +0100
            10- Test for feature hello world
    
    diff --git a/hello.test b/hello.test
    new file mode 100644
    index 0000000..d5c5954
    --- /dev/null
    +++ b/hello.test
    @@ -0,0 +1 @@
    +should_return_true(hello.code)
     
    
    
    

