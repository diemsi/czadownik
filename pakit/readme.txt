Pakker 0.1 - 28021999
----------

Pakker is a set of classes that I created to be able to lump a set of files together in on file, and then later use them in an application.  I did this because I am developing an application in which the user creates a "picture" with a set of descriptions attached.  Rather than having these stored as separate files, I wanted to be able to put them in one file and then access them in that file.

This is not a visual compnent, rather it is a set of classes that you access by includin PAK in your uses clause of the unit you want to call it from.  Generally you then call create to create a new PAK object (which creates its own THeader and TDirectory objects) passing it a filename.  If the filename exists, the TPak objects reads it and uses that PAK, if it doesnt exist, the file is created and a new PaAK is started.  The calling procedures etc are all fairly straight forward and a demo application which uses a PAK file that emmulates a UNIX directory structure is included.  Use that to figure out how to use the TPak class.

Please send bug reports / comments / improvements etc to sean@radiocbs.com , I will use these to further improve the classes.

This source is freeware, use and abuse as you will.  If you wish to make me happy send a donation to the Nelson Mandela Childrens fund.  I however to retain full copyright.

