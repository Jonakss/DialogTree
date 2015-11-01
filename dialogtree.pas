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

{ Procedimientos extras }
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
procedure continuar;
begin
	Writeln('Presione enter para continuar'); readln();
end;

{ Procedimientos de Arreglo con tope }
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

{ Procedimientos del arbol }
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
