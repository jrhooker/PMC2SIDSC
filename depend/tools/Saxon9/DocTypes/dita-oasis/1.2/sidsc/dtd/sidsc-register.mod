<!--  
SIDSC Register elements
Copyright OASIS 2009
Author: Seth Park

Delivered as file "sidsc-register.mod"
-->
<!--  architecture entities  -->
<!ENTITY % DITAArchNSPrefix "ditaarch">
<!ENTITY % arch-atts "xmlns:%DITAArchNSPrefix; CDATA #FIXED
    'http://dita.oasis-open.org/architecture/2005/' %DITAArchNSPrefix;:DITAArchVersion CDATA  '1.1'" >
    
<!--   element name entities  -->
 <!ENTITY % register  "register"  >
 <!ENTITY % registerName  "registerName"  >
 <!ENTITY % registerNameMore  "registerNameMore"  >
 <!ENTITY % registerBody  "registerBody"  >
 <!ENTITY % registerNameFull  "registerNameFull"  >
 <!ENTITY % registerBitsInLau  "registerBitsInLau"  >
 <!ENTITY % registerBriefDescription  "registerBriefDescription"  >
 <!ENTITY % registerDescription  "registerDescription"  >
 <!ENTITY % registerProperties  "registerProperties"  >
 <!ENTITY % registerPropset  "registerPropset"  >
 <!ENTITY % dimension  "dimension"  >
 <!ENTITY % dimensionIncrement  "dimensionIncrement"  >
 <!ENTITY % dimensionValue  "dimensionValue"  >
 <!ENTITY % unitQualifier  "unitQualifier" >
<!ENTITY % namePattern  "namePattern" >
 <!ENTITY % addressOffset  "addressOffset"  >
 <!ENTITY % registerSize  "registerSize"  >
 <!ENTITY % registerAccess  "registerAccess"  >
 <!ENTITY % registerResetValue  "registerResetValue"  >
 <!ENTITY % bitOrder  "bitOrder"  >
 <!ENTITY % resetTrig  "resetTrig"  >

<!-- domains attribute override -->
<!--<!ENTITY included-domains ""   >
-->

<!ENTITY % sidsc-register-info-types 
  "bitField
  "
>

<!-- general purpose content models -->
<!ENTITY % dataPhrase.cnt  "#PCDATA | ph" >

<!-- element declarations -->
 <!--  LONG NAME: register     -->
<!ELEMENT register
  ((%registerName;),
  (%registerNameMore;), 
  (%registerBody;), 
  (%sidsc-register-info-types;)*) >
  
 <!ATTLIST register  
  id   ID  #REQUIRED
  conref  CDATA  #IMPLIED
  %select-atts;
  %localization-atts;
  %arch-atts;
  outputclass CDATA  #IMPLIED 
  domains  CDATA  "&included-domains;"  >

<!--  LONG NAME: registerName     -->
<!ELEMENT registerName   
  (%title.cnt;)*  >
  
<!ATTLIST registerName  
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED 
    %ish-variables-atts; >

<!--  LONG NAME: registerNameMore -->
<!ELEMENT registerNameMore  
  ((%registerNameFull;), 
  (%registerBriefDescription;)?)
  >

<!ATTLIST registerNameMore   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED
  %ish-variables-atts; >

<!--  LONG NAME: registerNameFull     -->
<!ELEMENT registerNameFull  
  (%title.cnt;)*  >

<!ATTLIST registerNameFull  
  %univ-atts;
  outputclass 
  CDATA #IMPLIED 
    %ish-variables-atts;
  >

<!--  LONG NAME: registerBriefDescription     -->
<!ELEMENT registerBriefDescription  
  (%title.cnt;)*  >

<!ATTLIST registerBriefDescription  
  %univ-atts;
  outputclass 
  CDATA #IMPLIED 
  %ish-variables-atts; >

<!--  LONG NAME: registerBody -->
<!ELEMENT registerBody  
  ((%registerDescription;), 
  (%registerProperties;))>

<!ATTLIST registerBody   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED >

