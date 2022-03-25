<!--  
SIDSC Address Block
Copyright OASIS 2009
Author: Seth Park
 
Delivered as file "sidsc-addressBlock.mod"
-->
<!--  architecture entities  -->
<!ENTITY % DITAArchNSPrefix "ditaarch">
<!ENTITY % arch-atts "xmlns:%DITAArchNSPrefix; CDATA #FIXED
    'http://dita.oasis-open.org/architecture/2005/' %DITAArchNSPrefix;:DITAArchVersion CDATA  '1.1'" >
    
<!-- element name entities -->
 <!ENTITY % addressBlock  "addressBlock"  >
 <!ENTITY % addressBlockName  "addressBlockName"  >
 <!ENTITY % addressBlockBriefDescription  "addressBlockBriefDescription">
 <!ENTITY % addressBlockBody  "addressBlockBody"  >
 <!ENTITY % addressBlockDescription  "addressBlockDescription"  >
 <!ENTITY % addressBlockProperties  "addressBlockProperties"  >
  <!ENTITY % addressBlockPropset  "addressBlockPropset"  >
 <!ENTITY % baseAddress  "baseAddress"  >
 <!ENTITY % range  "range"  >
 <!ENTITY % width  "width"  >
 <!ENTITY % byteOrder  "byteOrder"  >

<!-- domains attribute override -->
<!ENTITY included-domains ""   >

<!ENTITY % sidsc-addressBlock-info-types 
  "register
  "
>

<!-- element declarations -->
<!--  LONG NAME: addressBlock -->
<!ELEMENT addressBlock  
  ((%addressBlockName;), 
  (%addressBlockBriefDescription;), 
  (%addressBlockBody;),
  (%sidsc-addressBlock-info-types;)*)  > 
  
<!ATTLIST addressBlock  
   id  ID   #REQUIRED
   conref  CDATA   #IMPLIED
   %select-atts;
   %localization-atts;
   %arch-atts;
   outputclass 
  CDATA   #IMPLIED
   domains  CDATA   "&included-domains;"  > 

<!--  LONG NAME: addressBlockName   -->
<!ELEMENT addressBlockName   
  (%title.cnt;)*   >    
<!ATTLIST addressBlockName   
   %id-atts;
   %localization-atts;
   outputclass  CDATA   #IMPLIED >

<!--  LONG NAME: addressBlockBriefDescription   -->
<!ELEMENT addressBlockBriefDescription  
  (%title.cnt;)*   > 

<!ATTLIST addressBlockBriefDescription   
  %univ-atts;
  outputclass 
  CDATA #IMPLIED  > 

<!--  LONG NAME: addressBlockBody -->
<!ELEMENT addressBlockBody  
  ((%addressBlockDescription;), 
  (%addressBlockProperties;))>
  
<!ATTLIST addressBlockBody  
   %id-atts;
   %localization-atts;
   outputclass  CDATA   #IMPLIED >

<!--  LONG NAME: addressBlockDescription -->
<!ELEMENT addressBlockDescription  
  ((%body.cnt;)*)  > 
<!ATTLIST addressBlockDescription  
   %id-atts;
   %localization-atts;
   outputclass  CDATA   #IMPLIED >

<!--  LONG NAME: addressBlockProperties -->
<!ELEMENT addressBlockProperties  
  (%addressBlockPropset;)  > 
<!ATTLIST addressBlockProperties  
   %id-atts;
   %localization-atts;
   outputclass  CDATA   #IMPLIED >

<!--  LONG NAME: addressBlockPropset -->
<!ELEMENT addressBlockPropset  
  ((%baseAddress;),
  (%range;)?,
  (%width;)?,
  (%byteOrder;))  > 

<!ATTLIST addressBlockPropset   
   %id-atts;
   %localization-atts;
   outputclass  CDATA   #IMPLIED >

<!--  LONG NAME: baseAddress -->
<!ELEMENT baseAddress  
  (#PCDATA)  > 

<!ATTLIST baseAddress  
   %id-atts;
   %localization-atts;
   outputclass  CDATA   #IMPLIED >

<!--  LONG NAME: range -->
<!ELEMENT range  
  (#PCDATA)  > 
<!ATTLIST range  
   %id-atts;
   %localization-atts;
   outputclass  CDATA   #IMPLIED >

<!--  LONG NAME: width -->
<!ELEMENT width  
  (#PCDATA)  > 
<!ATTLIST width  
   %id-atts;
   %localization-atts;
   outputclass  CDATA   #IMPLIED >

<!--  LONG NAME: byteOrder -->
<!ELEMENT byteOrder  
  (#PCDATA)  > 
<!ATTLIST byteOrder  
   %id-atts;
   %localization-atts;
   outputclass  CDATA   #IMPLIED >
   
<!--  specialization attribute declarations   -->
<!ATTLIST addressBlock  %global-atts;  class CDATA "- topic/topic reference/reference sidsc-addressBlock/addressBlock ">
<!ATTLIST addressBlockName  %global-atts;  class CDATA "- topic/title reference/title sidsc-addressBlock/addressBlockName ">
<!ATTLIST addressBlockBriefDescription  %global-atts;  class CDATA "- topic/shortdesc reference/shortdesc sidsc-addressBlock/addressBlockBriefDescription ">
<!ATTLIST addressBlockBody  %global-atts;  class CDATA "- topic/body reference/refbody sidsc-addressBlock/addressBlockBody ">
<!ATTLIST addressBlockDescription  %global-atts;  class CDATA "- topic/section reference/section sidsc-addressBlock/addressBlockDescription ">
<!ATTLIST addressBlockProperties  %global-atts;  class CDATA "- topic/simpletable dataTableDomain/dataTable sidsc-addressBlock/addressBlockProperties ">
<!ATTLIST addressBlockPropset  %global-atts;  class CDATA "- topic/strow dataTableDomain/dataRow sidsc-addressBlock/addressBlockPropset ">
<!ATTLIST baseAddress  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-addressBlock/baseAddress ">
<!ATTLIST range  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-addressBlock/range ">
<!ATTLIST width  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-addressBlock/width ">
<!ATTLIST byteOrder  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-addressBlock/byteOrder ">
<!-- end sidsc-addressBlock.mod -->