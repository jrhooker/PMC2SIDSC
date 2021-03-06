set PATHTOPROJECT=\Source\flash_subsystem
set OUTPUTPATH=\out
set FILENAME=flash_subsystem.ditamap

cd ..\

set WORKINGDIR=%CD%

cd %WORKINGDIR%\batchfiles

rd /s /q %WORKINGDIR%\out\

mkdir %WORKINGDIR%\out\

rd /s /q %WORKINGDIR%\in\

mkdir %WORKINGDIR%\in\

cd %WORKINGDIR%\batchfiles

java -cp %WORKINGDIR%/depend/tools/saxon9/saxon9he.jar;%WORKINGDIR%\depend\tools\Saxon9\xml-commons-resolver-1.2\resolver.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\RWS-DTD\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:%WORKINGDIR%\in\test.xml ^
-s:%WORKINGDIR%\%PATHTOPROJECT%\%FILENAME% ^
-xsl:%WORKINGDIR%\depend\custom\traverse_ditamaps.xsl ^
STARTING-DIR="%WORKINGDIR%%PATHTOPROJECT%/" OUTPUT-DIR="%WORKINGDIR%%OUTPUTPATH%/" FILENAME="%FILENAME%" 

cd %WORKINGDIR%\batchfiles

java -cp %WORKINGDIR%/depend/tools/saxon9/saxon9he.jar;%WORKINGDIR%\depend\tools\Saxon9\xml-commons-resolver-1.2\resolver.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\RWS-DTD\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:%WORKINGDIR%\in\test.xml ^
-s:%WORKINGDIR%\%PATHTOPROJECT%\Temp-%FILENAME% ^
-xsl:%WORKINGDIR%\depend\custom\generate_register_topics.xsl ^
STARTING-DIR="%WORKINGDIR%%PATHTOPROJECT%/" OUTPUT-DIR="%WORKINGDIR%%OUTPUTPATH%/" FILENAME="Temp-%FILENAME%" 

cd %WORKINGDIR%\batchfiles

java -cp %WORKINGDIR%/depend/tools/saxon9/saxon9he.jar;%WORKINGDIR%\depend\tools\Saxon9\xml-commons-resolver-1.2\resolver.jar ^
-Dxml.catalog.files=..\depend\tools\Saxon9\RWS-DTD\catalog.xml ^
net.sf.saxon.Transform ^
-r:org.apache.xml.resolver.tools.CatalogResolver ^
-x:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-y:org.apache.xml.resolver.tools.ResolvingXMLReader ^
-o:%WORKINGDIR%\in\test.xml ^
-s:%WORKINGDIR%\%PATHTOPROJECT%\Temp-%FILENAME% ^
-xsl:%WORKINGDIR%\depend\custom\generate_memory-maps.xsl ^
STARTING-DIR="%WORKINGDIR%%PATHTOPROJECT%/" OUTPUT-DIR="%WORKINGDIR%%OUTPUTPATH%/" FILENAME="Temp-%FILENAME%" 

cd %WORKINGDIR%\batchfiles

del %WORKINGDIR%\out\Temp-%FILENAME%

cd %WORKINGDIR%\batchfiles
