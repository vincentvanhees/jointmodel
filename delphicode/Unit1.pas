unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, ExtCtrls, Menus, Grids, DBCtrls;

type
  TPointR = record
  x, y, h, a, b, c: double;
  end;
  CCarr = array[1..10]of TPointR;
  CVarr = array[1..10]of TPointR;
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Bestand1: TMenuItem;
    Afsluiten1: TMenuItem;
    Panel1: TPanel;
    Label8: TLabel;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    SpinEdit2: TSpinEdit;
    Label3: TLabel;
    SpinEdit3: TSpinEdit;
    Label10: TLabel;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    SpinEdit7: TSpinEdit;
    SpinEdit9: TSpinEdit;
    Label9: TLabel;
    Panel2: TPanel;
    PaintBox1: TPaintBox;
    INfo1: TMenuItem;
    Edit2: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    procedure PaintBox1Paint(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Afsluiten1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.PaintBox1Paint(Sender: TObject);
var
//variabele van concaafspiraal
  r: integer;         {straal van de cirkel}
  ah: double;        {afwikkelhoek}
  al: double;        {afwikkellengte}
  om1: double;        {omtrek: van begin spiraal tot korste al}
  om2: double;        {omtrek: van begin spiraal tot langste al}
  stap: double;      {de omtrek tussen twee maatstreepjes}
  midden: TPoint;     {midden van de paintbox en cilinder}
  cilinderp: TPoint;  {punt op cilinder met straal r}
  spiraalp: TPoint;   {punt op de evolute}
  ah1: double;        {kortste ah => berekent mbv al1}
  ah2: double;       {grootste ah => berekent mbv al2}
  al1: integer;       {korste al = invoer}
  al2: integer;       {grootste al = invoer}
  k: integer;         {het aantal streepjes}
  L: double;         {omtrek van maatstreepje 0 tot maatsreepje k}
  CC: CCarr;
  CV: CVarr;
  SH: double;             //Starthoek van spiraal
  TR: integer;           //translatie-x
  TY: integer;           //translatie-y
  Deltahoek: double;     //Helling cc -cv
  DeltaTR: double;       //verschil in positie
  DeltaTY: double;       //verschil in positie
  Stand: integer;      //Stand van gewricht
  SHG: integer;
  NuHoek: double;
  Nustand: integer;
  p1: TPoint;
  p2: TPoint;
  p3: TPoint;
  p4: TPoint;
  pdraai: TPoint;
  p5:TPoint;
  p6:TPoint;
//Botstuk Concaaf
begin
  r:=Spinedit1.value;
  al1:=Spinedit2.value;
  al2:=Spinedit3.value;
  ah1:=al1/r;
  midden.x:=round(0.5*Paintbox1.width);
  midden.y:=round(0.5*Paintbox1.height);
  om1:=0.5*sqr(al1)/r;
  om2:=0.5*sqr(al2)/r;
  stap:=(om2-om1)/(9);
//Het begin van het gewrichtsvlak opzoeken
  cilinderp.x:=midden.x+round(r*cos(ah1));
  cilinderp.y:=midden.y+round(r*sin(ah1));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1));
  k:=1;
  while k<=10 do
  begin
    {De omtrek van beginpunt van gewrichtsvlak tot het desbetreffende maatstreepje}
    L:=(k-1)*stap;
    {ah uitrekenen sqr(ah)=((om1+L)/(0,5*r)}
    ah:=sqrt((L+om1)/(0.5*r));
    //al=r*ah dus in radialen:
    al:=r*ah;
    {Punten op de spiraal berekenen}
    cilinderp.x:=midden.x+round(r*cos(ah));
    cilinderp.y:=midden.y+round(r*sin(ah));
    spiraalp.x:=cilinderp.x+round(al*sin(ah));
    spiraalp.y:=cilinderp.y-round(al*cos(ah));
    //Maatstreepjes tekenen
    Form1.Paintbox1.Canvas.Pen.Color:=clred;
    Paintbox1.Canvas.MoveTo(Spiraalp.x,Spiraalp.y);
    Paintbox1.Canvas.LineTo(Spiraalp.x+round(10*sin(ah)),
                            Spiraalp.y-round(10*cos(ah)));
    Form1.Paintbox1.Canvas.Pen.Color:=clBlack;
    CC[k].x:=Spiraalp.x;
    CC[k].y:=Spiraalp.y;
    CC[k].h:=ah;
    k:=k+1;
  end;
//Het begin van het gewrichtsvlak opzoeken
  cilinderp.x:=midden.x+round(r*cos(ah1));
  cilinderp.y:=midden.y+round(r*sin(ah1));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1));
  Paintbox1.Canvas.MoveTo(Spiraalp.x,Spiraalp.y);
