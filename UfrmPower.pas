unit UfrmPower;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,DBTables,DB, Grids, DBGrids,ComCtrls, Buttons,
  StrUtils, DBCtrls, ADODB,inifiles, StdCtrls, ExtCtrls, Mask;

type
  TfrmPower = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    GroupBox3: TGroupBox;
    DBGrid_power: TDBGrid;
    DBGrid_js1: TDBGrid;
    GroupBox4: TGroupBox;
    DBGrid_js2: TDBGrid;
    Panel4: TPanel;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    DBGrid_zy: TDBGrid;
    DataSource_power: TDataSource;
    DataSource_js: TDataSource;
    DataSource_zy: TDataSource;
    StringGrid_jsspower: TStringGrid;
    StringGrid_zysjs: TStringGrid;
    Splitter2: TSplitter;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn11: TBitBtn;
    DBEdtJSname: TDBEdit;
    Label2: TLabel;
    ADOQuery_power: TADOQuery;
    ADOQuery_js: TADOQuery;
    ADOQuery_zy: TADOQuery;
    DBLookupComboBox1: TDBLookupComboBox;
    ADOQuery_dep: TADOQuery;
    DataSource_dep: TDataSource;
    Label6: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    BitBtn10: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    Edit1: TEdit;
    ADOConnection1: TADOConnection;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure StringGrid_zysjsSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure DBEdtJSnameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn11Click(Sender: TObject);
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure ADOQuery_jsAfterScroll(DataSet: TDataSet);
    procedure ADOQuery_zyAfterScroll(DataSet: TDataSet);
    procedure ADOQuery_powerAfterOpen(DataSet: TDataSet);
    procedure ADOQuery_jsAfterOpen(DataSet: TDataSet);
    procedure ADOQuery_zyAfterOpen(DataSet: TDataSet);
    procedure ComboBox1Change(Sender: TObject);
    procedure ADOQuery_powerAfterScroll(DataSet: TDataSet);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
  private
    { Private declarations }
    procedure update_jsspower_grid;
    procedure update_zysjs_grid;
    function GETMAXMENUBM: STRING;
    function MakeDBConn:boolean;
  public
    { Public declarations }
  end;

var frmPower: TfrmPower;

implementation

const
  CryptStr='lc';
  
var
  sel_row,sel_col:integer;
  ifNewAddMenu:boolean;

{$R *.dfm}

function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'DESCrypt.dll';//解密
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';

{ TfrmPower }
function TfrmPower.MakeDBConn:boolean;
var
  newconnstr,ss: string;
  Ini: tinifile;
  userid, password, datasource, initialcatalog: string;{, provider}
  ifIntegrated:boolean;//是否集成登录模式

  pInStr,pDeStr:Pchar;
  i:integer;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  datasource := Ini.ReadString('连接数据库', '服务器', '');
  initialcatalog := Ini.ReadString('连接数据库', '数据库', '');
  ifIntegrated:=ini.ReadBool('连接数据库','集成登录模式',false);
  userid := Ini.ReadString('连接数据库', '用户', '');
  password := Ini.ReadString('连接数据库', '口令', '107DFC967CDCFAAF');
  Ini.Free;
  //======解密password
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
  //Persist Security Info,表示ADO在数据库连接成功后是否保存密码信息
  //ADO缺省为True,ADO.net缺省为False
  //程序中会传ADOConnection信息给TADOLYQuery,故设置为True
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
    ss:='服务器'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '数据库'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '集成登录模式'+#2+'CheckListBox'+#2+#2+'0'+#2+'启用该模式,则用户及口令无需填写'+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('连接数据库','连接数据库',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

procedure clearstringgrid(aa:tstringgrid);
var
  colnum:integer;
  i:integer;
begin
  colnum:=aa.ColCount;
  for i :=0  to colnum-1 do
  begin
    aa.Cols[i].Clear;
  end;
end;

procedure TfrmPower.FormCreate(Sender: TObject);
var
  ADOQuery_Sys:tadoquery;
