unit UfrmPower;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms,
  Dialogs, DB, Buttons,
  StrUtils, DBCtrls, ADODB,inifiles, StdCtrls, ExtCtrls, CheckLst,
  Menus, Mask, Controls, Grids, DBGrids, ComCtrls;

type
  TfrmPower = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    GroupBox3: TGroupBox;
    DBGrid_js1: TDBGrid;
    GroupBox6: TGroupBox;
    DBGrid_zy: TDBGrid;
    DataSource_js: TDataSource;
    DataSource_zy: TDataSource;
    ADOQuery_js: TADOQuery;
    ADOQuery_zy: TADOQuery;
    ADOQuery_dep: TADOQuery;
    DataSource_dep: TDataSource;
    Label4: TLabel;
    ComboBox1: TComboBox;
    ADOConnection1: TADOConnection;
    Panel5: TPanel;
    Label2: TLabel;
    BitBtn9: TBitBtn;
    DBEdtJSname: TDBEdit;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    CheckListBox2: TCheckListBox;
    GroupBox2: TGroupBox;
    DBLookupComboBox1: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    CheckListBox1: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure DBEdtJSnameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure ADOQuery_jsAfterScroll(DataSet: TDataSet);
    procedure ADOQuery_zyAfterScroll(DataSet: TDataSet);
    procedure ADOQuery_jsAfterOpen(DataSet: TDataSet);
    procedure ADOQuery_zyAfterOpen(DataSet: TDataSet);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure CheckListBox2ClickCheck(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    function GETMAXMENUBM: STRING;
    function MakeDBConn:boolean;
    procedure MakeCombinChecklistbox;
    procedure MakeCombinChecklistbox_JS;
    procedure CheckTheListBox;//���ݵ�ǰ��ɫ��Ȩ����checklistbox1�д�
    procedure CheckTheListBox_JS;//���ݵ�ǰ�û��Ľ�ɫ��checklistbox2�д�
  public
    { Public declarations }
  end;

var frmPower: TfrmPower;

implementation

const
  CryptStr='lc'; 

{$R *.dfm}

function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'DESCrypt.dll';//����
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';

{ TfrmPower }
function TfrmPower.MakeDBConn:boolean;
var
  newconnstr,ss: string;
  Ini: tinifile;
  userid, password, datasource, initialcatalog: string;{, provider}
  ifIntegrated:boolean;//�Ƿ񼯳ɵ�¼ģʽ

  pInStr,pDeStr:Pchar;
  i:integer;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  datasource := Ini.ReadString('�������ݿ�', '������', '');
  initialcatalog := Ini.ReadString('�������ݿ�', '���ݿ�', '');
  ifIntegrated:=ini.ReadBool('�������ݿ�','���ɵ�¼ģʽ',false);
  userid := Ini.ReadString('�������ݿ�', '�û�', '');
  password := Ini.ReadString('�������ݿ�', '����', '107DFC967CDCFAAF');
  Ini.Free;
  //======����password
  pInStr:=pchar(password);
  pDeStr:=DeCryptStr(pInStr,CryptStr);
  setlength(password,length(pDeStr));
  for i :=1  to length(pDeStr) do password[i]:=pDeStr[i-1];
  //==========

  newconnstr :='';
  newconnstr := newconnstr + 'user id=' + UserID + ';';
  newconnstr := newconnstr + 'password=' + Password + ';';
  newconnstr := newconnstr + 'data source=' + datasource + ';';
  newconnstr := newconnstr + 'Initial Catalog=' + initialcatalog + ';';
  newconnstr := newconnstr + 'provider=' + 'SQLOLEDB.1' + ';';
  //Persist Security Info,��ʾADO�����ݿ����ӳɹ����Ƿ񱣴�������Ϣ
  //ADOȱʡΪTrue,ADO.netȱʡΪFalse
  //�����лᴫADOConnection��Ϣ��TADOLYQuery,������ΪTrue
  newconnstr := newconnstr + 'Persist Security Info=True;';
  if ifIntegrated then
    newconnstr := newconnstr + 'Integrated Security=SSPI;';
  try
    ADOConnection1.Connected := false;
    ADOConnection1.ConnectionString := newconnstr;
    ADOConnection1.Connected := true;
    result:=true;
  except
  end;
  if not result then
  begin
    ss:='������'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '���ݿ�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '���ɵ�¼ģʽ'+#2+'CheckListBox'+#2+#2+'0'+#2+'���ø�ģʽ,���û�������������д'+#2+#3+
        '�û�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '����'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('�������ݿ�','�������ݿ�',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

procedure TfrmPower.FormCreate(Sender: TObject);
begin
  MakeDBConn;
  
  ADOQuery_dep.Connection:=ADOConnection1;
  ADOQuery_js.Connection:=ADOConnection1;
  ADOQuery_zy.Connection:=ADOConnection1;
end;

procedure TfrmPower.FormShow(Sender: TObject);
var
  ADOQuery_Sys:tadoquery;
  ConfigIni:tinifile;
  selSysName:integer;
begin
  pagecontrol1.ActivePageIndex:=0;

  //����ϵͳ����begin
  ADOQuery_Sys:=tadoquery.Create(nil);
  ADOQuery_Sys.Connection:=ADOConnection1;
  ADOQuery_Sys.Close;
  ADOQuery_Sys.SQL.Clear;
  ADOQuery_Sys.SQL.Text:='select Distinct sysname from menuitem';
  ADOQuery_Sys.Open;
  ComboBox1.Items.Clear;
  while not ADOQuery_Sys.Eof do
  begin
    ComboBox1.Items.Add(ADOQuery_Sys.fieldbyname('sysname').AsString);
    ADOQuery_Sys.Next;
  end;
  ADOQuery_Sys.Free;

  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  selSysName:=configini.ReadInteger('Interface','selSysName',0);{��¼ѡ���ϵͳ����}
  configini.Free;

  ComboBox1.ItemIndex:=selSysName;
  //����ϵͳ����end

  MakeCombinChecklistbox;//����Ȩ�޹�ѡ�б�
  
  ADOQuery_dep.Close;
  ADOQuery_dep.SQL.Clear;
  ADOQuery_dep.SQL.Text:='select * from CommCode where TypeName=''����'' ';
  ADOQuery_dep.Open;

  ADOQuery_js.Close;
  ADOQuery_js.SQL.Clear;
  ADOQuery_js.SQL.Text:='select id as Ψһ���,jsmc as ��ɫ,jsqx as Ȩ�� from ryjs';
  ADOQuery_js.Open;

  MakeCombinChecklistbox_JS;//���ؽ�ɫ��ѡ�б�
end;

procedure TfrmPower.DBLookupComboBox1Click(Sender: TObject);
begin
  if trim(DBLookupComboBox1.Text)='' then exit;

    ADOQuery_zy.Close;
    ADOQuery_zy.SQL.Clear;
    ADOQuery_zy.SQL.Text:='select unid as Ψһ���,id as ����,name as ����, '+
                          ' account_limit as ������ɫ, pkdeptid as �������� from worker '+
                          ' where pkdeptid=:P_pkdeptid ';
    ADOQuery_zy.Parameters.ParamByName('P_pkdeptid').Value:=ADOQuery_dep.fieldbyname('unid').asinteger;
    ADOQuery_zy.Open;
end;

procedure SendKeyToControl(const VK:byte;control:Twincontrol);
BEGIN
  control.SetFocus;
  keybd_event(VK,MapVirtualKey(VK,0),0,0); //ָ����������
END;

procedure TfrmPower.TabSheet2Show(Sender: TObject);
begin
  if DBLookupComboBox1.Text='' then SendKeyToControl(VK_DOWN,DBLookupComboBox1);
end;

procedure TfrmPower.ADOQuery_jsAfterScroll(DataSet: TDataSet);
begin
  CheckTheListBox;
end;

procedure TfrmPower.ADOQuery_zyAfterScroll(DataSet: TDataSet);
begin
  CheckTheListBox_JS;
end;

procedure VisibleColumn(dbgrid:tdbgrid;const DisplayName:string;const ifVisible:boolean);
var
  i:integer;
begin
  if not dbgrid.DataSource.DataSet.Active then exit;
  for i :=0  to dbgrid.Columns.Count-1 do
    if uppercase(dbgrid.Fields[i].DisplayName)=uppercase(DisplayName) then
      dbgrid.Columns[i].Visible:=ifVisible;
end;

procedure TfrmPower.ADOQuery_jsAfterOpen(DataSet: TDataSet);
begin
  VisibleColumn(DBGrid_js1,'Ψһ���',FALSE);
  VisibleColumn(DBGrid_js1,'Ȩ��',FALSE);
end;

procedure TfrmPower.ADOQuery_zyAfterOpen(DataSet: TDataSet);
begin
    VisibleColumn(DBGrid_zy,'Ψһ���',false);
    VisibleColumn(DBGrid_zy,'������ɫ',false);
    VisibleColumn(DBGrid_zy,'��������',false);
end;

procedure TfrmPower.ComboBox1Change(Sender: TObject);
begin
  MakeCombinChecklistbox;
  CheckTheListBox;
end;

function TfrmPower.GETMAXMENUBM: STRING;
var
  MAXMENUBM: string;
  adotemp11:tadoquery;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=ADOConnection1;
  ADOtemp11.Close;
  ADOtemp11.SQL.Clear;
  ADOtemp11.SQL.Text:='select max(BM) as MAXMENUBM from menuitem ';
  ADOtemp11.open;
  if (adotemp11.RecordCount=0) or (trim(ADOtemp11.FieldByName('MAXMENUBM').AsString)='') then
  begin
    result :='001';
    ADOtemp11.Free;
    exit;
  end;
  MAXMENUBM := ADOtemp11.FieldByName('MAXMENUBM').AsString;
  ADOtemp11.Free;
  MAXMENUBM:=rightstr('000'+inttostr(strtoint(MAXMENUBM)+1),3);
  result := MAXMENUBM;
end;

procedure TfrmPower.MakeCombinChecklistbox;
var
  adotemp3:tadoquery;
begin
     CheckListBox1.Items.Clear;

     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:='select bm,menuname from menuitem WHERE SYSNAME='''+ComboBox1.Text+''' ';
     adotemp3.Open;
     while not adotemp3.Eof do
     begin
      CheckListBox1.Items.Add(trim(adotemp3.fieldbyname('bm').AsString)+'   '+adotemp3.fieldbyname('menuname').AsString);

      adotemp3.Next;
     end;
     adotemp3.Free;
end;

procedure TfrmPower.CheckTheListBox;
var
  i:integer;
  b:integer;
  ss,sss,jsqx,menu_bm:string;
begin
   if not ADOQuery_js.Active then exit;
   if ADOQuery_js.RecordCount<=0 then exit;

    for i:=0 to CheckListBox1.Items.Count-1 do CheckListBox1.Checked[i]:=false;

    jsqx:=trim(ADOQuery_js.fieldbyname('Ȩ��').AsString);

    while length(jsqx)>0 do
    begin
      menu_bm:=leftstr(jsqx,3);
      for i:=0 to CheckListBox1.Items.Count-1 do
      begin
        ss:=CheckListBox1.Items.Strings[i];
        b:=pos('   ',ss);
        sss:=copy(ss,1,b-1);
        if trim(menu_bm)=trim(sss) then
        begin
          CheckListBox1.Checked[i]:=true;
          break;
        end;
      end;
      delete(jsqx,1,3);
    end;
end;

procedure TfrmPower.CheckListBox1ClickCheck(Sender: TObject);
var
  i,b,j,m:integer;
  menu_bm,existr,aa,cc:string;
begin
  i:=(Sender as TCheckListBox).ItemIndex;

  if (not ADOQuery_js.Active) or (ADOQuery_js.RecordCount <= 0) then
  begin
    Application.MessageBox('����ѡ���ɫ', '��ʾ��Ϣ',MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
    (Sender as TCheckListBox).Checked[i]:=false;
    exit;
  end;

  menu_bm:=(Sender as TCheckListBox).Items.Strings[i];
  b:=pos('   ',menu_bm);
  menu_bm:=copy(menu_bm,1,b-1);

  if (Sender as TCheckListBox).Checked[i] then
  begin
    existr:=trim(ADOquery_js.FieldByName('Ȩ��').AsString);
    while not (existr='') do
    begin
      if pos(menu_bm,copy(existr,1,3))>0 then
      begin
        messagedlg('�ý�ɫ���д�Ȩ�ޣ�',mtinformation,[mbok],0);
        exit;
      end;
      delete(existr,1,3);
    end;
    ADOquery_js.Edit;
    ADOquery_js.FieldByName('Ȩ��').AsString:=ADOquery_js.FieldByName('Ȩ��').AsString+menu_bm;
    ADOquery_js.Post;
  end else
  begin
    aa:=trim(ADOQuery_js.FieldByName('Ȩ��').AsString);
    i:=0;
    while not (aa='') do
    begin
        cc:=copy(aa,1+3*i,3);
        if cc=trim(menu_bm) then
        begin
           delete(aa,1+3*i,3);
           break;
        end;
        inc(i);
    end;
    ADOQuery_js.Edit;
    ADOQuery_js.FieldByName('Ȩ��').AsString:=aa;
    ADOQuery_js.Post;

    //ȫ��δѡ��,����ֶ�����begin
    m:=0;
    for j:=0 to (Sender as TCheckListBox).Items.Count-1 do
    begin
      if (Sender as TCheckListBox).Checked[j] then
      begin
        inc(m);
        break;
      end;
    end;
    if m=0 then
    begin
      ADOQuery_js.Edit;
      ADOQuery_js.FieldByName('Ȩ��').AsString:='';
      ADOQuery_js.Post;
    end;
    //ȫ��δѡ��,����ֶ�����end
  end;
end;

procedure TfrmPower.N2Click(Sender: TObject);
VAR
  i:integer;
  s2:string;
  b:integer;
  CheckListBox:TCheckListBox;
  adotemp11:tadoquery;
  sTypeName:string;
begin
  if not (((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent is TCheckListBox) then
  begin
    MESSAGEDLG('�����쳣,����ϵ���������!',mtError,[MBOK],0);
    exit;
  end;
  
  CheckListBox:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TCheckListBox;

  if CheckListBox.Items.Count<=0 then exit;
  
  i:=CheckListBox.ItemIndex;
  if i<0 then
  begin
    MESSAGEDLG('��ѡ��Ҫ�޸ĵ�Ȩ��!',mtWarning,[MBOK],0);
    exit;
  end;

  s2:=CheckListBox.Items.Strings[i];
  b:=pos('   ',s2);
  sTypeName:=TRIM(COPY(S2,b+3,MAXINT));
  s2:=copy(s2,1,b-1);

  if not InputQuery('�޸�Ȩ��','���޸ĸ�Ȩ������',sTypeName) then exit;
  sTypeName:=trim(sTypeName);

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update menuitem  '+
    '  set menuname=:P_menuname  '+
    '  Where    bm=:p_bm      ';
    adotemp11.Parameters.ParamByName('P_menuname').Value:=sTypeName;
    adotemp11.Parameters.ParamByName('p_bm').Value:=s2;
    adotemp11.ExecSQL;
    adotemp11.Free;

        //=============����������������ĿCheckListBox=======================//
        MakeCombinChecklistbox;
        CheckTheListBox;
        //====================================================================//
end;

procedure TfrmPower.CheckTheListBox_JS;
var
  i:integer;
  ss:string;
  zyqx:STRING;
begin
   if not ADOquery_zy.Active then exit;
   if ADOquery_zy.RecordCount<=0 then exit;

   for i:=0 to CheckListBox2.Items.Count-1 do CheckListBox2.Checked[i]:=false;

     zyqx:=trim(ADOQuery_zy.fieldbyname('������ɫ').AsString);

      for i:=0 to CheckListBox2.Items.Count-1 do
      begin
        ss:=CheckListBox2.Items.Strings[i];
        if pos('+'+trim(ss)+'+',trim(zyqx))>0 then
        begin
          CheckListBox2.Checked[i]:=true;
          continue;
        end;
      end;
end;

procedure TfrmPower.MakeCombinChecklistbox_JS;
var
  adotemp3:tadoquery;
begin
     CheckListBox2.Items.Clear;

     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:='select id,jsmc from ryjs';
     adotemp3.Open;
     while not adotemp3.Eof do
     begin
      CheckListBox2.Items.Add(adotemp3.fieldbyname('jsmc').AsString);

      adotemp3.Next;
     end;
     adotemp3.Free;
end;

procedure TfrmPower.CheckListBox2ClickCheck(Sender: TObject);
var
  i,m,j:integer;
  aa,jsmc:string;
begin
  i:=(Sender as TCheckListBox).ItemIndex;

  if (not ADOQuery_zy.Active) or (ADOQuery_zy.RecordCount <= 0) then
  begin
    Application.MessageBox('����ѡ���û�', '��ʾ��Ϣ',MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
    (Sender as TCheckListBox).Checked[i]:=false;
    exit;
  end;

  jsmc:=trim((Sender as TCheckListBox).Items.Strings[i]);

  if (Sender as TCheckListBox).Checked[i] then
  begin
    if pos('+'+jsmc+'+',ADOquery_zy.FieldByName('������ɫ').AsString)>0 then
    begin
      messagedlg('��ְԱ�����ڸý�ɫ��',mtinformation,[mbok],0);
      exit;
    end;
    ADOquery_zy.Edit;
    ADOquery_zy.FieldByName('������ɫ').AsString:=ADOquery_zy.FieldByName('������ɫ').AsString+'+'+jsmc+'+';
    ADOquery_zy.Post;
  end else
  begin
    if jsmc='' then exit;
    aa:=ADOQuery_zy.FieldByName('������ɫ').AsString;
    aa:=StringReplace(aa,'+'+jsmc+'+','',[rfIgnoreCase]);
    ADOQuery_zy.Edit;
    ADOQuery_zy.FieldByName('������ɫ').AsString:=aa;
    ADOQuery_zy.Post;

    //ȫ��δѡ��,����ֶ�����begin
    m:=0;
    for j:=0 to (Sender as TCheckListBox).Items.Count-1 do
    begin
      if (Sender as TCheckListBox).Checked[j] then
      begin
        inc(m);
        break;
      end;
    end;
    if m=0 then
    begin
      ADOQuery_zy.Edit;
      ADOQuery_zy.FieldByName('������ɫ').AsString:='';
      ADOQuery_zy.Post;
    end;
    //ȫ��δѡ��,����ֶ�����end
  end;
end;

procedure TfrmPower.BitBtn9Click(Sender: TObject);
begin
  if not ADOQuery_js.Active then exit;

  ADOquery_js.Edit;
  ADOquery_js.Append;
  dbedtJSname.SetFocus;
end;

procedure TfrmPower.BitBtn1Click(Sender: TObject);
begin
  if not ADOQuery_js.Active then exit;
  if ADOQuery_js.RecordCount<=0 then exit;

  if messagedlg('ɾ����ɫ��ɾ�����ڸý�ɫ���û�����ӦȨ�ޣ�ȷʵҪɾ����',mtConfirmation,mbOKCancel,0)<>mrok then exit;
  
  ADOQuery_js.Edit;
  ADOQuery_js.Delete;

  MakeCombinChecklistbox_JS;
  CheckTheListBox_JS;
end;

procedure TfrmPower.DBEdtJSnameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not ADOQuery_js.Active then exit;
  if ADOQuery_js.RecordCount<=0 then exit;

  if pos('+',tedit(sender).Text)<>0 then
  begin
    messagedlg('�Ƿ��ַ�("+")',mtinformation,[mbok],0);
    ADOquery_js.Cancel;
    tedit(sender).SetFocus;
    exit;
  end;

  if key=13 then
  begin
    if trim(tedit(sender).text)='' then exit;
    try
      ADOquery_js.Edit;
      ADOquery_js.Post;

      MakeCombinChecklistbox_JS;
      CheckTheListBox_JS;
    except
      messagedlg('�ý�ɫ�Ѵ��ڣ�',mtinformation,[mbok],0);
      ADOquery_js.Cancel;
      tedit(sender).SetFocus;
    end;
  end;
end;

procedure TfrmPower.N3Click(Sender: TObject);
VAR
  i:integer;
  s2:string;
  b:integer;
  CheckListBox:TCheckListBox;
  adotemp11:tadoquery;
begin
  if not (((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent is TCheckListBox) then
  begin
    MESSAGEDLG('�����쳣,����ϵ���������!',mtError,[MBOK],0);
    exit;
  end;
  
  CheckListBox:=((Sender as TMenuItem).GetParentMenu as TPopupMenu).PopupComponent as TCheckListBox;

  if CheckListBox.Items.Count<=0 then exit;
  
  i:=CheckListBox.ItemIndex;
  if i<0 then
  begin
    MESSAGEDLG('��ѡ��Ҫɾ����Ȩ��!',mtWarning,[MBOK],0);
    exit;
  end;

  if (MessageDlg('ɾ���ü�¼���κ��˶����޴�Ȩ��,ȷʵҪɾ����',mtWarning,[mbYes,mbNo],0)<>mrYes) then exit;

  s2:=CheckListBox.Items.Strings[i];
  b:=pos('   ',s2);
  s2:=copy(s2,1,b-1);

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' DELETE FROM menuitem  '+
    '  Where    bm=:p_bm';
    adotemp11.Parameters.ParamByName('p_bm').Value:=s2;
    adotemp11.ExecSQL;
    adotemp11.Free;

        //=============����������������ĿCheckListBox=======================//
        MakeCombinChecklistbox;
        CheckTheListBox;
        //====================================================================//
end;

procedure TfrmPower.N1Click(Sender: TObject);
VAR
  bm:string;
  adotemp11:tadoquery;
  sTypeName:string;
begin
  if not InputQuery('����Ȩ��','��������Ȩ������',sTypeName) then exit;
  sTypeName:=trim(sTypeName);

    bm:=GETMAXMENUBM;
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:='Insert into menuitem ('+
                        ' bm,menuname,SYSNAME) values ('+
                        ' :P_bm,:P_menuname,:SYSNAME) ';
    adotemp11.Parameters.ParamByName('P_bm').Value:=bm;
    adotemp11.Parameters.ParamByName('P_menuname').Value:=sTypeName;
    adotemp11.Parameters.ParamByName('SYSNAME').Value:=ComboBox1.Text;
    adotemp11.ExecSQL;
    adotemp11.Free;

        //=============����������������ĿCheckListBox=======================//
        MakeCombinChecklistbox;
        CheckTheListBox;
        //====================================================================//
end;

procedure TfrmPower.FormDestroy(Sender: TObject);
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  configini.WriteInteger('Interface','selSysName',ComboBox1.ItemIndex);{��¼ѡ���ϵͳ����}

  configini.Free;
end;

end.