//Een loop om spiraal te tekenen.
  al2:=Spinedit3.value;
  ah2:=al2/r;
  ah:=ah1;
  while ah<=ah2 do
  begin
    ah:=ah+0.01;
    al:=r*ah;
    cilinderp.x:=midden.x+round(r*cos(ah));
    cilinderp.y:=midden.y+round(r*sin(ah));
    spiraalp.x:=cilinderp.x+round(al*sin(ah));
    spiraalp.y:=cilinderp.y-round(al*cos(ah));
    Paintbox1.Canvas.LineTo(spiraalp.x,spiraalp.y);
  end;
  cilinderp.x:=midden.x+round(r*cos(ah2));
  cilinderp.y:=midden.y+round(r*sin(ah2));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah2));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah2));
  Paintbox1.Canvas.MoveTo(Spiraalp.x,Spiraalp.y);
//centrodes tekenen
  cilinderp.x:=midden.x+round(r*cos(ah1));
  cilinderp.y:=midden.y+round(r*sin(ah1));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1));
  Paintbox1.Canvas.MoveTo(Cilinderp.x,Cilinderp.y);
  al2:=Spinedit3.value;
  ah2:=al2/r;
  ah:=ah1;
  while ah<=ah2 do
  begin
    ah:=ah+0.01;
    al:=r*ah;
    cilinderp.x:=midden.x+round(r*cos(ah));
    cilinderp.y:=midden.y+round(r*sin(ah));
    spiraalp.x:=cilinderp.x+round(al*sin(ah));
    spiraalp.y:=cilinderp.y-round(al*cos(ah));
    Paintbox1.Canvas.LineTo(Cilinderp.x,Cilinderp.y);
  end;
//Botstuk convex
  r:=Spinedit5.value;
  al1:=Spinedit6.value;
  al2:=Spinedit7.value;
  ah1:=al1/r;
  midden.x:=round(0.5*Paintbox1.width);
  midden.y:=round(0.5*Paintbox1.height);
  om1:=0.5*sqr(al1)/r;
  om2:=0.5*sqr(al2)/r;
  stap:=(om2-om1)/(9);
//Het begin van het gewrichtsvlak opzoeken
  cilinderp.x:=midden.x+round(r*cos(ah1));
  cilinderp.y:=midden.y+round(r*sin(ah1));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1));
//Groene cirkel als markering
  Form1.Paintbox1.Canvas.Pen.Color:=clGreen;
  Form1.Paintbox1.Canvas.Pen.Color:=clblack;
  k:=1;
  while k<=10 do
  begin
  {De omtrek van beginpunt van gewrichtsvlak tot het desbetreffende maatstreepje}
    L:=(k-1)*stap;
    {ah uitrekenen sqr(ah)=((om1+L)/(0,5*r)}
    ah:=sqrt((L+om1)/(0.5*r));
  //al=r*ah dus in radialen:
    al:=r*ah;
  {Punten op de spiraal berekenen}
    cilinderp.x:=midden.x+round(r*cos(ah));
    cilinderp.y:=midden.y+round(r*sin(ah));
    spiraalp.x:=cilinderp.x+round(al*sin(ah));
    spiraalp.y:=cilinderp.y-round(al*cos(ah));
  //Maatstreepjes tekenen
    Form1.Paintbox1.Canvas.Pen.Color:=clred;
    Form1.Paintbox1.Canvas.Pen.Color:=clBlack;
    CV[k].c:=ah;
    k:=k+1;
  end;
  Form1.Paintbox1.Canvas.Pen.Color:=clRed;
  Form1.Paintbox1.Canvas.Pen.Color:=clBlack;
//Het begin van het gewrichtsvlak opzoeken
  cilinderp.x:=midden.x+round(r*cos(ah1));
  cilinderp.y:=midden.y+round(r*sin(ah1));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1));
