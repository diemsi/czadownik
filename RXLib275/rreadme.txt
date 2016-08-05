HHHH       H            H        HHHH       H  H
H   H  HH  H  HHH  H HH    HHH  H     HH   H  HHH H   H  HHH  H HH  HH
H   H H  H H H  H  HH   H H     HH   H  H HHH  H  H H H H  H  HH   H  H
HHHH  H  H H H  H  H    H  HH     HH H  H  H   H   HHH  H  H  H    HHH   
H      HH  H  HHHH H    H    H     H  HH   H    H  H H   HHHH H    H   
H                         HHH  HHHH       H                         HHH

 ----------------------------
-=   Patch �� RXLib 2.75.   =-
 ----------------------------
         ������ 2.1

������������� ����� ������������ � ����������� ������ RXLib 2.75.

��� ��������� ��������� �������� � ������ ������ ������������� ���� // Polaris

��� ������������� �� Delphi 3 C/S Update Pack 2 (build 5.83),
                     Delphi 4 C/S Update Pack 3 (build 5.108),
                     Delphi 5 Ent Update Pack 1 (build 6.18),
                     Delphi 6 Ent Update Pack 2 (build 6.240),
                     BCB    4 Ent (build 14.4),
                     BCB    5 Ent (build 12.34),
                     BCB    6 Ent (build 10.160).

������ (� ������� ������� ������)
~~~~~~
RxDBComb.pas
------------
TRxDBComboBox: 
1. �������� EnableValues default True.
2.(1.0) �������� Style default csDropDownList. ������ ��������� Style � 
   csSingle ��� csDropDown �������� � EnableValues = False.
3.(1.2) ��������� �������� Align.

ToolEdit.pas (������� ��� Polaris Library)
------------
1. TPopupWindow: Show ���� virtual.
2. TCustomComboEdit: FButton, FPopupVisible, FFocused, SetShowCaret, SetDirectInput ����������
�� ������ private � protected. DoChange ���� virtual.
TCustomDateEdit:
3.(1.2) ��������� �������� MinDate, MaxDate � DateAutoBetween (��������� ����������� ��� 
        ������ ���� �� �����������).
4.(1.2) SetDate ������ � protected � ������ virtual.
5.(1.3) �������� DateAutoBetween ������ ��������� MinDate � MaxDate: 
        ���� ����� MinDate ������ MaxDate, �� MinDate := MaxDate.
TCustomComboEdit: 
6.(1.2) Ctrl-Enter ��������� ������� �������.
7.(1.3) ������ ��������� �������� ������������ ������ � �� ������. (������ ����� �.1.2)
8.(1.3) Ctrl-Tab ��������� ������ ���������.
9.(1.3) ��� ����� ��� �������� ����������, ���� ������ GlyphKind � ������ Create �������.
10.(1.3) ������ ������ �������� �� 2 �����.

PickDate.pas
------------
1. TSelectDateDlg: �������� TButton �� TBitBtn.
2. ������� ����� SelectDate ��� ����������� ������� ������ ���� (��� CalendarStyle=csDialog)
� TDateEdit � TDBDateEdit �� � ������ ������, � ����� ��� � popup - ����� ����������.
3.(1.2) SelectDate: ��� Sender=nil ��������� ����� ���������� �� ��������� (�� ������).
4.(1.2) ��������� � ������, ��������� � ����������� ������� MinDate � MaxDate.

RxCConst.pas, RxCConst.r32
--------------------------
1.(1.2) ��������� ��������� �� ������� ��� TDateEdit.

RxLookup.pas
------------
TRxLookupControl: ��������
1. ��������� KeyValue - ��� ���������� �������� KeyValue ����������
�������� Null, � �� Unassigned.
2. ����� ResetField ��� ���������� ������� ���� �� Esc, ���� �� � ������ dsEdit.
3. ����� SetValue - �� ���������� ������� OnChange ��� ������������� ���������
DataField, DataSource ��� ������� ��������� �������� KeyValue.
4.(1.0) ��������� �������� EmptyStrIsNull, ������� ��������� ��� ������ EmptyValue ���������
� ���� � ���������� KeyValue �������� NULL (=True) ��� ������ ������ (=False).

