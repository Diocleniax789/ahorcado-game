PROGRAM ahorcado_game;
USES crt;

VAR





PROCEDURE menu_principal;
VAR
 opcion: integer;
 BEGIN
  REPEAT
  clrscr;
  textcolor(white);
  writeln('MENU');
  writeln('----');
  writeln('1. Cargar palabra');
  writeln('2. Jugar');
  writeln('3. Salir');
  writeln();
  write('Seleccione opcion: ');
  readln(opcion);
  CASE opcion OF
       1:BEGIN
         cargar_palabra;
         END;
       2:BEGIN
         jugar;
         END;
  END;
  UNTIL (opcion = 3);
 END;

BEGIN


END.
