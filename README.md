**Note: This file is maintained as a public gist to simplify sharing. It can be found at https://gist.github.com/Digital-Grinnell/f0900e9af9341e67433633be3fa0895d.**

_DG-FEDORA_ is the name of a USB stick/volume that I designed long ago to be a "portable" FEDORA repository intended for use with a local _ISLE_ stack. It holds a pre-configured and populated sample of FEDORA digital objects gleaned from [Digital.Grinnell](https://digital.grinnell.edu).  Using _DG-FEDORA_ you could easily add a pre-populated repository of objects to your "demo" or "local" environment _ISLE_ project in as little as 5 minutes.

The canonical USB stick was renamed _DG-MASTER_ on 28-Oct-2020 and it now includes utility scripts for many purposes. One script, `clone-to-X.sh` has been used to create numerous copies of _DG-MASTER_ for distribution to multiple devices and colleagues.  Each copy is given a UNIQUE name to identify its owner or purpose.  For example, I have a personal copy named _DG-MARK1_.  The `DG-` prefix is REQUIRED, so do not change it!

In the remainder of this document mentions of `DG-NAME` can be assumed to mean "the DG-something stick in your possession".

## Prerequisites
To successfully use this USB stick your system will need to meet the following prerequisite requirements.

  - Your workstation must meet all the hardware requirements of ISLE.  See _ISLE_'s _./docs/install/host-hardware-requirements.md_ for details.
  - Your workstation environment must meet all the minimum software requirements of _ISLE_.  See _ISLE_'s _./docs/install/host-software-dependencies.md_ for details.
  - This workflow assumes your workstation is running OS X.  Other workstation types supported by _ISLE_ may be acceptable, but this USB volume will have to be mounted differently.
  - You must have a working "demo" or "local" _ISLE_ stack already running, or use the steps documented in [Compact Build of dg.localdomain - Concise Instructions](https://static.grinnell.edu/blogs/McFateM/posts/094-compact-build-of-dg.localdomain/) to start a https://dg.localdomain stack of your own.

## Mounting DG-NAME
In Mac OS X you simply have to plug the _DG-NAME_ USB stick into an available USB port on your Mac workstation.  After a few seconds the USB stick will be automatically mounted as _/Volumes/DG-NAME_, and the _/Volumes_ directory is automatically "shared" with _Docker_.

### Make DG-NAME Writable
In Mac OS X, open a terminal and use the following command to make _DG-NAME_ writable, so that you can save newly ingested objects and updates to existing objects:

  - `sudo mount -u -w /Volumes/DG-NAME`

## Keeping DG-NAME Updated
I also keep a _MASTER_ copy, as the name implies, on the Grinnell College STORAGE server at [smb://Storage/LIBRARY/mcfatem](smb://Storage/LIBRARY/mcfatem).  Before using your `DG-NAME` stick you may wish to connect to `//Storage/LIBRARY/mcfatem` and update as described below.

### Connecting to //Storage/LIBRARY/mcfatem
You should be able connect your Mac workstation to `//Storage/LIBRARY/mcfatem` by first initiating a VPN connection to campus, if needed.  Once VPN has been established, open _Finder_ and select `Go` then `Connect to server...` from its menu.  In the selection window, pick or enter 'smb://Storage/Library/mcfatem', click `Connect`, and supply your campus login credentials, if necessary.

If your connection is successful you should be able to open a terminal on your workstation and successfully `cd /Volumes/mcfatem/DG-MASTER`, where you can then list the contents of the network drive using `ls -alh`.  At a minimum the contents should include:

```
╭─markmcfate@MAD25W812UJ1G9 /Volumes/mcfatem/DG-MASTER ‹ruby-2.3.0›
╰─$ ls -alh
total 408
drwx------  1 markmcfate  staff    16K Oct 21 14:51 .
drwx------  1 markmcfate  staff    16K Oct 21 12:44 ..
-rwx------  1 markmcfate  staff    10K Oct 21 13:50 .DS_Store
drwx------  1 markmcfate  staff    16K Oct 20 10:45 .Spotlight-V100
drwx------  1 markmcfate  staff    16K Oct 20 10:45 .TemporaryItems
drwx------  1 markmcfate  staff    16K Oct 20 10:50 .Trashes
drwx------  1 markmcfate  staff    16K Oct 20 10:51 .fseventsd
-rwx------  1 markmcfate  staff    90B Oct 21 14:51 DG-FEDORA-Master.md
drwx------  1 markmcfate  staff    16K Oct 20 17:23 Extras
-rwx------  1 markmcfate  staff   5.8K Oct 21 12:55 README.md
-rwx------  1 markmcfate  staff   2.3K Oct 21 10:22 RESTART-1.sh
-rwx------  1 markmcfate  staff   1.8K Oct 21 10:33 RESTART-2.sh
-rwx------  1 markmcfate  staff   1.3K Oct 21 11:26 RESTART-3.sh
-rwx------  1 markmcfate  staff   516B Oct 21 11:20 RESTART-4.sh
drwx------  1 markmcfate  staff    16K Oct  5  2019 Storage
drwx------  1 markmcfate  staff    16K Mar 18  2020 datastreamStore
drwx------  1 markmcfate  staff    16K Mar 17  2020 objectStore
-rwx------  1 markmcfate  staff   1.0K Oct 20 20:17 reset-keychain-access.md
```

### Updating DG-NAME from DG-MASTER
A script is now provided to "pull" updates from the _master_ repository at `//Storage/LIBRARY/mcfatem/DG-MASTER` to your mounted USB stick using `rsync`. If your `DG-NAME` stick is properly mounted you should download https://gist.github.com/Digital-Grinnell/69c3cca524071098bbf5c865ec632164 and save the file to `/Volumes/DG-NAME/pull-from-master.sh`.  After fetching and saving the script, make it executable using `chmod +x /Volumes/DG-NAME/pull-from-master.sh`.

Now, with the new script in place you can update your USB stick like so:

```bash
cd /Volumes/DG-NAME
./pull-from-master.sh
```
Be patient and enjoy the show! The time it will take depends on many factors, **so it's a good idea to plan ahead and run this command overnight, if possible.**

## Building https://dg.localdomain Using DG-FEDORA
See [Compact Build of dg.localdomain - Concise Instructions](https://static.grinnell.edu/blogs/McFateM/posts/094-compact-build-of-dg.localdomain/) for complete details.

## Not Using Mac OS X?  
If your workstation is not a Mac, you will need to insert the USB stick and take appropriate steps to:

  - Mount the stick with read/write permissions as _/Volumes/DG-NAME_.
  - Share the _/Volumes_ or _/Volumes/DG-NAME_ directory in your _Docker_ settings/preferences.

<!--
## Modifying the _ISLE_ Environment
Navigate to your _ISLE_ project directory and execute the following operations:

  - Shut down _ISLE_ if it is running.  Example: `cd ~/pathto/ISLE; docker-compose down`.  These commands will do no harm if _ISLE_ is not currently running.
  - Copy two files from _DG-FEDORA_ to your local project.  Example: `cd /Volumes/DG-FEDORA; cp -f .env docker-compose.DG-FEDORA.yml ~/pathto/ISLE/.`
  - Edit the new _ISLE_ project _.env_ file according to directions within the file.  Example: `nano ~/pathto/ISLE/.env`.  The objective is to select the appropriate "demo" or "local" environment as needed.
  - Navigate to your project directory and restart the stack.  Example: `cd ~/pathto/ISLE; docker-compose up -d`.
  - Wait until the stack has started, open your browser and visit your site at https://isle.localdomain (demo) or https://yourprojectnamehere.localdomain (local).

### Rebuild _FEDORA_'s _resourceIndex_
Rebuild your _FEDORA_ _resourceIndex_ using the steps documented in [Step 17: On Remote Production - Re-Index Fedora & Solr](https://github.com/Born-Digital-US/ISLE/blob/ISLE-v.1.3.0-dev/docs/install/install-production-migrate.md#step-17-on-remote-production---re-index-fedora--solr).

  - Open a terminal in the _isle-fedora-ld_ container, `docker exec -it isle-fedora-ld bash`, and then run `cd utility-scripts/; ./rebuildFedora.sh`.

### Rebuild the _Solr_ Index
Once the previous rebuild process is complete, you should rebuild your _Solr_ search index using the remaining steps documented in [Step 17: On Remote Production - Re-Index Fedora & Solr](https://github.com/Born-Digital-US/ISLE/blob/ISLE-v.1.3.0-dev/docs/install/install-production-migrate.md#step-17-on-remote-production---re-index-fedora--solr).

  - Open a terminal in the _isle-fedora-ld_ container, `docker exec -it isle-fedora-ld bash` (or using the terminal opened in the previous step), and then run `cd utility-scripts/; ./updateSolrIndex.sh`.

This rebuilding process may take a few minutes.  Proceed to the check your work after some minutes have passed.

### Check Your Work
  - Visit the repository home page at https://isle.localdomain/islandora/object/islandora:root (demo) or https://dg.localdomain/islandora/object/islandora:root (local).  You should see new collections on the first page of your display.  
  - Follow the install documentation for enabling the _Islandora Simple Search_ block and test _Solr_ by searching for a term like "Ley".
-->