//Een loop om spiraal te tekenen.
  al2:=Spinedit7.value;
  ah2:=al2/r;
  ah:=ah1;
  while ah<=ah2 do
  begin
    ah:=ah+0.01;
    al:=r*ah;
    cilinderp.x:=midden.x+round(r*cos(ah));
    cilinderp.y:=midden.y+round(r*sin(ah));
    spiraalp.x:=cilinderp.x+round(al*sin(ah));
    spiraalp.y:=cilinderp.y-round(al*cos(ah));
//  Paintbox1.Canvas.LineTo(spiraalp.x,spiraalp.y);
  end;
//Uitrekenen van verschil in hoeken
  Stand:=Spinedit9.value;
  Deltahoek:=CV[stand].c-CC[stand].h;
  SH:=-(Deltahoek);
//Hoeken worden uitgerekend
  NuHoek:=(CV[stand].c-CC[stand].h)-(CV[1].c-CC[1].h);
  NuStand:=round((NuHoek)*180/pi);
  Edit2.Text:=IntToStr(NuStand)+' graden';
//Botstuk convex geroteerd
  r:=Spinedit5.value;
  al1:=Spinedit6.value;
  al2:=Spinedit7.value;
  ah1:=al1/r;
  midden.x:=round(0.5*Paintbox1.width);
  midden.y:=round(0.5*Paintbox1.height);
  om1:=0.5*sqr(al1)/r;
  om2:=0.5*sqr(al2)/r;
  stap:=(om2-om1)/(9);
//Het begin van het gewrichtsvlak opzoeken
  cilinderp.x:=midden.x+round(r*cos(ah1+SH));
  cilinderp.y:=midden.y+round(r*sin(ah1+SH));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1+SH));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1+SH));
//Groene cirkel als markering
  Form1.Paintbox1.Canvas.Pen.Color:=clGreen;
  Form1.Paintbox1.Canvas.Pen.Color:=clblack;
  k:=1;
  while k<=10 do
  begin
  {De omtrek van beginpunt van gewrichtsvlak tot het desbetreffende maatstreepje}
    L:=(k-1)*stap;
  {ah uitrekenen sqr(ah)=((om1+L)/(0,5*r)}
    ah:=sqrt((L+om1)/(0.5*r));
  //al=r*ah dus in radialen:
    al:=r*ah;
  {Punten op de spiraal berekenen}
    cilinderp.x:=midden.x+round(r*cos(ah+SH));
    cilinderp.y:=midden.y+round(r*sin(ah+SH));
    spiraalp.x:=cilinderp.x+round(al*sin(ah+SH));
    spiraalp.y:=cilinderp.y-round(al*cos(ah+SH));
  //Maatstreepjes tekenen
    Form1.Paintbox1.Canvas.Pen.Color:=clred;
    Form1.Paintbox1.Canvas.Pen.Color:=clBlack;
    CV[k].a:=Spiraalp.x;
    CV[k].b:=Spiraalp.y;
    CV[k].c:=ah;
    k:=k+1;
  end;
  Form1.Paintbox1.Canvas.Pen.Color:=clRed;
  Form1.Paintbox1.Canvas.Pen.Color:=clBlack;
//Het begin van het gewrichtsvlak opzoeken
  cilinderp.x:=midden.x+round(r*cos(ah1+SH));
  cilinderp.y:=midden.y+round(r*sin(ah1+SH));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1+SH));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1+SH));
//Een loop om spiraal te tekenen.
  al2:=Spinedit7.value;
  ah2:=al2/r;
  ah:=ah1;
  while ah<=ah2 do
  begin
    ah:=ah+0.01;
    al:=r*ah;
    cilinderp.x:=midden.x+round(r*cos(ah+SH));
    cilinderp.y:=midden.y+round(r*sin(ah+SH));
    spiraalp.x:=cilinderp.x+round(al*sin(ah+SH));
    spiraalp.y:=cilinderp.y-round(al*cos(ah+SH));
