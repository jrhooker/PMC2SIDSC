<!--  
SIDSC Bit Field
Copyright OASIS 2009
Author: Seth Park
 
Delivered as file "sidsc-bitField.mod"
-->
<!--  architecture entities  -->
<!ENTITY % DITAArchNSPrefix "ditaarch">
<!ENTITY % arch-atts "xmlns:%DITAArchNSPrefix; CDATA #FIXED
    'http://dita.oasis-open.org/architecture/2005/' %DITAArchNSPrefix;:DITAArchVersion CDATA  '1.1'" >
    
<!-- element name entities -->
 <!ENTITY % bitField   "bitField"   >
 <!ENTITY % bitFieldName   "bitFieldName"   >
 <!ENTITY % bitFieldBriefDescription   "bitFieldBriefDescription"   >
 <!ENTITY % bitFieldDescription   "bitFieldDescription"   >
 <!ENTITY % bitFieldProperties   "bitFieldProperties"   >
 <!ENTITY % bitFieldPropset "bitFieldPropset" >

<!-- include dimension element -->
 <!ENTITY % dimension  "dimension"  >
 <!ENTITY % dimensionIncrement  "dimensionIncrement"  >
 <!ENTITY % dimensionValue  "dimensionValue"  >
 <!ENTITY % unitQualifier  "unitQualifier" >
<!ENTITY % namePattern  "namePattern" >
<!-- end include dimension elements -->

 <!ENTITY % bitFieldBody   "bitFieldBody"   >
 <!ENTITY % bitNumbers   "bitNumbers"   >
 <!ENTITY % bitWidth   "bitWidth"   >
 <!ENTITY % bitOffset   "bitOffset"   >
 <!ENTITY % bitFieldAccess   "bitFieldAccess"   >
 <!ENTITY % bitFieldRadix   "bitFieldRadix"   >
 <!ENTITY % bitFieldReset   "bitFieldReset"   >
 <!ENTITY % bitFieldResetValue   "bitFieldResetValue"   >
 <!ENTITY % bitFieldResetTrig   "bitFieldResetTrig"   >
 <!ENTITY % bitFieldResetValueSource   "bitFieldResetValueSource"   >
 <!ENTITY % bitFieldValues   "bitFieldValues"   >
  <!ENTITY % bitFieldValueGroup   "bitFieldValueGroup"   >
 <!ENTITY % bitFieldValue   "bitFieldValue"   >
 <!ENTITY % bitFieldValueName   "bitFieldValueName"   >
 <!ENTITY % bitFieldValueDescription   "bitFieldValueDescription"   >

<!-- domains attribute override -->
<!--<!ENTITY included-domains ""   >
-->

<!ENTITY % sidsc-bitField-info-types 
  "no-topic-nesting
  "
>

<!-- general purpose content models -->
<!ENTITY % dataPhrase.cnt  "#PCDATA | ph" >


<!-- domains attribute override -->
<!--  LONG NAME: bitField     -->
<!ELEMENT bitField
  ((%bitFieldName;),
  (%bitFieldBriefDescription;), 
  (%bitFieldBody;),
  (%sidsc-bitField-info-types;)*) > 
 
 <!ATTLIST bitField  
   id   ID   #REQUIRED
   conref   CDATA  #IMPLIED
   %select-atts;
   %localization-atts;
   %arch-atts;
   outputclass 
  CDATA  #IMPLIED
   domains  CDATA  "&included-domains;"  > 

<!--  LONG NAME: bitFieldName     -->
<!ELEMENT bitFieldName   
  (%title.cnt;)*   >    
  
<!ATTLIST bitFieldName   
   %id-atts;
   %localization-atts;
   outputclass   CDATA  #IMPLIED 
  %ish-variables-atts;> 

<!--  LONG NAME: bitFieldBriefDescription     -->
<!ELEMENT bitFieldBriefDescription   
  ( %dataPhrase.cnt; | %body.cnt;  )*   > 
  
<!ATTLIST bitFieldBriefDescription   
  %univ-atts;
  outputclass 
  CDATA #IMPLIED
  %ish-variables-atts;  > 