TRxDBLookupCombo: ��������
5. ����� KeyPress - ����� ������������ Esc �� ������� ���� �� ���������� ���������
�������.
6. ����� KeyValueChanged - ������ �� ������������ DisplayEmpty, ���� DataField ��������
lookup-����� � ����� Null.
7.(1.0) ������ ������� ������ �������� �� ��� ������� ����� ��� ������������ ����� 
   (� ������������ �� ������������ combo-������������ Delphi).
8.(1.2) ��������� �������� Align.
9.(1.3) ������������ ��������������� � ������������ � Alignment �� DataField ��� �������� ��������.

RxCombos.pas
------------
TColorComboBox:
1. �������� ������ ColorValues �� 41. ��������� �������� AllColors - 
������������ �� ��� �����.
2. �������� ColorNames ����������� ���������� �� ������� rxcombos.r32.
3.(1.0) ColorValues �������� �� 44 ����������� �� VCLUtils.
4.(1.1) ������� ��������� � ������������ � Rx275fix.zip.
5.(1.3) ��������� ����� ������������� �����, ���� ����������� coIncludeOther � Options.
6.(1.3) ���������� ������ ������������ ������ ������ ��� ��������� Options.

rRxCombo.pas  [�������� ��� ��������� � rxcombos.rc ��� TColorComboBox]
------------
1.(1.0) ��������� 3 �����.
2.(1.1) ��������� 2 "�����" (None � Default).

RxCombos.r32
------------
1. ��������� ��������� ������� - �������� ������.
2.(1.0) ��������� 3 �����.
3.(1.1) ��������� 2 "�����" (None � Default).

ToolEdit.r32
------------
1. FEDITBMP: ����� ��������� � ������ ����.

RxCtl.dpk,RxCtl4.dpk,RxCtl5.dpk,RxCtl.bpk,RxCtl4.bpk,RxCtl5.bpk,RxCtl.cpp,RxCtl4.cpp,RxCtl5.cpp
-----------------------------------------------------------------------------------------------
1.(1.1) �������� � ������ contains ������ rrxcombo.pas.
2.(1.2) AppUtils.pas ������� �� RxAppUtils.pas. (������ rxctl5.dpk)
3.(1.4) ������� ��������� � � RxCtl.bpk,RxCtl4.bpk,RxCtl5.bpk.
4.(1.6) ��������� ����� RxCtl.cpp,RxCtl4.cpp,RxCtl5.cpp.

RxAppUtils.pas
--------------
1.(1.2) �������� ��� ������������� � ������� Borland Integrated Translation Environment.
   ���� �����, ��� � AppUtils.pas.

Speedbar.pas, rxremlog.pas, Rxlogin.pas, Rxhints.pas, rxgrids.pas, Rxgrdcpt.pas, Rxdbctrl.pas,
Pictedit.pas, Placemnt.pas, Mrulist.pas, LoginDlg.pas, Dbutils.pas, Dbsecur.pas, BdeUtils.pas, 
Appevent.pas, Icoledit.pas
---------------------------------------------------------------------------------------------
1.(1.2) (D5) AppUtils ������� �� RxAppUtils � uses. ��� ������������� � ������� Borland Integrated
Translation Environment.

RxSpin.pas
----------
1.(1.2) ��������� TRxSpinButton.ButtonStyle - �������� sbsDefault � sbsClassic (������ ��� TSpinButton �� Samples).
������� �������� ��������� '������'.
2.(1.2) �������� TRxCustomSpinEdit.
TRxCustomSpinEdit:
3.(1.2) ButtonKind - ��������� �������� bkClassic (������������� TRxSpinButton.ButtonStyle=sbsClassic).
4.(1.2) ��������� �������� Alignment � Align.
5.(1.2) �� ��������� ����. �������� ��� ������� ���� ����� ��� ������� � ������ Stop on Delphi Exceptions.
6.(1.2) TRxSpinButton - c���������� DownGlyph � UpGlyph �� ����������� � DFM-�����.
TRxCustomSpinEdit:
7.(1.3) ��������� �������� CheckMinValue � CheckMaxValue: ���� �������� �������� MinValue ����� 0 � 
CheckMinValue ����� False �� ������ ������� �� �����������. ���������� ��� MaxValue � CheckMaxValue.
8.(1.4) ��� ������� �� ������ ������ ��������� ������ �������� ������ ��������.
9.(1.4) ��������� �������� CheckOnExit.