//  Paintbox1.Canvas.LineTo(spiraalp.x,spiraalp.y);
  end;
//Verschil in positie uitrekenen
  DeltaTR:=CC[stand].x-CV[stand].a;
  DeltaTY:=CC[stand].y-CV[stand].b;
  TR:=round(DeltaTR);
  TY:=round(DeltaTY);
//Botstuk convex getransleerd
  r:=Spinedit5.value;
  al1:=Spinedit6.value;
  al2:=Spinedit7.value;
  ah1:=al1/r;
  midden.x:=round(0.5*Paintbox1.width);
  midden.y:=round(0.5*Paintbox1.height);
  om1:=0.5*sqr(al1)/r;
  om2:=0.5*sqr(al2)/r;
  stap:=(om2-om1)/(9);
//Het begin van het gewrichtsvlak opzoeken
  cilinderp.x:=midden.x+TR+round(r*cos(ah1+SH));
  cilinderp.y:=midden.y+TY+round(r*sin(ah1+SH));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1+SH));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1+SH));
  k:=1;
  while k<=10 do
  begin
    {De omtrek van beginpunt van gewrichtsvlak tot het desbetreffende maatstreepje}
    L:=(k-1)*stap;
    {ah uitrekenen sqr(ah)=((om1+L)/(0,5*r)}
    ah:=sqrt((L+om1)/(0.5*r));
    //al=r*ah dus in radialen:
    al:=r*ah;
    {Punten op de spiraal berekenen}
    cilinderp.x:=midden.x+TR+round(r*cos(ah+SH));
    cilinderp.y:=midden.y+TY+round(r*sin(ah+SH));
    spiraalp.x:=cilinderp.x+round(al*sin(ah+SH));
    spiraalp.y:=cilinderp.y-round(al*cos(ah+SH));
    //Maatstreepjes tekenen
    Form1.Paintbox1.Canvas.Pen.Color:=clred;
    Paintbox1.Canvas.MoveTo(Spiraalp.x,Spiraalp.y);
    Paintbox1.Canvas.LineTo(Spiraalp.x+round(-10*sin(ah+SH)),
                            Spiraalp.y-round(-10*cos(ah+SH)));
    Form1.Paintbox1.Canvas.Pen.Color:=clBlack;
    CV[k].a:=Spiraalp.x;
    CV[k].b:=Spiraalp.y;
    CV[k].c:=ah;
    k:=k+1;
  end;
//Het begin van het gewrichtsvlak opzoeken
  cilinderp.x:=midden.x+TR+round(r*cos(ah1+SH));
  cilinderp.y:=midden.y+TY+round(r*sin(ah1+SH));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1+SH));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1+SH));
  Paintbox1.Canvas.MoveTo(Spiraalp.x,Spiraalp.y);
//Een loop om spiraal te tekenen.
  al2:=Spinedit7.value;
  ah2:=al2/r;
  ah:=ah1;
  while ah<=ah2 do
  begin
    ah:=ah+0.01;
    al:=r*ah;
    cilinderp.x:=midden.x+TR+round(r*cos(ah+SH));
    cilinderp.y:=midden.y+TY+round(r*sin(ah+SH));
    spiraalp.x:=cilinderp.x+round(al*sin(ah+SH));
    spiraalp.y:=cilinderp.y-round(al*cos(ah+SH));
    Paintbox1.Canvas.LineTo(spiraalp.x,spiraalp.y);
  end;
  cilinderp.x:=midden.x+TR+round(r*cos(ah2+SH));
  cilinderp.y:=midden.y+TY+round(r*sin(ah2+SH));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah2+SH));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah2+SH));
  Paintbox1.Canvas.MoveTo(Spiraalp.x,Spiraalp.y);
