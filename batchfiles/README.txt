Version 3.0.

The generic.bat file accepts three parameters: 
- the path to the source content as seen from the perspective of the Docbook2DITA folder. No trailing slash allowed!
- the name of the file to be processed in the source folder.
- the desired name of the output ditamap.

for example:

C:\batchfiles>generic.bat \Source\OTN-smartfusion otn-encryption.xml Microsemi_OTN_Encryption_with_DIGI-G4_SmartFusion.ditamap

You can also simply hardcode the values into a copy of the batch file as in the OTNEncryption.bat sample file.

You can test your config by double-clicking the OTNEncryption.bat file. A converted project should appear 
in the /out/ folder. 
