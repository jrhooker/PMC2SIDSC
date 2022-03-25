<!--  
SIDSC Data Table Domain
Copyright OASIS 2009
Author: Seth Park
 
Delivered as file "dataTableDomain.mod"
-->
<!-- element name entities -->
<!ENTITY % dataTable   "dataTable"   >
<!ENTITY % dataRow   "dataRow "  >
<!ENTITY % dataEntry   "dataEntry"  >
<!ENTITY % dataPhrase  "dataPhrase" >
<!ENTITY % dataGroup  "dataGroup"   >
<!ENTITY % dataInstance  "dataInstance"   >
<!ENTITY % dataInstanceValue  "dataInstanceValue"  >
<!ENTITY % dataInstanceMeaning   "dataInstanceMeaning" >

<!ENTITY % dimension   "dimension" >
<!ENTITY % dimensionValue   "dimensionValue" >
<!ENTITY % dimensionIncrement   "dimensionIncrement" >
<!ENTITY % unitQualifier  "unitQualifier" >
<!ENTITY % namePattern  "namePattern" >


<!-- domains attribute override -->
<!ENTITY included-domains ""   >

<!-- general purpose content models -->
<!ENTITY % dataPhrase.cnt  "#PCDATA | ph" >

<!-- element declarations -->
<!ELEMENT dataTable  (%dataRow;)+ >
<!ATTLIST dataTable   relcolwidth CDATA #IMPLIED
        keycol NMTOKEN #IMPLIED
        refcols NMTOKENS #IMPLIED
        %display-atts;
        %univ-atts;
        spectitle CDATA #IMPLIED
        outputclass CDATA #IMPLIED >

<!ELEMENT dataRow  (%dataEntry;) >
<!ATTLIST dataRow   %univ-atts;>

<!ELEMENT dataEntry  (%dataPhrase.cnt; | %dataPhrase; | %dataGroup; )*>  
<!ATTLIST dataEntry   %univ-atts; specentry CDATA #IMPLIED >

<!ELEMENT dataPhrase  (%dataPhrase.cnt;)*>  
<!ATTLIST dataPhrase   %univ-atts; outputclass CDATA #IMPLIED >

<!ELEMENT dataGroup  (%dataInstance;) >
<!ATTLIST dataGroup   %univ-atts; >

<!ELEMENT dataInstance  (%dataInstanceValue;, %dataInstanceMeaning;)+ >
<!ATTLIST dataInstance   %univ-atts; >

<!ELEMENT dataInstanceValue  (#PCDATA) >
<!ATTLIST dataInstanceValue   %univ-atts; >

<!ELEMENT dataInstanceMeaning  (#PCDATA) >
<!ATTLIST dataInstanceMeaning   %univ-atts; >



<!--  LONG NAME: dimension -->
<!ELEMENT dimension  
  ((%dimensionValue;),
  (%dimensionIncrement;)?,
  (%unitQualifier;)?,(%namePattern;)?)>

<!ATTLIST dimension   
  %id-atts;
  %localization-atts;
  %select-atts;
  outputclass CDATA  #IMPLIED >

<!--  LONG NAME: dimensionValue -->
<!ELEMENT dimensionValue  (%dataPhrase.cnt;)*>

<!ATTLIST dimensionValue   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED >

<!--  LONG NAME: dimensionIncrement -->
<!ELEMENT dimensionIncrement  (%dataPhrase.cnt;)*>

<!ATTLIST dimensionIncrement   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED >



<!--        specialization attribute declarations   -->
<!ATTLIST dataTable  %global-atts; class CDATA "- topic/simpletable dataTableDomain/dataTable ">
<!ATTLIST dataRow   %global-atts; class CDATA "- topic/strow dataTableDomain/dataRow ">
<!ATTLIST dataEntry   %global-atts; class CDATA "- topic/stentry dataTableDomain/dataEntry ">
<!ATTLIST dataPhrase   %global-atts; class CDATA "- topic/ph dataTableDomain/dataPhrase ">
<!ATTLIST dataGroup   %global-atts; class CDATA "- topic/dl dataTableDomain/dataGroup ">
<!ATTLIST dataInstance   %global-atts; class CDATA "- topic/dlentry dataTableDomain/dataInstance ">
<!ATTLIST dataInstanceValue   %global-atts; class CDATA "- topic/dt dataTableDomain/dataInstanceValue ">
<!ATTLIST dataInstanceMeaning   %global-atts; class CDATA "- topic/dd dataTableDomain/dataInstanceMeaning ">

<!ATTLIST dimension  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dimension ">
<!ATTLIST dimensionIncrement  %global-atts;  class CDATA "- topic/ph dataTableDomain/dimensionIncrement ">
<!ATTLIST dimensionValue  %global-atts;  class CDATA "- topic/ph dataTableDomain/dimensionValue ">

<!--        end dataTableDomain.mod   -->