RxSpin.r32
----------
1.(1.2) ������� ��� sbsClassic ������.

RxCtrls.pas
-----------
TRxSpeedButton:
1.(1.2) ��������� �������� FlatStandard - (True - ��� � Borland).
2.(1.2) �������� ��������� ������ ��� Flat=True.

RxCalc.pas
----------
1.(1.2) ��������� ������ sqrt, 1/x, % � PopupCalculator. ��������� ������� ������ = � +.

CurrEdit.pas
------------
1.(1.2) TRxCalcEdit, TCurrencyEdit, ��. - ��������� �������� Align.
2.(1.3) TCustomNumEdit - ButtonWidth = 21.
3.(1.4) TCustomNumEdit, TRxCalcEdit, TCurrencyEdit - ��������� �������� DecimalPlaceRound - 
��������� �� DecimalPlaces.

RxDBCtrl.pas
------------
1.(1.2) TRxDBGrid - ������ ��������� ������������ ������������� ������� ����� ������ ����� ��� ����.
2.(1.2) TDBDateEdit - ���������, ��������� � ���������� TDateEdit.
TRxDBCalcEdit:
3.(1.3) ��������� �������� EmptyIsNull.
4.(1.3) ���� �������� ���� NULL, �� ������������ �����.
5.(1.4) TRxDBCalcEdit - ��������� �������� DecimalPlaceRound �� TCustomNumEdit.
6.(2.1) �������� DecimalPlaceRound ����������� � ��� ���������� �������� ����.
TRxDBGrid:
7.(1.5) ��������� �������� AutoAppend (�������������� ���������� ������ ��� ����������� 
�� ��������� ������).
8.(1.6) ������ ����� �������� ������ ��������������� ������� ������. (����� Delphi 3)

RxResExp.pas
------------
1.(1.2) TRxProjectResExpert �� �������� ��� �������� ������� ������ ���� Resources.

LoginDlg.pas
------------
1.(1.3) ����������� �� ����� ������������� ������ ������.

RxCtl6.*, RxDB6.*, RxBDE6.*, DclRx6.*, DclRxDB6.*, DclRxBD6.*, DclRxAll6.*, RxStrUtils.pas
------------------------------------------------------------------------------------------
1.(1.5) ��������� ��� ������������� � Delphi 6.
2.(1.6) ��������� DclRxAll6.* - ����� design-time �����. ������������ Polaris Library.
3.(2.1) ��������� Rx*6.bpk, Rx*6.cpp � DclRxAll6.bpk, DclRxAll6.cpp ��� ������������� � BCB 6.

