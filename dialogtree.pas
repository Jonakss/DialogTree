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
	writeln();	
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
procedure selectNode(dialogo:dialog; i:integer):dialog;
var 
	actual: ^nodo;
	j:integer;
begin
	actual:=dialogo;
	while actual <> nil do
	begin
		j:=j+1;
		if i = j then
			nodoSelccionado:=actual
		else
			nodoSelccionado:=nil
		actual:=actual^.respuestas^.sig;
	end;
end;
procedure showNodes(dialogo:dialog);
var 
	actual: ^node;
	opcActual: lista;
	i,j: integer;
begin
	if dialogo = nil then
		Writeln('Árbol de dialogos vacio')
	else
	begin
		i:=0;
		actual:=dialogo;
		while actual <> nil do
		begin
			i:=i+1;
			Write(i, ') '); EscribirCadenaConTope(actual^.npcDialog);

			if actual^.respuestas = nil then
				actual:=nil
			else
			begin
				j:=0;
				opcActual:=actual^.respuestas;
				while opcActual <> nil do
				begin
					j:=j+1;
					Write(' | ', j,') '); EscribirCadenaConTope(opcActual^.text);
					opcActual:=opcActual^.sig;
				end;
				actual:=actual^.respuestas^.elem; 
			end;
		end;
	end;
end;
procedure addNodes(var dialogo:dialog);
var
	variableName: Integer;
	nodo, nodoSelccionado: ^node;
	p: integer;
begin
	{ Creando nodo }
	new(nodo);
	Write('Ingrese npcDialog: ');
	LeerEntradaCadenaConTope(nodo^.npcDialog);

	if dialogo = nil then { árbol vacio } 
	begin
		dialogo:=nodo;
		Writeln('Se ha agregado el nodo a la raiz del árbol');
	end
	else { árbol con algún nodo } 
	begin
		showNodes(dialogo);
		Write('Seleccione el nodo padre: '); readln(p);
		nodoSelccionado:=selectNode(dialogo, p);
		if nodoSelccionado^.respuestas = nil then
			nodoSelccionado^.respuestas=nodo
		else
			nodoSelccionado^.respuestas^.sig=nodo
	end;
	continuar();
end;

{ MAIN }
var
	dialogo:dialog;
	opc: char;
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
			'1': addNodes(dialogo);
			'0': salir(exit);
			else 
				Writeln('Opción invalida');
		end;
	until exit;
	clrscr;
end.
