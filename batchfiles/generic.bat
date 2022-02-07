set PATHTOPROJECT=%1
set FILENAME=%2
set DITAMAPNAME=%3
cd ..\

set WORKINGDIR=%CD%

cd %WORKINGDIR%\batchfiles

rd /s /q %WORKINGDIR%\out\

mkdir %WORKINGDIR%\out\

java -jar %WORKINGDIR%\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%\in\saxon_temporary1.xml %WORKINGDIR%\%PATHTOPROJECT%\%FILENAME% %WORKINGDIR%\depend\pmc_custom\xinclude_resolver.xsl

echo Xincludes integrated

java -jar %WORKINGDIR%\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%\in\saxon_temporary2.xml %WORKINGDIR%\in\saxon_temporary1.xml %WORKINGDIR%\depend\pmc_custom\generate_ids.xsl

java -jar %WORKINGDIR%\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%\in\saxon_temporary3.xml %WORKINGDIR%\in\saxon_temporary2.xml %WORKINGDIR%\depend\pmc_custom\rewrite_targets.xsl

java -jar %WORKINGDIR%\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%\in\saxon_temporary5.xml %WORKINGDIR%\in\saxon_temporary3.xml %WORKINGDIR%\depend\pmc_custom\rewrite_links.xsl

echo Docbook IDs generated

java -jar %WORKINGDIR%\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%\in\saxon_temporary6.xml %WORKINGDIR%\in\saxon_temporary5.xml %WORKINGDIR%\depend\pmc_custom\unique-ify_ids.xsl

echo IDs ensure unique

java -jar %WORKINGDIR%\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%\out\%DITAMAPNAME% %WORKINGDIR%\in\saxon_temporary6.xml %WORKINGDIR%\depend\pmc_custom\generate_bookmap.xsl

echo Bookmap Generated

java -jar %WORKINGDIR%\saxonhe9-3-0-4j\saxon9he.jar   -o:%WORKINGDIR%\out\trashme.xml %WORKINGDIR%\in\saxon_temporary6.xml %WORKINGDIR%\depend\pmc_custom\generate_topics_docbook_1.0.xsl

echo Topics Generated

rd /s /q %WORKINGDIR%\in\

mkdir %WORKINGDIR%\in\

cd %WORKINGDIR%\batchfiles