AniFile.pas, BDEUtils.pas, ClipIcon.pas, CheckItm.pas, ClipMon.pas, CurrEdit.pas, 
DataConv.pas, DateUtil.pas, DBFilter.pas, DBIndex.pas, DBUtils.pas, DualList.pas, ExcptDlg.pas, 
FileUtil.pas, GradEdit.pas, HintProp.pas, IcoLEdit.pas, MinMaxEd.pas, ObjStr.pas, PageMngr.pas, 
PgMngrEd.pas, PicClip.pas, PickDate.pas, PictEdit.pas, Placemnt.pas, PresrDsn.pas, QBndDlg.pas,
RxAppUtils.pas, RxBDEReg.pas, RxCalc.pas, RxClock.pas, RxColors.pas, RxConst.pas, RxCtlReg.pas,
RxCtrls.pas, RxDBComb.pas, RxDBCtrl.pas, RxDBReg.pas, RxDice.pas, RxDsgn.pas, RxGIF.pas, 
RxGrids.pas, RxHook.pas, RxIni.pas, RxLookup.pas, RxMemDS.pas, RxMenus.pas, RxProps.pas, 
RxQuery.pas, RxResExp.pas, RXShell.pas, RxSpin.pas, RxTimer.pas, RxTooReg.pas, SBEdit.pas, 
SelDSFrm.pas, SpeedBar.pas, StrHlder.pas, StrLEdit.pas, TimerLst.pas, TImLstEd.pas, ToolEdit.pas,
VCLUtils.pas
------------------------------------------------------------------------------------
1.(1.5) ���������� ��� ������������� � Delphi 6:
  - � uses StrUtils ������� �� RxStrUtils (������ ��� Delphi6 � ����);
  - � uses ��������� Variants, RTLConsts;
  - � uses DsgnIntf ������� �� DesignIntf, DesignEditors;
  - IFormDesigner ������� �� IDesigner;
  - ��������� ��������� �������;
  - ��������� ����� ��� Warnings, ��������� � ���������� Delphi ���������� �������� �
    ���������� ��������� ������� � ������� �� ������ ������ � ������.
2.(1.6) ���������� warnings ��� Delphi 6.
3.(1.6) ���������� ��� ������������� � Delphi 6: ClipIcon.pas, DataConv.pas, DBIndex.pas,
  DualList.pas, PageMngr.pas, QBndDlg.pas, RxHook.pas, RxShell.pas, RxTimer.pas.

RxVerInf.pas, *5.bpk, *5.cpp
----------------------------
1.(2.0) ��������� ����� �� ����������� fix, �� �������� ����� � ��� ����.

Rx.inc
------
1.(2.0) ��������� ����� RX_D6. �� ���� ������ VER140 �������� �� RX_D6.

*.dof
-----
1.(2.0) ��� ���������� dcu � <RxLib>\dcu\XX ��������� UnitOutputDir.

����� ���������
---------------
1.(2.0) ������ ����� ������� �� ��������� ����� RxLib.
2.(2.0) readme*.txt ������������� � rreadme*.txt.
3.(2.0) �������� units\old\StrUtils.pas ��� �������� ������������� � Delphi 3-5 �
����������� ���������� ������� ���� ������ �� ������ �����.


���������
~~~~~~~~~
1. �������� ��� ����� �� ������ � �����, ���� �� ���������� RxLib.
2. ��������� ����� � RX.INC.
3. ��� BCB, Delphi 4-6 �������� � Environment Options - Library Path ���� <RxLibDir>\dcu\<������>.
   ��������, ��� Delphi 5 - <RxLibDir>\dcu\d5.
4. ��� BCB 4-5, Delphi 3-5 �������� � Environment Options - Library Path ���� <RxLibDir>\units\old.
5. ��� ������������� � Delphi 6 ������� ����� strutils.* �� ����� <RxLibDir>\units.
6. ����������������� (Build ��� Compile) rx* ������, dclrx* ������ ����������������� (Install):
     Delphi3: rxctl, rxdb, dclrxctl, dclrxdb.
     Delphi4: rxctl4, rxdb4, dclrx4, dclrxdb4.
     Delphi5: rxctl5, rxdb5, rxbde5, dclrx5, dclrxdb5, dclrxbd5.
     Delphi6: rxctl6, rxdb6, rxbde6, dclrx6, dclrxdb6, dclrxbd6 (��� ������ dclrxall6 ������ dcl*6).
     BCB4   : rxctl4, rxdb4, dclrx4, dclrxdb4.
     BCB5   : rxctl5, rxdb5, rxbde5, dclrx5, dclrxdb5, dclrxbd5.
     BCB6   : rxctl6, rxdb6, rxbde6, dclrxall6.


29.04.02

������� �� ��������,

���������, ������
                                        �������������
Polaris Software 			Bergamot
http://polesoft.da.ru                   http://come.to/bergamot
polesoft@mail.ru			bergamot@chat.ru