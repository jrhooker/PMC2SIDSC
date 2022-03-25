<!-- =============================================================
    DITA MathML Domain
    Defines a specialization of <foreign> that contains
    MathML markup.
    DITA 1.3
    Copyright (c) 2013 OASIS Open
============================================================= -->

<!-- ============================================================= -->
<!-- ELEMENT NAME ENTITIES -->
<!-- ============================================================= -->

<!ENTITY % mathml "mathml" >
<!ENTITY % mathmlref "mathmlref" >

<!-- included MathML document type -->
<!ENTITY % MATHML.prefixed "INCLUDE">
<!ENTITY % MATHML.prefix "m">
<!ENTITY % MathML PUBLIC "-//W3C//DTD MathML 3.0//EN" "../../mathml/dtd/mathml3.dtd">
%MathML;

<!-- ============================================================= -->
<!-- ELEMENT DECLARATIONS -->
<!-- ============================================================= -->
<!ENTITY % mathmlref.content
    "EMPTY"
>

<!ENTITY % mathmlref.attributes
    "href CDATA #IMPLIED
    keyref CDATA #IMPLIED
    type CDATA #IMPLIED
    format CDATA #IMPLIED
    scope (external |
           local |
           peer |
           -dita-use-conref-target) #IMPLIED
    %univ-atts;
    outputclass CDATA #IMPLIED
">

<!ELEMENT mathmlref %mathmlref.content; >
<!ATTLIST mathmlref %mathmlref.attributes; >

<!ENTITY % mathml.content
    "(%MATHML.pfx;math |
    %mathmlref; |
    %data; |
    %data-about;)*
">

<!ENTITY % mathml.attributes
    "%id-atts;
    %localization-atts;
    base CDATA #IMPLIED
     %base-attribute-extensions;
    outputclass CDATA #IMPLIED
">

<!ELEMENT mathml %mathml.content; >
<!ATTLIST mathml %mathml.attributes; >

<!-- ============================================================= -->
<!-- SPECIALIZATION ATTRIBUTE DECLARATIONS -->
<!-- ============================================================= -->
<!ATTLIST mathml %global-atts; class CDATA "+ topic/foreign mathml-d/mathml ">
<!ATTLIST mathmlref %global-atts; class CDATA "+ topic/xref mathml-d/mathmlref ">

<!-- ================== End MathML Domain ==================== -->