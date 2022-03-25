<!--  
SIDSC IP Data Domain
Copyright OASIS 2009
Author: Seth Park
 
Delivered as file "ipDataDomain.mod"
-->
<!-- element name entities -->
<!ENTITY % ip-data   "ip-data"  >
<!ENTITY % ip-name "ip-name" >
<!ENTITY % ip-system-name  "ip-system-name"  >
<!ENTITY % ip-system-uid  "ip-system-uid" >
<!ENTITY % technology   "technology" >
<!ENTITY % ip-version "ip-version" >

<!-- element declarations -->
<!ELEMENT ip-data (
(%ip-name;) |
(%ip-system-name;) |
(%ip-system-uid;) |
(%technology;) |
(%ip-version;))*>

<!ATTLIST ip-data   
        %univ-atts; >

<!ELEMENT ip-name  (#PCDATA)>
<!ATTLIST ip-name   %univ-atts;>

<!ELEMENT ip-system-name   (#PCDATA)>
<!ATTLIST ip-system-name  %univ-atts;  >

<!ELEMENT ip-system-uid   (#PCDATA)>
<!ATTLIST ip-system-uid  %univ-atts;  >

<!ELEMENT technology   (#PCDATA)>
<!ATTLIST technology  %univ-atts; >

<!ELEMENT ip-version   (#PCDATA)>
<!ATTLIST ip-version  %univ-atts;  >

<!--        specialization attribute declarations   -->
<!ATTLIST ip-data   %global-atts; class CDATA "- topic/data  ipDataDomain/ip-data ">
<!ATTLIST ip-name   %global-atts; class CDATA "- topic/data  ipDataDomain/ip-name ">
<!ATTLIST ip-system-name   %global-atts; class CDATA "- topic/data ipDataDomain/ip-system-name ">
<!ATTLIST ip-system-uid  %global-atts; class CDATA "- topic/data ipDataDomain/ip-system-name ">
<!ATTLIST technology   %global-atts; class CDATA "- topic/data ipDataDomain/technology ">
<!ATTLIST ip-version   %global-atts; class CDATA "- topic/data ipDataDomain/ip-version ">
 <!-- end ipDataDomain.mod -->