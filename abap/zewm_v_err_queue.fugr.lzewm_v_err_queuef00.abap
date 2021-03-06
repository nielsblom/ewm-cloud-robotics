*---------------------------------------------------------------------*
*    view related FORM routines
*   generation date: 05.03.2020 at 10:43:19
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZEWM_V_ERR_QUEUE................................*
FORM GET_DATA_ZEWM_V_ERR_QUEUE.
  PERFORM VIM_FILL_WHERETAB.
*.read data from database.............................................*
  REFRESH TOTAL.
  CLEAR   TOTAL.
  SELECT * FROM /SCWM/TRSRC_GRP WHERE
(VIM_WHERETAB) .
    CLEAR ZEWM_V_ERR_QUEUE .
ZEWM_V_ERR_QUEUE-MANDT =
/SCWM/TRSRC_GRP-MANDT .
ZEWM_V_ERR_QUEUE-LGNUM =
/SCWM/TRSRC_GRP-LGNUM .
ZEWM_V_ERR_QUEUE-RSRC_GRP =
/SCWM/TRSRC_GRP-RSRC_GRP .
ZEWM_V_ERR_QUEUE-ZEWM_ERROR_QUEUE =
/SCWM/TRSRC_GRP-ZEWM_ERROR_QUEUE .
<VIM_TOTAL_STRUC> = ZEWM_V_ERR_QUEUE.
    APPEND TOTAL.
  ENDSELECT.
  SORT TOTAL BY <VIM_XTOTAL_KEY>.
  <STATUS>-ALR_SORTED = 'R'.
*.check dynamic selectoptions (not in DDIC)...........................*
  IF X_HEADER-SELECTION NE SPACE.
    PERFORM CHECK_DYNAMIC_SELECT_OPTIONS.
  ELSEIF X_HEADER-DELMDTFLAG NE SPACE.
    PERFORM BUILD_MAINKEY_TAB.
  ENDIF.
  REFRESH EXTRACT.
ENDFORM.
*---------------------------------------------------------------------*
FORM DB_UPD_ZEWM_V_ERR_QUEUE .
*.process data base updates/inserts/deletes.........................*
LOOP AT TOTAL.
  CHECK <ACTION> NE ORIGINAL.
MOVE <VIM_TOTAL_STRUC> TO ZEWM_V_ERR_QUEUE.
  IF <ACTION> = UPDATE_GELOESCHT.
    <ACTION> = GELOESCHT.
  ENDIF.
  CASE <ACTION>.
   WHEN NEUER_GELOESCHT.
IF STATUS_ZEWM_V_ERR_QUEUE-ST_DELETE EQ GELOESCHT.
     READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
     IF SY-SUBRC EQ 0.
       DELETE EXTRACT INDEX SY-TABIX.
     ENDIF.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN GELOESCHT.
  SELECT SINGLE FOR UPDATE * FROM /SCWM/TRSRC_GRP WHERE
  LGNUM = ZEWM_V_ERR_QUEUE-LGNUM AND
  RSRC_GRP = ZEWM_V_ERR_QUEUE-RSRC_GRP .
    IF SY-SUBRC = 0.
    DELETE /SCWM/TRSRC_GRP .
    ENDIF.
    IF STATUS-DELETE EQ GELOESCHT.
      READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY> BINARY SEARCH.
      DELETE EXTRACT INDEX SY-TABIX.
    ENDIF.
    DELETE TOTAL.
    IF X_HEADER-DELMDTFLAG NE SPACE.
      PERFORM DELETE_FROM_MAINKEY_TAB.
    ENDIF.
   WHEN OTHERS.
  SELECT SINGLE FOR UPDATE * FROM /SCWM/TRSRC_GRP WHERE
  LGNUM = ZEWM_V_ERR_QUEUE-LGNUM AND
  RSRC_GRP = ZEWM_V_ERR_QUEUE-RSRC_GRP .
    IF SY-SUBRC <> 0.   "insert preprocessing: init WA
      CLEAR /SCWM/TRSRC_GRP.
    ENDIF.
