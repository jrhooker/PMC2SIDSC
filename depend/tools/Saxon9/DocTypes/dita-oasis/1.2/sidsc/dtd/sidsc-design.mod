<!--  
SIDSC Design Map Type
Copyright OASIS 2009
Author: Seth Park
 
Delivered as file "sidsc-design.mod"
-->
<!--  architecture entities  -->
<!ENTITY % DITAArchNSPrefix "ditaarch">
<!ENTITY % arch-atts "xmlns:%DITAArchNSPrefix; CDATA #FIXED
    'http://dita.oasis-open.org/architecture/2005/' %DITAArchNSPrefix;:DITAArchVersion CDATA  '1.1'" >

<!-- element name entities -->
<!ENTITY % sidsc-design "sidsc-design" >    
<!ENTITY % component-ref "component-ref" >
<!ENTITY % parameter "parameter" >
<!ENTITY % key "key" >
<!ENTITY % value "value" >

<!-- domains attribute override -->
<!ENTITY included-domains "" >

<!-- element decl. -->
<!ELEMENT sidsc-design       ((%component-ref;)*, (%reltable;)?)>

<!ATTLIST sidsc-design
    title      CDATA           #IMPLIED
    id         ID     #IMPLIED
    conref     CDATA           #IMPLIED
    anchorref  CDATA           #IMPLIED
    outputclass  CDATA           #IMPLIED
    %localization-atts;
    %arch-atts;
    domains    CDATA         "&included-domains;" 
    %topicref-atts;
    %select-atts;   >

<!ELEMENT component-ref     (%parameter;)*>

<!ATTLIST component-ref
    navtitle   CDATA           #IMPLIED
    href       CDATA           #IMPLIED
    keyref     CDATA           #IMPLIED
    query      CDATA           #IMPLIED
    copy-to    CDATA           #IMPLIED
    outputclass CDATA           #IMPLIED
    %topicref-atts;
    %select-atts;>
 
<!ELEMENT parameter ((%key;),(%value;)) >

<!ATTLIST parameter %univ-atts;>
 
 <!ELEMENT key (%data.cnt;)* >

<!ATTLIST key %univ-atts;>
 
<!ELEMENT value (%data.cnt;)* >

<!ATTLIST value %univ-atts;>

<!--  specialization attribute declarations   -->
<!ATTLIST sidsc-design     %global-atts; class CDATA "- map/map sidsc-design/sidsc-design ">
<!ATTLIST component-ref  %global-atts; class CDATA "- map/topicref sidsc-design/component-ref ">
<!ATTLIST parameter  %global-atts; class CDATA "- topic/data sidsc-design/parameter ">
<!ATTLIST key  %global-atts; class CDATA "- topic/data sidsc-design/key ">
<!ATTLIST value  %global-atts; class CDATA "- topic/data sidsc-design/value ">
<!-- end sidsc-design.mod -->