PROGRAM ahorcado_game;
USES crt, SysUtils;

CONST
     POS_X = 10;
     TEMP = 2000;
     FILA = 4;
     COLUMNA = 3;

TYPE
    array_palabra = array[1..10]of string;
    figura_ahorcado = array[1..FILA,1..COLUMNA]of string;

VAR
   ar_pal: array_palabra;
   palabra: string;
   ahorcado: figura_ahorcado;

PROCEDURE aginar_valores_figura_ahorcado;
 BEGIN
 ahorcado[1,2]:= 'O';
 ahorcado[2,1]:= '/';
 ahorcado[2,2]:= 'I';
 ahorcado[2,3]:= '\';
 ahorcado[3,2]:= 'I';
 ahorcado[4,1]:='/';
 ahorcado[4,3]:= '\';
 END;

PROCEDURE generar_palabra;
VAR
 i: integer;
 aux,aux_2,caracter: string;
 BEGIN
 writeln('GENERE PALABRA');
 caracter:= readkey;
 i:= 0;
 WHILE caracter <> #13 DO
  BEGIN
  IF caracter <> #8 THEN
   BEGIN
   gotoxy(whereX,whereY);
   IF (whereX <= POS_X) THEN
    BEGIN
     i:= i + 1;
     ar_pal[i]:= caracter;
     write('*');
    END;
   END
  ELSE
   BEGIN
   gotoxy(whereX - 1,whereY);
   IF (i >= 1) AND (i <= POS_X) THEN
    BEGIN
    ar_pal[i]:= ' ';
    i:= i - 1;
    write(' ',#8);
    END
    ELSE
    i:= 0;
   END;
     caracter:= readkey;
 END;
 palabra:=' ';
 FOR i:= 1 TO 10 DO
  BEGIN
  IF ar_pal[i] <> ' ' THEN
    IF palabra = ' ' THEN
     palabra:= ar_pal[i]
    ELSE
     BEGIN
     aux:= ar_pal[i];
     aux_2:= concat(palabra,aux);
     palabra:= aux_2;
     END;
  END;
  textcolor(green);
  writeln();
  writeln('========================');
  writeln('*** PALABRA GENERADA ***');
  writeln('========================');
  delay(TEMP);
 END;

PROCEDURE juego;
VAR
 f: integer;
 BEGIN
 FOR f:= 1 TO Lenght(palabra) DO

 END;

PROCEDURE cargar_palabra_jugar;
 BEGIN
 generar_palabra;
 clrscr;
 juego;
 END;

PROCEDURE menu_principal;
VAR
 opcion: integer;
 BEGIN
  REPEAT
  clrscr;
  textcolor(white);
  writeln('MENU');
  writeln('----');
  writeln('1. Cargar palabra y jugar');
  writeln('2. Salir');
  writeln();
  writeln('--------------------------');
  write('Seleccione opcion: ');
  readln(opcion);
  CASE opcion OF
       1:BEGIN
         clrscr;
         cargar_palabra_jugar;
         END;
  END;
  UNTIL (opcion = 2);
 END;

BEGIN
menu_principal;
END.