<!--  LONG NAME: bitFieldBody -->
<!ELEMENT bitFieldBody   
  ((%bitFieldDescription;), 
  (%bitFieldProperties;),
  (%bitFieldValues;)?)   > 
  
<!ATTLIST bitFieldBody   
   %id-atts;
   %localization-atts;
   outputclass 
  CDATA  #IMPLIED  > 

<!--  LONG NAME: bitFieldDescription -->
<!ELEMENT bitFieldDescription   
  (%section.notitle.cnt;)*   > 
  
<!ATTLIST bitFieldDescription   
   %id-atts;
   %localization-atts;
   outputclass 
  CDATA  #IMPLIED
  %ish-variables-atts;  > 
  
<!--  LONG NAME: bitFieldProperties -->
<!ELEMENT bitFieldProperties   
  (%bitFieldPropset;)
>
<!ATTLIST bitFieldProperties   
   %id-atts;
   %localization-atts;
   outputclass 
  CDATA  #IMPLIED  > 

<!--  LONG NAME: bitFieldPropset -->
<!ELEMENT bitFieldPropset   
  (((%bitNumbers;)?, ((%bitWidth;), (%bitOffset;)?)),
  (%bitFieldAccess;)?,
  (%bitFieldRadix;)?,
  (%bitFieldReset;)*,
  (%dimension;)?)>
  
<!ATTLIST bitFieldPropset   
   %id-atts;
   %localization-atts;
   outputclass 
  CDATA #IMPLIED  > 

<!--  LONG NAME: bitNumbers -->
<!ELEMENT bitNumbers   
  (%dataPhrase.cnt;)*   > 
<!ATTLIST bitNumbers   
   %univ-atts;
  specentry CDATA #IMPLIED >

<!--  LONG NAME: bitWidth -->
<!ELEMENT bitWidth   
  (%dataPhrase.cnt;)*   > 
<!ATTLIST bitWidth   
   %univ-atts;
  specentry CDATA #IMPLIED 
   %ish-variables-atts; > 

<!--  LONG NAME: bitOffset -->
<!ELEMENT bitOffset   
  (%dataPhrase.cnt;)*  > 
<!ATTLIST bitOffset   
   %univ-atts;
  specentry CDATA #IMPLIED
  %ish-variables-atts; > 

<!--  LONG NAME: bitFieldAccess -->
<!ELEMENT bitFieldAccess   
  (%dataPhrase.cnt;)*   > 
<!ATTLIST bitFieldAccess   
   %univ-atts;
  specentry CDATA #IMPLIED
  %ish-variables-atts;   > 

<!--  LONG NAME: bitFieldRadix -->
<!ELEMENT bitFieldRadix   
  (%dataPhrase.cnt;)*   > 
<!ATTLIST bitFieldRadix   
   %univ-atts;
  specentry CDATA #IMPLIED   > 

<!--  LONG NAME: bitFieldReset -->
<!ELEMENT bitFieldReset   
  (((%bitFieldResetValue;) | (%bitFieldResetValueSource;)),
  (%bitFieldResetTrig;)?)>
  
<!ATTLIST bitFieldReset   
   %id-atts;
   %localization-atts;
   outputclass 
  CDATA  #IMPLIED  > 

<!--  LONG NAME: bitFieldResetValue -->
<!ELEMENT bitFieldResetValue   
  (%dataPhrase.cnt;)*  > 
  
<!ATTLIST bitFieldResetValue   
   %univ-atts;
  specentry CDATA #IMPLIED
  %ish-variables-atts;   > 

<!--  LONG NAME: bitFieldResetValueSource -->
<!ELEMENT bitFieldResetValueSource   
  (%dataPhrase.cnt;)*  > 
  
<!ATTLIST bitFieldResetValueSource   
   %univ-atts;
  specentry CDATA #IMPLIED > 

<!--  LONG NAME: bitFieldResetTrig -->
<!ELEMENT bitFieldResetTrig   
  (%dataPhrase.cnt;)*  > 
  
<!ATTLIST bitFieldResetTrig   
   %univ-atts;
specentry CDATA #IMPLIED >

<!--  LONG NAME: bitFieldValues -->
<!ELEMENT bitFieldValues   
  (%bitFieldValueGroup;)+>
  