begin
  MakeDBConn;
  
  ADOQuery_dep.Connection:=ADOConnection1;
  ADOQuery_power.Connection:=ADOConnection1;
  ADOQuery_js.Connection:=ADOConnection1;
  ADOQuery_zy.Connection:=ADOConnection1;
  
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

  ADOQuery_dep.Close;
  ADOQuery_dep.SQL.Clear;
  ADOQuery_dep.SQL.Text:='select * from CommCode where TypeName=''部门'' ';
  ADOQuery_dep.Open;

  ADOQuery_power.Close;
  ADOQuery_power.SQL.Clear;
  ADOQuery_power.SQL.Text:='select bm as 权限编号,menuname as 权限名称 from menuitem WHERE SYSNAME='''+ComboBox1.Text+''' ';
  ADOQuery_power.Open;

  ADOQuery_js.Close;
  ADOQuery_js.SQL.Clear;
  ADOQuery_js.SQL.Text:='select id as 唯一编号,jsmc as 角色,jsqx as 权限 from ryjs';
  ADOQuery_js.Open;
  
end;

procedure TfrmPower.FormShow(Sender: TObject);
begin
  ifNewAddMenu:=false;
  
  pagecontrol1.ActivePageIndex:=0;
  update_zysjs_grid;
  update_jsspower_grid;
end;

procedure TfrmPower.update_jsspower_grid;
var
  jsqx,menu_bm:string;
  i:integer;
  adotemp11:tadoquery;
begin
   if not ADOQuery_js.Active then exit;

   clearstringgrid(StringGrid_jsspower);//清空StringGrid_jsspower

   if ADOQuery_js.RecordCount<=0 then exit;

   adotemp11:=tadoquery.Create(nil);
   adotemp11.Connection:=ADOConnection1;
   adotemp11.Close;
   adotemp11.SQL.Clear;
   adotemp11.SQL.Text:='select * from menuitem WHERE SYSNAME='''+ComboBox1.Text+''' ';
   adotemp11.Open;

    jsqx:=trim(ADOQuery_js.fieldbyname('权限').AsString);
    i:=0;
    while length(jsqx)>0 do
    begin
      menu_bm:=leftstr(jsqx,3);
      if adotemp11.Locate('bm',menu_bm,[loCaseInsensitive]) then
      begin
          StringGrid_jsspower.Cells[0,i]:=trim(adotemp11.fieldbyname('menuname').AsString);
          StringGrid_jsspower.RowHeights[i]:=17;//设置行高
          inc(i);
      end;
      delete(jsqx,1,3);
    end;

   adotemp11.Free;
end;

procedure TfrmPower.BitBtn6Click(Sender: TObject);
var
  menu_bm:string;
  existr:string;
begin
    menu_bm:=trim(DBGrid_power.DataSource.DataSet.fieldbyname('权限编号').AsString);
    existr:=trim(ADOquery_js.FieldByName('权限').AsString);
    while not (existr='') do
    begin
      if pos(menu_bm,copy(existr,1,3))>0 then
      begin
        messagedlg('该角色已有此权限！',mtinformation,[mbok],0);
        exit;
      end;
      delete(existr,1,3);
    end;
    ADOquery_js.Edit;
    ADOquery_js.FieldByName('权限').AsString:=ADOquery_js.FieldByName('权限').AsString+menu_bm;
    ADOquery_js.Post;
    update_jsspower_grid;
end;

procedure TfrmPower.update_zysjs_grid;
var
  zyqx:string;
  i:integer;
begin
   if not ADOquery_zy.Active then exit;

   clearstringgrid(StringGrid_zysjs);    //清空stringgrid

   if ADOquery_zy.RecordCount>0 then
   begin
     zyqx:=trim(ADOQuery_zy.fieldbyname('所属角色').AsString);
     i:=0;
     ADOQuery_js.First;
     while not ADOQuery_js.Eof do
     begin
        if pos('+'+trim(ADOQuery_js.FieldByName('角色').AsString)+'+',zyqx)<>0 then
        begin
          StringGrid_zysjs.Cells[0,i]:=trim(ADOQuery_js.fieldbyname('角色').AsString);
          StringGrid_zysjs.RowHeights[i]:=17;//设置行高
          inc(i);
        end;
        ADOQuery_js.next;
     end;
   end;
end;

procedure TfrmPower.BitBtn7Click(Sender: TObject);
var
  sel_qxmc:string;
  sel_qxbm:string;
  aa,cc:string;
  i:integer;
begin
  sel_qxmc:=StringGrid_jsspower.Cells[sel_col,sel_row];
  if trim(sel_qxmc)='' then exit;
  if messagedlg('确实要删除当前角色的 '+sel_qxmc+' 权限吗？',mtConfirmation,mbOKCancel,0)<>mrok then exit;
  sel_qxbm:=ADOQuery_power.Lookup('权限名称',sel_qxmc,'权限编号');
  aa:=trim(ADOQuery_js.FieldByName('权限').AsString);
  i:=0;
  while not (aa='') do
  begin
      cc:=copy(aa,1+3*i,3);
      if cc=trim(sel_qxbm) then
      begin
         delete(aa,1+3*i,3);
         break;
      end;
      inc(i);
  end;
  ADOQuery_js.Edit;
  ADOQuery_js.FieldByName('权限').AsString:=aa;
  ADOQuery_js.Post;
  update_jsspower_grid;
end;

procedure TfrmPower.BitBtn9Click(Sender: TObject);
begin
  ADOquery_js.Edit;
  ADOquery_js.Append;
  dbedtJSname.SetFocus;
end;

procedure TfrmPower.BitBtn3Click(Sender: TObject);
var
  sel_jsmc:string;
  aa:string;
begin
  sel_jsmc:=trim(StringGrid_zysjs.Cells[sel_col,sel_row]);
  if trim(sel_jsmc)='' then exit;
  if messagedlg('确实要解除当前用户的 '+sel_jsmc+' 角色吗？',mtConfirmation,mbOKCancel,0)<>mrok then exit;
  aa:=ADOQuery_zy.FieldByName('所属角色').AsString;
  aa:=StringReplace(aa,'+'+sel_jsmc+'+','',[rfIgnoreCase]);
  ADOQuery_zy.Edit;
  ADOQuery_zy.FieldByName('所属角色').AsString:=aa;
  ADOQuery_zy.Post;
  update_zysjs_grid;
end;

procedure TfrmPower.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage.Caption='人员权限分配' then update_zysjs_grid;
end;

procedure TfrmPower.BitBtn2Click(Sender: TObject);
var
  menu_bm:string;
begin
    menu_bm:=trim(DBGrid_js2.DataSource.DataSet.fieldbyname('角色').AsString);
    if pos('+'+menu_bm+'+',ADOquery_zy.FieldByName('所属角色').AsString)>0 then
    begin
      messagedlg('该职员已属于该角色！',mtinformation,[mbok],0);
      exit;
    end;
    ADOquery_zy.Edit;
    ADOquery_zy.FieldByName('所属角色').AsString:=
                    ADOquery_zy.FieldByName('所属角色').AsString+'+'+menu_bm+'+';
    ADOquery_zy.Post;
    update_zysjs_grid;
end;

procedure TfrmPower.BitBtn8Click(Sender: TObject);
var
  sel_qxbm,aa,cc:string;
  i:integer;
  adotemp11:tadoquery;
begin
  if messagedlg('确实要删除当前角色的所有权限吗？',mtConfirmation,mbOKCancel,0)<>mrok then exit;

  //======================删除当前角色的所有权限==============================//
  aa:=trim(ADOQuery_js.FieldByName('权限').AsString);

   adotemp11:=tadoquery.Create(nil);
   adotemp11.Connection:=ADOConnection1;
   adotemp11.Close;
   adotemp11.SQL.Clear;
   adotemp11.SQL.Text:='select * from menuitem WHERE SYSNAME='''+ComboBox1.Text+''' ';
   adotemp11.Open;
  
  while not adotemp11.Eof do
  begin
    sel_qxbm:=adotemp11.fieldbyname('bm').AsString;
    i:=0;
    while i<=length(aa)/3 do
    begin
        cc:=copy(aa,1+3*i,3);
        if cc=trim(sel_qxbm) then
        begin
           delete(aa,1+3*i,3);
           break;
        end;
        inc(i);
    end;
    adotemp11.Next;
  end;
  adotemp11.Free;
  
  ADOQuery_js.Edit;
  ADOQuery_js.FieldByName('权限').AsString:=aa;
  ADOQuery_js.Post;
  //==========================================================================//

  update_jsspower_grid;
end;

procedure TfrmPower.BitBtn4Click(Sender: TObject);
begin
  if messagedlg('确实要解除当前用户的所有角色吗？',mtConfirmation,mbOKCancel,0)<>mrok then exit;
  ADOQuery_zy.Edit;
  ADOQuery_zy.FieldByName('所属角色').AsString:='';
  ADOQuery_zy.Post;
  update_zysjs_grid;
end;

procedure TfrmPower.BitBtn5Click(Sender: TObject);
var
  i: Integer;
  aa,cc,sel_qxbm:string;
  adotemp11:tadoquery;
begin
  if messagedlg('确实要为当前角色添加所有权限吗？',mtConfirmation,mbOKCancel,0)<>mrok then exit;
  
  //======================删除当前角色的所有权限==============================//
  aa:=trim(ADOQuery_js.FieldByName('权限').AsString);

   adotemp11:=tadoquery.Create(nil);
   adotemp11.Connection:=ADOConnection1;
   adotemp11.Close;
   adotemp11.SQL.Clear;
   adotemp11.SQL.Text:='select * from menuitem WHERE SYSNAME='''+ComboBox1.Text+''' ';
   adotemp11.Open;
   
  while not adotemp11.Eof do
  begin
    sel_qxbm:=adotemp11.fieldbyname('bm').AsString;
    i:=0;
    while i<=length(aa)/3 do
    begin
        cc:=copy(aa,1+3*i,3);
        if cc=trim(sel_qxbm) then
        begin
           delete(aa,1+3*i,3);
           break;
        end;
        inc(i);
    end;
    adotemp11.Next;
  end;

  ADOQuery_js.Edit;
  ADOQuery_js.FieldByName('权限').AsString:=aa;
  ADOQuery_js.Post;
  //==========================================================================//

  adotemp11.First;
  while not adotemp11.Eof do
  begin
    ADOquery_js.Edit;
    ADOquery_js.FieldByName('权限').AsString:=ADOquery_js.FieldByName('权限').AsString+
                                              adotemp11.fieldbyname('bm').AsString;
    ADOquery_js.Post;
    adotemp11.Next;
  end;

  adotemp11.Free;
  
  update_jsspower_grid;
end;

procedure TfrmPower.BitBtn1Click(Sender: TObject);
var
  i: Integer;
begin
  if messagedlg('确实要为当前用户添加所有角色吗？',mtConfirmation,mbOKCancel,0)<>mrok then exit;
  //===================先删除所有的角色=======================================//
  ADOQuery_zy.Edit;
  ADOQuery_zy.FieldByName('所属角色').AsString:='';
  ADOQuery_zy.Post;
  //==========================================================================//

  DBGrid_js2.DataSource.DataSet.First;
  for i:=0 to DBGrid_js2.DataSource.DataSet.RecordCount-1 do
  begin
    ADOquery_zy.Edit;
    ADOquery_zy.FieldByName('所属角色').AsString:=ADOquery_zy.FieldByName('所属角色').AsString+
                            '+'+TRIM(DBGrid_js2.DataSource.DataSet.fieldbyname('角色').AsString)+'+';
    ADOquery_zy.Post;
    DBGrid_js2.DataSource.DataSet.Next;
  end;
  update_zysjs_grid;
end;

procedure TfrmPower.StringGrid_zysjsSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  sel_row:=arow;
  sel_col:=acol;
end;

procedure TfrmPower.DBEdtJSnameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if pos('+',tedit(sender).Text)<>0 then
  begin
      messagedlg('非法字符("+")',mtinformation,[mbok],0);
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
    except
      messagedlg('该角色已存在！',mtinformation,[mbok],0);
      ADOquery_js.Cancel;
      tedit(sender).SetFocus;
    end;
  end;
end;

procedure TfrmPower.BitBtn11Click(Sender: TObject);
begin
  if ADOQuery_js.RecordCount=0 then exit;
  if messagedlg('删除角色会删除属于该角色的用户的相应权限，确实要删除吗？',mtConfirmation,mbOKCancel,0)<>mrok then exit;
  ADOQuery_js.Edit;
  ADOQuery_js.Delete;
end;

procedure TfrmPower.DBLookupComboBox1Click(Sender: TObject);
begin
  if(trim(DBLookupComboBox1.Text)<>'') then
  begin
    ADOQuery_zy.Close;
    ADOQuery_zy.SQL.Clear;
    ADOQuery_zy.SQL.Text:='select unid as 唯一编号,id as 工号,name as 名称, '+
                          ' account_limit as 所属角色, pkdeptid as 所属部门 from worker '+
                          ' where pkdeptid=:P_pkdeptid ';
    ADOQuery_zy.Parameters.ParamByName('P_pkdeptid').Value:=
                          ADOQuery_dep.fieldbyname('unid').asinteger;
    ADOQuery_zy.Open;
  end;

  update_zysjs_grid;
end;

procedure SendKeyToControl(const VK:byte;control:Twincontrol);
BEGIN
  control.SetFocus;
  keybd_event(VK,MapVirtualKey(VK,0),0,0); //指定键被按下
END;

procedure TfrmPower.TabSheet2Show(Sender: TObject);
begin
  if DBLookupComboBox1.Text='' then
    SendKeyToControl(VK_DOWN,DBLookupComboBox1);
end;

procedure TfrmPower.ADOQuery_jsAfterScroll(DataSet: TDataSet);
begin
  update_jsspower_grid;
end;

procedure TfrmPower.ADOQuery_zyAfterScroll(DataSet: TDataSet);
begin
  update_zysjs_grid;
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

procedure TfrmPower.ADOQuery_powerAfterOpen(DataSet: TDataSet);
begin
  VisibleColumn(DBGrid_power,'唯一编号',FALSE);
  VisibleColumn(DBGrid_power,'权限编号',FALSE);
end;

procedure TfrmPower.ADOQuery_jsAfterOpen(DataSet: TDataSet);
begin
  VisibleColumn(DBGrid_js1,'唯一编号',FALSE);
  VisibleColumn(DBGrid_js1,'权限',FALSE);
  VisibleColumn(DBGrid_js2,'唯一编号',FALSE);
  VisibleColumn(DBGrid_js2,'权限',FALSE);
end;

procedure TfrmPower.ADOQuery_zyAfterOpen(DataSet: TDataSet);
begin
    VisibleColumn(DBGrid_zy,'唯一编号',false);
    VisibleColumn(DBGrid_zy,'所属角色',false);
end;

procedure TfrmPower.ComboBox1Change(Sender: TObject);
begin
  ADOQuery_power.Close;
  ADOQuery_power.SQL.Clear;
  ADOQuery_power.SQL.Text:='select bm as 权限编号,menuname as 权限名称 from menuitem WHERE SYSNAME='''+(Sender as TComboBox).Text+''' ';
  ADOQuery_power.Open;

  update_jsspower_grid;
end;

procedure TfrmPower.ADOQuery_powerAfterScroll(DataSet: TDataSet);
begin
  if ((not ADOQuery_power.Active) or (ADOQuery_power.RecordCount <= 0)) then exit;

  edit1.Text:=ADOQuery_power.fieldbyname('权限名称').AsString;
  
  ifNewAddMenu:=false;
end;

procedure TfrmPower.BitBtn10Click(Sender: TObject);
begin
  Edit1.Clear;
  Edit1.SetFocus;
  ifNewAddMenu:=true;
end;

procedure TfrmPower.BitBtn12Click(Sender: TObject);
var
  adotemp11:tadoquery;
  sqlstr,bm:string;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=ADOConnection1;
  if ifNewAddMenu then //新增
  begin
    ifNewAddMenu:=false;
    bm:=GETMAXMENUBM;
    sqlstr:='Insert into menuitem ('+
                        ' bm,menuname,SYSNAME) values ('+
                        ' :P_bm,:P_menuname,:SYSNAME) ';
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.Parameters.ParamByName('P_bm').Value:=bm;
    adotemp11.Parameters.ParamByName('P_menuname').Value:=trim(Edit1.Text);
    adotemp11.Parameters.ParamByName('SYSNAME').Value:=ComboBox1.Text;
    adotemp11.ExecSQL;
    ADOQuery_power.Close;
    ADOQuery_power.Open;
  end else //修改
  begin
    IF ADOQuery_power.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('没有记录供你修改，若要新增，请先点击"新增按钮"！');
      EXIT;
    END;
    bm:=trim(ADOQuery_power.fieldbyname('权限编号').AsString);

    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=' Update menuitem  '+
    '  set menuname=:P_menuname  '+
    '  Where    bm=:p_bm      ';
    adotemp11.Parameters.ParamByName('P_menuname').Value:=trim(Edit1.Text);
    adotemp11.Parameters.ParamByName('p_bm').Value:=bm;
    adotemp11.ExecSQL;
    ADOQuery_power.Refresh;
  end;

  ADOQuery_power.Locate('权限编号',bm,[loCaseInsensitive]) ;
  adotemp11.Free;
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

procedure TfrmPower.BitBtn13Click(Sender: TObject);
begin
  if (MessageDlg('删除该记录后任何人都将无此权限,确实要删除吗？',mtWarning,[mbYes,mbNo],0)<>mrYes) then exit;

  DBGrid_power.DataSource.DataSet.Delete;
end;

end.