//centrodes tekenen
  cilinderp.x:=midden.x+TR+round(r*cos(ah1+SH));
  cilinderp.y:=midden.y+TY+round(r*sin(ah1+SH));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1+SH));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1+SH));
  Paintbox1.Canvas.MoveTo(Cilinderp.x,Cilinderp.y);
  al2:=Spinedit7.value;
  ah2:=al2/r;
  ah:=ah1;
  while ah<=ah2 do
  begin
    ah:=ah+0.01;
    al:=r*ah;
    cilinderp.x:=midden.x+TR+round(r*cos(ah+SH));
    cilinderp.y:=midden.y+TY+round(r*sin(ah+SH));
    spiraalp.x:=cilinderp.x+round(al*sin(ah+SH));
    spiraalp.y:=cilinderp.y-round(al*cos(ah+SH));
    Paintbox1.Canvas.LineTo(Cilinderp.x,Cilinderp.y);
  end;
//Loodlijn tekenen
  r:=Spinedit5.value;
  al1:=Spinedit6.value;
  al2:=Spinedit7.value;
  ah1:=al1/r;
  midden.x:=round(0.5*Paintbox1.width);
  midden.y:=round(0.5*Paintbox1.height);
  om1:=0.5*sqr(al1)/r;
  om2:=0.5*sqr(al2)/r;
  stap:=(om2-om1)/(9);
  //Het begin van het gewrichtsvlak opzoeken
  cilinderp.x:=midden.x+TR+round(r*cos(ah1+SH));
  cilinderp.y:=midden.y+TY+round(r*sin(ah1+SH));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1+SH));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1+SH));
  {De omtrek van beginpunt van gewrichtsvlak tot het desbetreffende maatstreepje}
  L:=(Stand-1)*stap;
  {ah uitrekenen sqr(ah)=((om1+L)/(0,5*r)}
  ah:=sqrt((L+om1)/(0.5*r));
  //al=r*ah dus in radialen:
  al:=r*ah;
  {Punten op de spiraal berekenen}
  cilinderp.x:=midden.x+TR+round(r*cos(ah+SH));
  cilinderp.y:=midden.y+TY+round(r*sin(ah+SH));
  spiraalp.x:=cilinderp.x+round(al*sin(ah+SH));
  spiraalp.y:=cilinderp.y-round(al*cos(ah+SH));
  Paintbox1.Canvas.MoveTo(Cilinderp.x,Cilinderp.y);
  Paintbox1.Canvas.LineTo(Spiraalp.x,Spiraalp.y);
//concaaf
  r:=Spinedit1.value;
  al1:=Spinedit2.value;
  al2:=Spinedit3.value;
  ah1:=al1/r;
  midden.x:=round(0.5*Paintbox1.width);
  midden.y:=round(0.5*Paintbox1.height);
  om1:=0.5*sqr(al1)/r;
  om2:=0.5*sqr(al2)/r;
  stap:=(om2-om1)/(9);
  //Het begin van het gewrichtsvlak opzoeken
  cilinderp.x:=midden.x+round(r*cos(ah1));
  cilinderp.y:=midden.y+round(r*sin(ah1));
  spiraalp.x:=cilinderp.x+round(al1*sin(ah1));
  spiraalp.y:=cilinderp.y-round(al1*cos(ah1));
  {De omtrek van beginpunt van gewrichtsvlak tot het desbetreffende maatstreepje}
  L:=(Stand-1)*stap;
  {ah uitrekenen sqr(ah)=((om1+L)/(0,5*r)}
  ah:=sqrt((L+om1)/(0.5*r));
  //al=r*ah dus in radialen:
  al:=r*ah;
  {Punten op de spiraal berekenen}
  cilinderp.x:=midden.x+round(r*cos(ah));
  cilinderp.y:=midden.y+round(r*sin(ah));
  spiraalp.x:=cilinderp.x+round(al*sin(ah));
  spiraalp.y:=cilinderp.y-round(al*cos(ah));
  Paintbox1.Canvas.MoveTo(Cilinderp.x,Cilinderp.y);
  Paintbox1.Canvas.LineTo(Spiraalp.x,Spiraalp.y);
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  Paintbox1.invalidate;
  if Spinedit9.value <=0 then
  Spinedit9.value:=1;
  if Spinedit9.value >=10 then
  Spinedit9.value:=10;
end;

procedure TForm1.Afsluiten1Click(Sender: TObject);
begin
 Application.terminate;
end;

end.