/SCWM/TRSRC_GRP-MANDT =
ZEWM_V_ERR_QUEUE-MANDT .
/SCWM/TRSRC_GRP-LGNUM =
ZEWM_V_ERR_QUEUE-LGNUM .
/SCWM/TRSRC_GRP-RSRC_GRP =
ZEWM_V_ERR_QUEUE-RSRC_GRP .
/SCWM/TRSRC_GRP-ZEWM_ERROR_QUEUE =
ZEWM_V_ERR_QUEUE-ZEWM_ERROR_QUEUE .
    IF SY-SUBRC = 0.
    UPDATE /SCWM/TRSRC_GRP ##WARN_OK.
    ELSE.
    INSERT /SCWM/TRSRC_GRP .
    ENDIF.
    READ TABLE EXTRACT WITH KEY <VIM_XTOTAL_KEY>.
    IF SY-SUBRC EQ 0.
      <XACT> = ORIGINAL.
      MODIFY EXTRACT INDEX SY-TABIX.
    ENDIF.
    <ACTION> = ORIGINAL.
    MODIFY TOTAL.
  ENDCASE.
ENDLOOP.
CLEAR: STATUS_ZEWM_V_ERR_QUEUE-UPD_FLAG,
STATUS_ZEWM_V_ERR_QUEUE-UPD_CHECKD.
MESSAGE S018(SV).
ENDFORM.
*---------------------------------------------------------------------*
FORM READ_SINGLE_ZEWM_V_ERR_QUEUE.
  SELECT SINGLE * FROM /SCWM/TRSRC_GRP WHERE
LGNUM = ZEWM_V_ERR_QUEUE-LGNUM AND
RSRC_GRP = ZEWM_V_ERR_QUEUE-RSRC_GRP .
ZEWM_V_ERR_QUEUE-MANDT =
/SCWM/TRSRC_GRP-MANDT .
ZEWM_V_ERR_QUEUE-LGNUM =
/SCWM/TRSRC_GRP-LGNUM .
ZEWM_V_ERR_QUEUE-RSRC_GRP =
/SCWM/TRSRC_GRP-RSRC_GRP .
ZEWM_V_ERR_QUEUE-ZEWM_ERROR_QUEUE =
/SCWM/TRSRC_GRP-ZEWM_ERROR_QUEUE .
ENDFORM.
*---------------------------------------------------------------------*
FORM CORR_MAINT_ZEWM_V_ERR_QUEUE USING VALUE(CM_ACTION) RC.
  DATA: RETCODE LIKE SY-SUBRC, COUNT TYPE I, TRSP_KEYLEN TYPE SYFLENG.
  FIELD-SYMBOLS: <TAB_KEY_X> TYPE X.
  CLEAR RC.
MOVE ZEWM_V_ERR_QUEUE-LGNUM TO
/SCWM/TRSRC_GRP-LGNUM .
MOVE ZEWM_V_ERR_QUEUE-RSRC_GRP TO
/SCWM/TRSRC_GRP-RSRC_GRP .
MOVE ZEWM_V_ERR_QUEUE-MANDT TO
/SCWM/TRSRC_GRP-MANDT .
  CORR_KEYTAB             =  E071K.
  CORR_KEYTAB-OBJNAME     = '/SCWM/TRSRC_GRP'.
  IF NOT <vim_corr_keyx> IS ASSIGNED.
    ASSIGN CORR_KEYTAB-TABKEY TO <vim_corr_keyx> CASTING.
  ENDIF.
  ASSIGN /SCWM/TRSRC_GRP TO <TAB_KEY_X> CASTING.
  PERFORM VIM_GET_TRSPKEYLEN
    USING '/SCWM/TRSRC_GRP'
    CHANGING TRSP_KEYLEN.
  <VIM_CORR_KEYX>(TRSP_KEYLEN) = <TAB_KEY_X>(TRSP_KEYLEN).
  PERFORM UPDATE_CORR_KEYTAB USING CM_ACTION RETCODE.
  ADD: RETCODE TO RC, 1 TO COUNT.
  IF RC LT COUNT AND CM_ACTION NE PRUEFEN.
    CLEAR RC.
  ENDIF.

ENDFORM.
*---------------------------------------------------------------------*