<!ATTLIST bitFieldValues   
   %id-atts;
   %localization-atts;
   outputclass 
  CDATA  #IMPLIED 
  %ish-variables-atts;> 
  
<!--  LONG NAME: bitFieldValueGroup -->
<!ELEMENT bitFieldValueGroup   
  ((%bitFieldValue;)?,
  (%bitFieldValueName;)?,
  (%bitFieldValueDescription;)?)>
  
<!ATTLIST bitFieldValueGroup   
   %univ-atts;
   outputclass 
  CDATA  #IMPLIED  > 
  
  <!--  LONG NAME: bitFieldValue -->
  <!ELEMENT bitFieldValue   
  (%dataPhrase.cnt;)*  > 
   <!ATTLIST bitFieldValue   
   %univ-atts;
   specentry CDATA #IMPLIED
  %ish-variables-atts; >

<!--  LONG NAME: bitFieldValueName -->
<!ELEMENT bitFieldValueName   
  (%dataPhrase.cnt;)*  > 
  
<!ATTLIST bitFieldValueName   
   %univ-atts;
specentry CDATA #IMPLIED >

<!--  LONG NAME: bitFieldValueDescription -->
<!ELEMENT bitFieldValueDescription   (%tblcell.cnt;)*   > 

<!ATTLIST bitFieldValueDescription   
   %univ-atts;
specentry CDATA #IMPLIED
  %ish-variables-atts; >

<!--  specialization attribute declarations   -->
<!ATTLIST bitField   %global-atts;  class CDATA "- topic/topic reference/reference sidsc-bitField/bitField ">
<!ATTLIST bitFieldName   %global-atts;  class CDATA "- topic/title reference/title sidsc-bitField/bitFieldName ">
<!ATTLIST bitFieldBriefDescription   %global-atts;  class CDATA "- topic/shortdesc reference/shortdesc sidsc-bitField/bitFieldBriefDescription ">
<!ATTLIST bitFieldDescription   %global-atts;  class CDATA "- topic/section reference/section sidsc-bitField/bitFieldDescription ">
<!ATTLIST bitFieldProperties   %global-atts;  class CDATA "- topic/simpletable dataTableDomain/dataTable sidsc-bitField/bitFieldProperties ">
<!ATTLIST bitFieldPropset   %global-atts; class CDATA "- topic/strow dataTableDomain/dataRow sidsc-bitField/bitFieldPropset ">
<!ATTLIST bitFieldBody   %global-atts;  class CDATA "- topic/body reference/refbody sidsc-bitField/bitFieldBody ">
<!ATTLIST bitNumbers   %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-bitField/bitNumbers ">
<!ATTLIST bitWidth   %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-bitField/bitWidth ">
<!ATTLIST bitOffset   %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-bitField/bitOffset ">
<!ATTLIST bitFieldAccess   %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-bitField/bitFieldAccess ">
<!ATTLIST bitFieldRadix   %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-bitField/bitFieldRadix ">
<!ATTLIST bitFieldReset   %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-bitField/bitFieldReset ">
<!ATTLIST bitFieldResetValue   %global-atts;  class CDATA "- topic/ph dataTableDomain/dataPhrase sidsc-bitField/bitFieldResetValue ">
<!ATTLIST bitFieldResetTrig   %global-atts;  class CDATA "- topic/ph dataTableDomain/dataPhrase sidsc-bitField/bitFieldResetTrig ">
<!ATTLIST bitFieldResetValueSource   %global-atts;  class CDATA "- topic/ph dataTableDomain/dataPhrase sidsc-bitField/bitFieldResetValueSource ">
<!ATTLIST bitFieldValues   %global-atts;  class CDATA "- topic/simpletable dataTableDomain/dataTable sidsc-bitField/bitFieldValues ">
<!ATTLIST bitFieldValueGroup   %global-atts;  class CDATA "- topic/strow dataTableDomain/dataRow sidsc-bitField/bitFieldGroup ">
<!ATTLIST bitFieldValue   %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-bitField/bitFieldValue ">
<!ATTLIST bitFieldValueName   %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-bitField/bitFieldValueName ">
<!ATTLIST bitFieldValueDescription   %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-bitField/bitFieldValueDescription ">
<!-- end sidsc-bitField.mod -->