<!--  LONG NAME: registerDescription -->
<!ELEMENT registerDescription  
  (#PCDATA | %body.cnt;)*  >

<!ATTLIST registerDescription   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED
  %ish-variables-atts; >

<!--  LONG NAME: registerProperties -->
<!ELEMENT registerProperties  
  (%registerPropset;)>

<!ATTLIST registerProperties   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED >

<!--  LONG NAME: registerPropset -->
<!ELEMENT registerPropset   
  ((%registerBitsInLau;)?,
  (%addressOffset;),
  (%registerSize;),
  (%registerAccess;)?,
  (%registerResetValue;)?,
  (%bitOrder;),
  (%resetTrig;)?,
  (%dimension;)?)>

<!-- changed attribute set to universal -->
<!ATTLIST registerPropset   
     %univ-atts;
  outputclass CDATA  #IMPLIED >

<!--  LONG NAME: registerBitsInLau -->
<!ELEMENT registerBitsInLau  
  (#PCDATA | %foreign; | %ph;)*>

<!ATTLIST registerBitsInLau   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED 
  %ish-variables-atts; >

<!--  LONG NAME: addressOffset -->
<!ELEMENT addressOffset   (%dataPhrase.cnt;)*>

<!ATTLIST addressOffset   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED
  %ish-variables-atts; >

<!--  LONG NAME: registerSize -->
<!ELEMENT registerSize   (%dataPhrase.cnt;)*  >

<!ATTLIST registerSize   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED
  %ish-variables-atts; >

<!--  LONG NAME: registerAccess -->
<!ELEMENT registerAccess  (%dataPhrase.cnt;)* >

<!ATTLIST registerAccess   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED 
  %ish-variables-atts;>

<!--  LONG NAME: registerResetValue -->
<!ELEMENT registerResetValue  (%dataPhrase.cnt;)* >

<!ATTLIST registerResetValue   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED
  %ish-variables-atts; >

<!--  LONG NAME: bitOrder -->
<!ELEMENT bitOrder (#PCDATA)>

<!ATTLIST bitOrder   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED
  %ish-variables-atts; >

<!--  LONG NAME: resetTrig -->
<!ELEMENT resetTrig (#PCDATA)>

<!ATTLIST resetTrig   
  %id-atts;
  %localization-atts;
  outputclass CDATA  #IMPLIED >


<!--        specialization attribute declarations   -->
<!ATTLIST register  %global-atts;  class CDATA "- topic/topic reference/reference sidsc-register/register ">
<!ATTLIST registerName  %global-atts;  class CDATA "- topic/title reference/title sidsc-register/registerName ">
<!ATTLIST registerNameMore  %global-atts;  class CDATA "- topic/abstract reference/abstract sidsc-register/registerNameMore ">
<!ATTLIST registerBody  %global-atts;  class CDATA "- topic/body reference/refbody sidsc-register/registerBody ">
<!ATTLIST registerNameFull  %global-atts;  class CDATA "- topic/shortdesc reference/shortdesc sidsc-register/registerNameFull ">
<!ATTLIST registerBitsInLau  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-register/registerBitsInLau ">
<!ATTLIST registerBriefDescription  %global-atts;  class CDATA "- topic/p reference/p sidsc-register/registerBriefDescription ">
<!ATTLIST registerDescription  %global-atts;  class CDATA "- topic/section reference/section sidsc-register/registerDescription ">
<!ATTLIST registerProperties  %global-atts;  class CDATA "- topic/simpletable dataTableDomain/dataTable sidsc-register/registerProperties ">
<!ATTLIST registerPropset  %global-atts;  class CDATA "- topic/strow dataTableDomain/dataRow sidsc-register/registerPropset ">
<!ATTLIST addressOffset  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-register/addressOffset ">
<!ATTLIST registerSize  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-register/registerSize ">
<!ATTLIST registerAccess  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-register/registerAccess ">
<!ATTLIST registerResetValue  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-register/registerResetValue ">
<!ATTLIST bitOrder  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-register/bitOrder ">
<!ATTLIST resetTrig  %global-atts;  class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-register/resetTrig ">
<!-- end sidsc-register.mod -->