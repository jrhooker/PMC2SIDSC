set PATHTOPROJECT=\Source\firmware
set OUTPUTPATH=\Out
set FILENAME=firmware.ditamap
set DITAMAPNAME=Polarfire.ditamap

cd ..\

set WORKINGDIR=%CD%

cd %WORKINGDIR%\batchfiles

rd /s /q %WORKINGDIR%\out\

mkdir %WORKINGDIR%\out\

rd /s /q %WORKINGDIR%\in\

mkdir %WORKINGDIR%\in\

#xcopy %WORKINGDIR%\%PATHTOPROJECT% %WORKINGDIR%\out\ /S /Y

java -jar %WORKINGDIR%\depend\tools\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%\in\test.xml %WORKINGDIR%\%PATHTOPROJECT%\%FILENAME% %WORKINGDIR%\depend\custom\traverse_ditamaps.xsl  STARTING-DIR="%WORKINGDIR%%PATHTOPROJECT%/" OUTPUT-DIR="%WORKINGDIR%%OUTPUTPATH%/" FILENAME="%FILENAME%"

java -jar %WORKINGDIR%\depend\tools\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%\in\test.xml %WORKINGDIR%\%PATHTOPROJECT%\%FILENAME% %WORKINGDIR%\depend\custom\generate_topics.xsl  STARTING-DIR="%WORKINGDIR%%PATHTOPROJECT%/" OUTPUT-DIR="%WORKINGDIR%%OUTPUTPATH%/" FILENAME="%FILENAME%"


cd %WORKINGDIR%\batchfiles