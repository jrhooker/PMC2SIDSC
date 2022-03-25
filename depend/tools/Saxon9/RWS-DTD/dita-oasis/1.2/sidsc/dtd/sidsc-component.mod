<!--  
SIDSC Component
Copyright OASIS 2009
Author: Seth Park
 
Delivered as file "sidsc-component.mod"
-->
<!--  architecture entities  -->
<!ENTITY % DITAArchNSPrefix "ditaarch">
<!ENTITY % arch-atts "xmlns:%DITAArchNSPrefix; CDATA #FIXED
    'http://dita.oasis-open.org/architecture/2005/' %DITAArchNSPrefix;:DITAArchVersion CDATA  '1.1'" >

<!-- element name entities -->
 <!ENTITY % sidsc-component  "sidsc-component" >
 <!ENTITY % componentName  "componentName">
 <!ENTITY % componentBriefDescription  "componentBriefDescription" >
 <!ENTITY % componentBody  "componentBody" >
 <!ENTITY % componentDescription  "componentDescription" >
 <!ENTITY % unitAddress  "unitAddress" >
 <!ENTITY % componentInstanceVariables  "componentInstanceVariables"  >
 <!ENTITY % componentData  "componentData" >
 <!ENTITY % componentDataKey  "componentDataKey">
 <!ENTITY % componentDataValue  "componentDataValue"  >  
 <!ENTITY % instanceParameters  "instanceParameters"  >

<!-- domains attribute override -->
<!ENTITY included-domains "" >

<!ENTITY % sidsc-component-info-types 
  "memoryMap
  "
>

<!-- element decl. -->
<!ELEMENT sidsc-component
   ((%componentName;),(%data;)*,(%componentBriefDescription;), (%componentBody;), (%sidsc-component-info-types;)*)>

<!ATTLIST sidsc-component  
    id   ID    #REQUIRED
    conref  CDATA    #IMPLIED
    %select-atts;
    %localization-atts;
    %arch-atts;
    outputclass CDATA    #IMPLIED
    domains    CDATA    "&included-domains;" >

<!ELEMENT componentName   
   (%title.cnt;)*>
    
<!ATTLIST componentName    
    %id-atts;
    %localization-atts;
    outputclass  CDATA  #IMPLIED >
        
<!ELEMENT componentBriefDescription    
   (%title.cnt;)* >
    
<!ATTLIST componentBriefDescription    
  %univ-atts;
  outputclass CDATA #IMPLIED >

<!ELEMENT componentBody    
    ((%body.cnt;)*, (%componentDescription;), (%unitAddress;)?,(%componentInstanceVariables;)?) >
   
<!ATTLIST componentBody   
    %id-atts;
    %localization-atts;
    outputclass CDATA #IMPLIED >

<!ELEMENT componentDescription    
    (%section.notitle.cnt;)* >
  
<!ATTLIST componentDescription   
    %id-atts;
    %localization-atts;
    outputclass CDATA   #IMPLIED >

<!ELEMENT unitAddress (#PCDATA) >

<!ATTLIST unitAddress   
    %id-atts;
    %localization-atts;
    outputclass  CDATA  #IMPLIED >

<!ELEMENT componentInstanceVariables   
    ((%componentData;)*) >
  
<!ATTLIST componentInstanceVariables  
    spectitle  CDATA  #IMPLIED
    %univ-atts;
    outputclass CDATA #IMPLIED >

<!ELEMENT componentData    
   ((((%componentDataKey;),(%componentDataValue;)) | (%instanceParameters;)))*>
 
<!ATTLIST componentData    
    %univ-atts;
    outputclass CDATA  #IMPLIED >

<!ELEMENT componentDataKey   
    (%term.cnt;)*>
  
<!ATTLIST componentDataKey   
    %univ-atts;
    outputclass  CDATA #IMPLIED >

<!ELEMENT componentDataValue (%defn.cnt;)*  >

<!ATTLIST componentDataValue  
    %univ-atts;
    outputclass CDATA  #IMPLIED >

<!ELEMENT instanceParameters    
  ((%ph;)*)>
  
<!ATTLIST instanceParameters    
    %univ-atts;
    outputclass CDATA #IMPLIED >

<!--  specialization attribute declarations   -->
<!ATTLIST sidsc-component  %global-atts;  class CDATA "- topic/topic reference/reference sidsc-component/sidsc-component ">
<!ATTLIST componentName  %global-atts;  class CDATA "- topic/title reference/title sidsc-component/componentName ">
<!ATTLIST componentBriefDescription  %global-atts;  class CDATA "- topic/shortdesc reference/shortdesc sidsc-component/componentBriefDescription ">
<!ATTLIST componentBody  %global-atts;  class CDATA "- topic/body reference/refbody sidsc-component/componentBody ">
<!ATTLIST componentDescription  %global-atts;  class CDATA "- topic/section reference/section sidsc-component/componentDescription ">
<!ATTLIST unitAddress  %global-atts;  class CDATA "- topic/p reference/p sidsc-component/unitAddress ">
<!ATTLIST componentInstanceVariables   %global-atts; class CDATA "- topic/simpletable dataTableDomain/dataTable/componentInstanceVariables ">
<!ATTLIST componentData   %global-atts; class CDATA "- topic/strow dataTableDomain/dataRow sidsc-component/componentData ">
<!ATTLIST componentDataKey  %global-atts; class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-component/componentDataKey ">
<!ATTLIST componentDataValue  %global-atts; class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-component/componentDataValue ">
<!ATTLIST instanceParameters   %global-atts; class CDATA "- topic/stentry dataTableDomain/dataEntry sidsc-component/instanceParameters ">
<!-- end sidsc-component.mod -->