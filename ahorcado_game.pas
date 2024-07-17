PROGRAM ahorcado_game;
USES crt, SysUtils;

CONST
     POS_X = 10;
     TEMP = 2000;
     FILA = 4;
     COLUMNA = 3;
     X = 1;

TYPE
    array_palabra = array[1..10]of string;
    figura_ahorcado = array[1..FILA,1..COLUMNA]of string;
    tabla_almacena_letras = array[1..10]of string;
    ahorcado_auxiliar = array[1..4]of string;

VAR
   ar_pal: array_palabra;
   palabra: string;
   ahorcado: figura_ahorcado;
   tab_alm_let: tabla_almacena_letras;
   aho_aux: ahorcado_auxiliar;

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

FUNCTION valida_caracter(): string;
VAR
 caracter,letra: string;
 BEGIN
 writeln('>>> Ingrese una unica letra: ');
 caracter:= readkey;
 WHILE caracter <> #13 DO
  BEGIN
  IF caracter <> #8 THEN
   BEGIN
   gotoxy(X,whereY);
   IF X = 1 THEN
    letra:= caracter;
    write('*');
   END
  ELSE
   BEGIN
   gotoxy(whereX - 1,whereY);
   write(' ',#8);
   END;
  caracter:= readkey;
  END;
  valida_caracter:= letra;
 END;

PROCEDURE juego;
VAR
 caracter,cabeza,brazo_izquierdo,torso,brazo_derecho,pierna_izquierda,pierna_derecha: string;
 acierto,j,f,h,error: integer;
 BEGIN

 textcolor(white);
 error:= 0;
 acierto:= 0;
 FOR f:= 1 TO Length(palabra) DO
  BEGIN
  caracter:= valida_caracter;
  IF caracter = palabra[f] THEN
    BEGIN
    acierto:= acierto + 1;
    tab_alm_let[f]:= palabra[f];
    FOR j:= 1 TO acierto DO
     BEGIN
       IF tab_alm_let[j] <> ' ' THEN
        BEGIN
        textcolor(lightgreen);
        write('|',tab_alm_let[j]:1);
        END;
     END;
     WRITELN();
    writeln('*** Muy Bien! ***');
    END
  ELSE
    BEGIN
    error:= error + 1;
    IF (error >= 1) AND (error <= 6) THEN
     BEGIN
     textcolor(lightred);
     writeln('X Te has equivocado! X');
     CASE error OF
        1:BEGIN
          cabeza:= 'O';
          ahorcado[1,2]:= cabeza;
          FOR h:= 1 TO 1 DO
           BEGIN
           write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
           END;
          END;
        2:BEGIN
          brazo_izquierdo:= '/';
          ahorcado[2,1]:= brazo_izquierdo;
          FOR h:= 1 TO 2 DO
           BEGIN
           write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
           END;
          END;
        3:BEGIN
          torso:= '|';
          ahorcado[2,2]:= torso;
          FOR h:= 1 TO 2 DO
           BEGIN
            write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
           END;
          END;
        4:BEGIN
          brazo_derecho:= '\';
          ahorcado[2,3]:= brazo_derecho;
          FOR h:= 1 TO 2 DO
           BEGIN
            write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
           END;
          END;
        5:BEGIN
          pierna_izquierda:= '/';
          ahorcado[3,1]:= pierna_izquierda;
          FOR h:= 1 TO 3 DO
           BEGIN
            write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
           END;
          END;
        6:BEGIN
          pierna_derecha:= '\';
          ahorcado[3,3]:= pierna_derecha;
          FOR h:= 1 TO 3 DO
           BEGIN
            write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
           END;
          END;
     END;
     END
    ELSE
     BEGIN
     break;
     writeln('=================');
     writeln('X HAS FRACASADO X');
     writeln('=================');
     END;
  END;



 end;

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
