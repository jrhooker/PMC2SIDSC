<!-- =============================================================
    DITA Equation Domain
    Defines element types that represent equations semantically,
    irrespective of the representation of the equation content.
    DITA 1.3
     Copyright (c) 2013 OASIS Open
============================================================= -->

<!-- ============================================================= -->
<!-- ELEMENT NAME ENTITIES -->
<!-- ============================================================= -->

<!ENTITY % equation-inline "equation-inline" >
<!ENTITY % equation-block "equation-block" >
<!ENTITY % equation-display "equation-display" >

<!-- ============================================================= -->
<!-- ELEMENT DECLARATIONS -->
<!-- ============================================================= -->

<!ENTITY % equation.cnt
    "(#PCDATA |
    %basic.ph; |
    %data.elements.incl; |
    %foreign.unknown.incl; |
    %image; |
    %txt.incl;)*
">

<!ENTITY % equation-inline.content
    "%equation.cnt;
">

<!ENTITY % equation-inline.attributes
    "keyref  CDATA #IMPLIED
    %univ-atts;
    outputclass  CDATA  #IMPLIED
">

<!ELEMENT equation-inline %equation-inline.content; >
<!ATTLIST equation-inline %equation-inline.attributes; >

<!ENTITY % equation-block.content
    "%equation.cnt;
">

<!ENTITY % equation-block.attributes
    "%univ-atts;
    outputclass CDATA #IMPLIED
">

<!ELEMENT equation-block %equation-block.content; >
<!ATTLIST equation-block %equation-block.attributes; >

<!ENTITY % equation-display.content
    "((%title;)?,
    (%desc;)?,
    (%figgroup; |
    %fig.cnt;)* )
">

<!ENTITY % equation-display.attributes
    "%display-atts;
     spectitle  CDATA   #IMPLIED
     %univ-atts;
     outputclass    CDATA    #IMPLIED
">

<!ELEMENT equation-display %equation-display.content; >
<!ATTLIST equation-display %equation-display.attributes; >

<!-- ============================================================= -->
<!-- SPECIALIZATION ATTRIBUTE DECLARATIONS -->
<!-- ============================================================= -->
<!ATTLIST equation-inline %global-atts; class CDATA "+ topic/ph equation-d/equation-inline ">
<!ATTLIST equation-block %global-atts; class CDATA "+ topic/p equation-d/equation-block ">
<!ATTLIST equation-display %global-atts; class CDATA "+ topic/fig equation-d/equation-display ">

<!-- ================== End Equation Domain ==================== -->