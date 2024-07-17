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

VAR
   ar_pal: array_palabra;
   palabra: string;
   ahorcado: figura_ahorcado;

PROCEDURE inicializar_arreglo_palabra;
VAR
 f: integer;
 BEGIN
 FOR f:= 1 TO 10 DO
  BEGIN
  ar_pal[f]:= ' ';
  END;
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

FUNCTION valida_caracter(): string;
VAR
 caracter,letra: string;
 BEGIN
 textcolor(white);
 writeln();
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

FUNCTION busca_letra (caracter: string): boolean;
VAR
 f: boolean;
 pos,lim: integer;
 BEGIN
 f:= false;
 pos:= 0;
 lim:= Length(palabra);
 REPEAT
 pos:= pos + 1;
 IF caracter = palabra[pos] THEN
  f:= true;
 UNTIL (pos = lim) OR (f = true);
 IF f = true THEN
  BEGIN
  writeln(palabra[pos]);
  busca_letra:= true;
  END
 ELSE
  busca_letra:= false;
 END;

PROCEDURE juego;
VAR
 caracter,cabeza,brazo_izquierdo,torso,brazo_derecho,pierna_izquierda,pierna_derecha: string;
 acierto,h,error,long_palabra: integer;
 BEGIN
 textcolor(white);
 error:= 0;
 acierto:= 0;
 long_palabra:= Length(palabra);
 REPEAT
 caracter:= valida_caracter;
 IF busca_letra(caracter) = true THEN
  BEGIN
  acierto:= acierto + 1;
  textcolor(lightgreen);
  writeln();
  writeln();
  writeln('*** Muy Bien! ***');
  END

 ELSE
    BEGIN
    error:= error + 1;
    IF (error >= 1) AND (error < 7) THEN
     BEGIN
     textcolor(lightred);
     writeln();
     writeln();
     writeln('X Te has equivocado! X');
     CASE error OF
        1:BEGIN
          writeln();
          cabeza:= 'O';
          ahorcado[1,2]:= cabeza;
           write(ahorcado[1,1]:1,' ',ahorcado[1,2]:1,' ',ahorcado[1,3]:1);
           writeln();
          END;
        2:BEGIN
          writeln();
          brazo_izquierdo:= '/';
          ahorcado[2,1]:= brazo_izquierdo;
          FOR h:= 1 TO 2 DO
           BEGIN
           write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
           END;
           writeln();
          END;
        3:BEGIN
          writeln();
          torso:= '|';
          ahorcado[2,2]:= torso;
          FOR h:= 1 TO 2 DO
           BEGIN
            write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
            writeln();
           END;
           writeln();
          END;
        4:BEGIN
          writeln();
          brazo_derecho:= '\';
          ahorcado[2,3]:= brazo_derecho;
          FOR h:= 1 TO 2 DO
           BEGIN
            write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
            writeln();
           END;
           writeln();
          END;
        5:BEGIN
          writeln();
          pierna_izquierda:= '/';
          ahorcado[3,1]:= pierna_izquierda;
          FOR h:= 1 TO 3 DO
           BEGIN
            write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
            writeln();
           END;
           writeln();
          END;
        6:BEGIN
          writeln();
          pierna_derecha:= '\';
          ahorcado[3,3]:= pierna_derecha;
          FOR h:= 1 TO 3 DO
           BEGIN
            write(ahorcado[h,1]:1,' ',ahorcado[h,2]:1,' ',ahorcado[h,3]:1);
            writeln();
           END;
           writeln();
          END;
     END;
    END;

  END;

   UNTIL (acierto = long_palabra) OR (error = 6);

 IF (acierto = long_palabra) THEN
    BEGIN
    textcolor(lightgreen);
    writeln();
    writeln('=============================');
    writeln('*** HAS GANADO LA PARTIDA ***');
    writeln('=============================');
    writeln();
    END
   ELSE IF error = 6 THEN
    BEGIN
    textcolor(lightred);
    writeln();
    writeln('==============================');
    writeln('XXX HAS PERDIDO LA PARTIDA XXX');
    writeln('==============================');
    writeln();
    textcolor(lightgreen);
    writeln('La palabra era: ',palabra);
    END;

 END;

PROCEDURE cargar_palabra_jugar;
VAR
 opcion: string;
 BEGIN
 REPEAT
 clrscr;
 generar_palabra;
 clrscr;
 juego;
 REPEAT
  writeln();
  textcolor(white);
  writeln('Desea jugar otra vez[s/n]?: ');
  readln(opcion);
  IF (opcion <> 's') AND (opcion <> 'n') THEN
   BEGIN
   textcolor(lightred);
   writeln();
   writeln('////////////////////////////////////////');
   writeln('X VALOR INCORRECTO. INGRESE NUEVAMENTE X');
   writeln('////////////////////////////////////////');
   writeln();
   END;
  UNTIL (opcion = 's') OR (opcion = 'n');
 UNTIL (opcion = 'n');

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
inicializar_arreglo_palabra;
menu_principal;
END.
