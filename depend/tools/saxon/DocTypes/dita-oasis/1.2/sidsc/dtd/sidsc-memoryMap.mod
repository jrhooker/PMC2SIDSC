<!--  
SIDSC Memory Map
Copyright OASIS 2009
Author: Seth Park
 
Delivered as file "sidsc-memoryMap.mod"
-->
<!--  architecture entities  -->
<!ENTITY % DITAArchNSPrefix "ditaarch">
<!ENTITY % arch-atts "xmlns:%DITAArchNSPrefix; CDATA #FIXED
    'http://dita.oasis-open.org/architecture/2005/' %DITAArchNSPrefix;:DITAArchVersion CDATA  '1.1'" >
    
<!-- element name entities -->
 <!ENTITY % memoryMap  "memoryMap" >
 <!ENTITY % memoryMapName  "memoryMapName" >
 <!ENTITY % memoryMapBody  "memoryMapBody" >
 <!ENTITY % bitsInLau  "bitsInLau" >
 <!ENTITY % memoryMapClass  "memoryMapClass" >
 
<!-- domains attribute override -->
<!ENTITY included-domains ""   >

<!ENTITY % sidsc-memoryMap-info-types 
  "addressBlock
  "
>

<!-- element declarations -->
<!--  LONG NAME: memoryMap -->
<!ELEMENT memoryMap    
  ((%memoryMapName;), 
  (%memoryMapBody;), 
  (%sidsc-memoryMap-info-types;)*)   > 
  
<!ATTLIST memoryMap   
    id   ID    #REQUIRED
    conref  CDATA    #IMPLIED
    %select-atts;
    %localization-atts;
    %arch-atts;
    outputclass 
   CDATA    #IMPLIED
    domains    CDATA    "&included-domains;" > 

<!--  LONG NAME: memoryMapName    -->
<!ELEMENT memoryMapName  (%title.cnt;)* >     

<!ATTLIST memoryMapName    
    %id-atts;
    %localization-atts;
    outputclass CDATA #IMPLIED > 

<!--  LONG NAME: memoryMapBody -->
<!ELEMENT memoryMapBody    
  ((%bitsInLau;), (%memoryMapClass;)) > 
  
<!ATTLIST memoryMapBody   
    %id-atts;
    %localization-atts;
    outputclass CDATA  #IMPLIED > 

<!--  LONG NAME: bitsInLau -->
<!ELEMENT bitsInLau  (#PCDATA) >

<!ATTLIST bitsInLau   
    %id-atts;
    %localization-atts;
    outputclass CDATA  #IMPLIED > 

<!--  LONG NAME: memoryMapClass -->
<!ELEMENT memoryMapClass (#PCDATA) >

<!ATTLIST memoryMapClass   
    %id-atts;
    %localization-atts;
    outputclass CDATA  #IMPLIED > 

<!--  specialization attribute declarations   -->
<!ATTLIST memoryMap  %global-atts;  class CDATA "- topic/topic reference/reference sidsc-memoryMap/memoryMap ">
<!ATTLIST memoryMapName  %global-atts;  class CDATA "- topic/title reference/title sidsc-memoryMap/memoryMapName ">
<!ATTLIST memoryMapBody  %global-atts;  class CDATA "- topic/body reference/refbody sidsc-memoryMap/memoryMapBody ">
<!ATTLIST bitsInLau  %global-atts;  class CDATA "- topic/p reference/p sidsc-memoryMap/bitsInLau ">
<!ATTLIST memoryMapClass  %global-atts;  class CDATA "- topic/p reference/p sidsc-memoryMap/memoryMapClass ">
<!-- end sidsc-memoryMap.mod -->