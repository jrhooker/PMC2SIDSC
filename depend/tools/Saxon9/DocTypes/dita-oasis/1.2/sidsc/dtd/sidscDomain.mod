<!--  
SIDSC Domain
Copyright OASIS 2009
Author: Seth Park
 
Delivered as file "sidscDomain.mod"
-->
<!-- element name entities -->
<!ENTITY % active-low   "active-low"  >
<!ENTITY % unitQualifier  "unitQualifier" >
<!ENTITY % namePattern  "namePattern" >
<!ENTITY % instancesNumber "instancesNumber" >
<!ENTITY % instanceOffsets "instanceOffsets" >

<!-- domains attribute override -->
<!ENTITY included-domains ""   >

<!-- element declarations -->
<!ELEMENT active-low   (#PCDATA) >

<!ATTLIST active-low   
   keyref  CDATA     #IMPLIED
   %univ-atts;      
   outputclass  CDATA #IMPLIED >

<!ELEMENT instancesNumber  
  (%term.cnt;)*  > 
  
<!ATTLIST instancesNumber  
   keyref   CDATA     #IMPLIED
   %univ-atts;
   outputclass  CDATA #IMPLIED >

<!ELEMENT unitQualifier  
  (%defn.cnt;)*    > 
  
<!ATTLIST unitQualifier   
   %univ-atts;
   outputclass  CDATA #IMPLIED >
    
<!ELEMENT namePattern  
  (%defn.cnt;)*    > 
  
<!ATTLIST namePattern   
   %univ-atts;
   outputclass  CDATA #IMPLIED >
    
<!ELEMENT instanceOffsets  
  (%defn.cnt;)*    > 
<!ATTLIST instanceOffsets   
   %univ-atts;
   outputclass  CDATA #IMPLIED >    

<!--  specialization attribute declarations   -->
 <!ATTLIST active-low   %global-atts;  class CDATA "+ topic/ph sidscDomain-d/active-low ">
<!ATTLIST unitQualifier   %global-atts; class CDATA "+  topic/ph sidscDomain-d/unitQualifier ">
<!ATTLIST namePattern   %global-atts; class CDATA "+  topic/ph sidscDomain-d/namePattern ">
<!ATTLIST instancesNumber   %global-atts; class CDATA "+  topic/ph sidscDomain-d/instancesNumber ">
<!ATTLIST instanceOffsets   %global-atts; class CDATA "+  topic/ph sidscDomain-d/instanceOffsets ">
<!-- end sidscDomain.mod -->