program DialogTree;
{ Provando punteros haciendo un árbol de dialogos. }
uses crt;
type
	dialog = ^node;
	lista = ^celda;
	arrayCharTope = record
		elem : array[1 .. 100] of char;
		tope: 1 .. 100	
	end;
	celda = record
		text : arrayCharTope;
		elem : dialog;
		sig: lista	
	end;
	node = record
		npcDialog : arrayCharTope;
		respuestas: lista
	end;
procedure continuar;
begin
	Writeln('Presione enter para continuar'); readln();
end;
procedure InsertarFinalLista(var l:lista; elem:dialog);
var
	p,q:lista;
begin
new(p);
p^.elem:=elem;
p^.sig:=NIL;
if(l = NIL) then
	l:=p
else
	begin
		q:=l;
		while q^.sig <> NIL do
		q:=q^.sig;

		q^.sig := p;
	end;
end;
procedure AgregarFinalLista(elem:dialog; var l:lista);
var
	p,q: lista;
begin
	new(p);
	p^.elem:=elem;
	p^.sig:=nil;

	if l=nil then
	l:=p
	else
	begin
		q:=l;
		while q^.sig <> nil do
			q:=q^.sig;
		q^.sig:=p;
	end;
end;
procedure LeerEntradaCadenaConTope(var cadena:arrayCharTope);
var
	letra: char;
	contador: integer;
begin
	contador:=0;
	read(letra);
	while letra <> chr(10) do { Letra distinto de fin de linea (enter) }
	begin
		contador := contador + 1;
		cadena.tope:= contador;
		cadena.elem[contador] := letra;
		read(letra);
	end;		
end;
procedure EscribirCadenaConTope(cadena:arrayCharTope);
var
	i:integer;
begin
	for i := 1 to cadena.tope do
		begin
			Write(cadena.elem[i]);
		end;
	writeln();
end;
procedure SeleccionarNodo(dialogo:dialog);
var 
	actual:dialog;
	opcActual: lista;
	opc: integer;
	i: integer;
begin
	{ Mostrar opcines nodo }
	actual:=dialogo;
	i:=0;
	opcActual:= actual^.respuestas;
	while opcActual <> nil do
	begin
		i:=i + 1;	
		write(i, ') '); EscribirCadenaConTope(opcActual^.text);
		opcActual := opcActual^.sig;
	end;
	EscribirCadenaConTope(actual^.respuestas^.elem^.npcDialog); 
	write(': ');
	read(opc);
	opcActual:= actual^.respuestas;
	i:=0;
	while opcActual <> nil do
	begin
		i:=i + 1;
		if i = opc then	
		begin
			if opcActual^.elem^.respuestas <> nil then
				SeleccionarNodo(opcActual^.elem);
			opcActual:=nil;
		end
		else
			opcActual := opcActual^.sig
	end;
end;
procedure NavegarArbol(dialogo:dialog);
var
	opc:integer;
begin
	SeleccionarNodo(dialogo);
end;

procedure addNodes(var dialogo:dialog);
var
	variableName: Integer;
	nodo: ^node;
begin
	{ Creando nodo }
	new(nodo);
	Writeln('Ingrese npcDialog: ');
	LeerEntradaCadenaConTope(nodo^.npcDialog);

	if dialogo = nil then { árbol vacio } 
	begin
		dialogo:=nodo;
	end
	else { árbol con algún nodo } 
	begin
		
	end;
	Writeln('Se ha agregado el nodo al árbol');
	continuar();
end;

procedure salir(var exit: Boolean);
var 
	o: char;
begin
	repeat
		Writeln('Esta seguro que quiere salir (s: si, n: no)? ');
		readln(o);
	until (o = 's') or (o = 'n');
	if o = 's' then
		exit:= true
	else if o = 'n' then
		exit:= false
end;

{ MAIN }
var
	dialogo:dialog;
	opc: integer;
	exit: Boolean;
begin
	exit := false;
	repeat
		clrscr;
		Writeln('------>  MENU  <------');
		writeln();
		writeln('1) Agregar nodos al árbol');
		writeln('0) Salir.');
		writeln();
		Write('Seleccione una opción del menú: ');
		readln(opc);
		case opc of
			1: addNodes(dialogo);
			0: salir(exit);
			else 
				Writeln('Opción invalida');
		end;
		Writeln(exit);
	until exit;
	clrscr;
end.
