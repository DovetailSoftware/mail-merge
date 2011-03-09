''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' Product        : Mail Merge for Clarify(tm)
'
' Series         : First Choice Workflow Series(tm)
'
' Name           : mm_schema.sch
'
' Description    : Data Schema Changes for Mail Merge
'
' Author         : First Choice Software, Inc.
'                  8900 Business Park Drive
'                  Austin, TX  78759
'                  (512) 418-2905
'                  EMAIL: support@fchoice.com
'                  www.fchoice.com
'
' Platforms      : This version supports Clarify 4.0 and later
'
' Copyright (C)  2002 First Choice Software, Inc.
' All Rights Reserved.
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

This file contains changes that must be made to the Clarify Schema for MM.

Import the following objects into the Clarify database using DDCOMP or DDEDITOR.

OBJECT fc_string 3500
 SUBJECT="System"
 COMMENT="Locale-based strings for First Choice Software Customizations"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    id  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
     COMMENT="String ID"
,
    string  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
     COMMENT="Text  of the string"
,
    locale  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="Indicates the locale of the string; e.g., EN_US=US English, JA_JP=Japanese in Japan"
,
    application  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY USER_DEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
OBJECT_END;

OBJECT fc_list_hdr 3501
 SUBJECT="FC I18N"
 COMMENT="Header record for First Choice Software list object"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    title  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="Name of the list"
,
    description  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
     COMMENT="Description of the list"
,
    application  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="What is the list for?"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY USER_DEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    hdr2fc_list_level OTOP fc_list_level USER_DEFINED
     INV_REL=level2fc_list_hdr     COMMENT="Top-level of list"

  RELATIONS_END
OBJECT_END;

OBJECT fc_list_level 3502
 SUBJECT="FC I18N"
 COMMENT="One level of a First Choice Software list"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY USER_DEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    level2fc_list_elm OTM fc_list_elm USER_DEFINED
     INV_REL=elm2fc_list_level     COMMENT="Elements for this list level"
,
    level2fc_list_hdr OTOF fc_list_hdr USER_DEFINED
     INV_REL=hdr2fc_list_level     COMMENT="Relates top level to header"
,
    child2fc_list_elm OTOF fc_list_elm USER_DEFINED
     INV_REL=parent2fc_list_level     COMMENT="The element that this level was called from"

  RELATIONS_END
OBJECT_END;

OBJECT fc_list_elm 3503
 SUBJECT="FC I18N"
 COMMENT="One element in a First Choice Software list"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    rank  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
     COMMENT="The position of this element in the level"
,
    state  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
     COMMENT="The state of the element. 0 = Default. 1 = Active. 2 = Inactive"
,
    fc_use  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="Only used by the i18n list gui. Do not depend on this field having a value."
,
    fc_use2  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="Only used by the i18n list gui. Do not depend on this field having a value."
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY USER_DEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    elm2fc_list_level MTO fc_list_level USER_DEFINED
     INV_REL=level2fc_list_elm     COMMENT="Level for this element"
,
    parent2fc_list_level OTOP fc_list_level USER_DEFINED
     INV_REL=child2fc_list_elm     COMMENT="The sub-level for this element"
,
    locs2fc_list_locelm OTM fc_list_locelm USER_DEFINED
     INV_REL=locelm2fc_list_elm     COMMENT="The locale strings for this element"

  RELATIONS_END
OBJECT_END;

OBJECT fc_list_locelm 3504
 SUBJECT="FC I18N"
 COMMENT="One locale string for an element in a First Choice Software list"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    title  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="String for the locale element"
,
    locale  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
     COMMENT="Locale for the locale element"
,
    other  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=80
     COMMENT="Other string for the locale element"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY USER_DEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    locelm2fc_list_elm MTO fc_list_elm USER_DEFINED
     INV_REL=locs2fc_list_locelm     COMMENT="Element for this locale string"

  RELATIONS_END
OBJECT_END;

OBJECT fc_locale 3505
 SUBJECT="System"
 COMMENT=" "
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    locale_name  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
,
    abday  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    day  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    abmon  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    mon  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    d_t_fmt  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    d_fmt  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    t_fmt  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    am_pm  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    t_fmt_ampm  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    upper  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    lower  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    space  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    cntrl  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    punct  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    digit  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    xdigit CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    blank  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    toupper  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    tolower  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    yesexpr  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    noexpr  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
,
    int_curr_symbol  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
,
    currency_symbol  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
,
    mon_decimal_point  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
,
    mon_thousands_sep  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
,
    mon_grouping  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED COMMENT=""
,
    positive_sign  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
,
    negative_sign  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=10
,
    int_frac_digits  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    frac_digits  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    p_cs_precedes  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    p_sep_by_space  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    n_cs_precedes  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    n_sep_by_space  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    p_sign_posn  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    n_sign_posn  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    decimal_point  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
,
    thousands_sep  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=20
,
    grouping  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY USER_DEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
OBJECT_END;

OBJECT mm_profile 4260
 SUBJECT="Mail Merge"
 COMMENT="Profile of mail merge variables"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    profile_name  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=40
     COMMENT="Name of the profile"
,
    description  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
     COMMENT="Description of the profile"
,
    root_obj  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=64
     COMMENT="Base object of the profile"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
    profile2mm_var OTM mm_var USER_DEFINED
     INV_REL=var2mm_profile     COMMENT="Variables for this locale profile"
  RELATIONS_END
OBJECT_END;

OBJECT mm_var 4261
 SUBJECT="Mail Merge"
 COMMENT="A variable for a MM profile"
  FIELDS
    objid  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     MANDATORY PREDEFINED
     GEN_FIELD_ID=3
     COMMENT="Internal record number"
,
    var_name  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=40
     COMMENT="Name of the variable"
,
    var_path  CMN_DATA_TYPE="char pointer" DB_DATA_TYPE=7
     OPTIONAL USER_DEFINED
     ARRAY_SIZE=255
     COMMENT="Path of the profile"
,
    rank  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED
     COMMENT="Ordering for variables"
,
    dev  CMN_DATA_TYPE="long integer" DB_DATA_TYPE=0
     OPTIONAL USER_DEFINED ALLOW_NULL
     GEN_FIELD_ID=151
     DEFAULT="1"
     COMMENT="Row version number for mobile distribution purposes"
  FIELDS_END
  RELATIONS
     var2mm_profile MTO mm_profile USER_DEFINED
     INV_REL= profile2mm_var   COMMENT="Profile for this variable"
  RELATIONS_END
OBJECT_END;