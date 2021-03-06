<!--
 |  (C) Copyright IBM Corporation 2001, 2004. All Rights Reserved.
 | This file is part of the DITA package on IBM's developerWorks site.
 | See license.txt for disclaimers and permissions.
 |
 | The Darwin Information Typing Architecture (DITA) was orginated by
 | IBM's XML Workgroup and ID Workbench tools team.
 |
 | Refer to this file by the following public identfier or an appropriate
 | system identifier:
 |
 |   PUBLIC "-//IBM//ELEMENTS DITA Concept//EN"
 |
 | Release history (vrm):
 |   1.0.0 Initial release on developerWorks, March 2001 (dita00.zip)
 |   1.0.1 fix 1 on developerWorks, October 2001 (dita01.zip)
 |   1.0.2 consolidated redesign December 2001
 |   1.0.3 fix 1, dtd freeze for UCD-1 January 2002
 |   1.1.0 Release 1 March 2002 (dita10.zip)
 |   1.1.1 Release 1.1 December 2002
 |   1.1.2 Release 1.2 June 2003
 |   1.1.3 Release 1.3 March 2004: bug fixes and map updates
 |   1.1.3a bug fix: revised "DTDVersion" to match release version (consistency);
 |                   revised conbody attlist to match other infotype's body attlists (consistency)
 |
 |   1.1.3a + InfoShare Integration Added.
 *-->


<!ENTITY DTDVersion 'V1.1.3' >


<!-- ============ Specialization of declared elements ============ -->
<!ENTITY % conceptClasses SYSTEM "concept_class.ent">
<!--%conceptClasses;-->

<!ENTITY % conbody "conbody">

<!ENTITY % concept-info-types "%info-types;">
<!ENTITY % included-domains ""><!-- FC caused problems in .NET -->

<!ELEMENT concept        (%title;, (%titlealts;)?, (%shortdesc;)?, (%prolog;)?, %conbody;, (%related-links;)?, (%concept-info-types;)* )>
<!ATTLIST concept         id ID #REQUIRED
                          conref CDATA #IMPLIED
                          %select-atts;
                          outputclass CDATA #IMPLIED
                          %ish-managment-atts;
                          ishlabelxpath CDATA #FIXED "./title"
                          xml:lang NMTOKEN #IMPLIED
                          DTDVersion CDATA #FIXED "&DTDVersion;"
                          domains CDATA "%included-domains;"
><!-- FC caused problems in .NET -->

<!ELEMENT conbody        ((%body.cnt;)*, (%section;|%example;)*) >
<!ATTLIST conbody         %id-atts;
                          translate (yes|no) #IMPLIED
                          xml:lang NMTOKEN #IMPLIED
                          outputclass CDATA #IMPLIED
>


<!--specialization attributes-->

<!ATTLIST concept         %global-atts; class CDATA "- topic/topic concept/concept ">
<!ATTLIST conbody         %global-atts; class CDATA "- topic/body  concept/conbody ">




