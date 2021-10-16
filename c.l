%{
#include <stdio.h> /* printf() */
#include <string.h> /* strcpy */
#include <stdlib.h> /* atoi(), atof() */
#include "common.h" /* MAX_STR_LEN */
#include "c.tab.h" /* deklaracja symboli końcowych */

/* wypisanie informacji o znalezionym symbolu końcowym */
int process_token(const char *text, const char *TokenType,
                  const char *TokenVal, const int TokenID); 

int comm_beg = 0; /* wiersz rozpoczęcia komentarza */
%}

/* deklaracja warunków początkowych analizatora */
/* (nie deklarujemy domyślnego warunku INITIAL) */
/* ..................... */

%%
 /* tu należy umieścić odpowiednie reguły w odpowiedniej kolejności */ 

 /* Zad 2 */
 /* Wykrywanie slow kluczowych */ 
(?i:int) return process_token(yytext, "KW_INT", "", KW_INT);
(?i:char) return process_token(yytext, "KW_CHAR", "", KW_CHAR);
(?i:unsigned) return process_token(yytext, "KW_UNSIGNED", "", KW_UNSIGNED);
(?i:short) return process_token(yytext, "KW_SHORT", "", KW_SHORT);
(?i:long) return process_token(yytext, "KW_LONG", "", KW_LONG);
(?i:float) return process_token(yytext, "KW_FLOAT", "", KW_FLOAT);
(?i:void) return process_token(yytext, "KW_VOID", "", KW_VOID);
(?i:for) return process_token(yytext, "KW_FOR", "", KW_FOR);
(?i:double) return process_token(yytext, "KW_DOUBLE", "", KW_DOUBLE);
(?i:if) return process_token(yytext, "KW_IF", "", KW_IF);
(?i:else) return process_token(yytext, "KW_ELSE", "", KW_ELSE);
(?i:while) return process_token(yytext, "KW_WHILE", "", KW_WHILE);
(?i:do) return process_token(yytext, "KW_DO", "", KW_DO);
(?i:struct) return process_token(yytext, "KW_STRUCT", "", KW_STRUCT);

 /* Zad 3 */
 /* Usuwanie bialych znakow */
 

%%












/* Nazwa:       process_token
 * Cel:         Wypisanie informacji o wykrytym elemencie i przekazanie
 *              tej informacji wyżej z ewentualną wartością elementu, jeśli
 *              takowa występuje.
 * Parametry:   text            - (i) tekst, do którego nastąpiło dopasowanie;
 *              TokenType       - (i) napis będący tekstową reprezentacją
 *                                      nazwy typu elementu;
 *              TokenVal        - (i) wartość elementu, o ile występuje;
 *              TokenID         - (i) identyfikator typu elementu zadeklarowany
 *                                      za pomocą dyrektywy %token
 *                                      w pliku c.y lub kod pojedynczego
 *					znaku (w pliku analizatora składniowego
 *					występuje ujęty w apostrofy).
 * Zwraca:      Identyfikator typu elementu (TokenID).
 * Uwagi:       Informacja o wykrytym elemencie zwracana jest
 *              w trzech kolumnach. W pierwszej wypisywany jest tekst,
 *              do którego nastąpiło dopasowanie, w drugiej - typ elementu,
 *              w trzeciej - wartość elementu (o ile występuje).
 */
int process_token(const char *text, const char *TokenType,
                  const char *TokenVal, const int TokenID)
{
  int l;
  printf("%-20.20s%-15s %s\n", text, TokenType, TokenVal);
  switch (TokenID) {

  case INTEGER_CONST:
    yylval.i = atoi(text); break;

  case FLOAT_CONST:
    yylval.d = atof(text); break;

  case IDENT:
    strncpy(yylval.s, text, MAX_STR_LEN); break;

  case STRING_CONST:
    l = strlen(TokenVal);
    yylval.s[0] = '\0';
    strncpy(yylval.s, TokenVal + 1, l - 2 <= MAX_STR_LEN ? l - 1 : MAX_STR_LEN);
    break;

  case CHARACTER_CONST:
    yylval.i = text[1]; break;

  }
  return(TokenID);
}


int yywrap( void )
{ /* funkcja wywoływana po napotkaniu końca strumienia wejściowego

  /* sprawdzenie, czy warunek poczatkowy YY_START różni się od INITIAL. */
  /* Jeżeli tak, to oznacza to niezamknięty komentarz lub stała tekstową
     - wypisujemy informację o błędzie. */
  /* ..................... */
  return( 1 ); /* koniecznie, by analiza nie rozpoczęła się od nowa */
}


