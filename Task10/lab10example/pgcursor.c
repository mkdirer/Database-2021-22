#include <stdlib.h>
#include <string.h>
#include <libpq-fe.h>
#include "lab10pq.h"


void printTuples(PGresult *result) {
}



void doSQL(PGconn *conn, char *command){
  PGresult *result;
  printf("------------------------------\n");
  printf("%s\n", command);
  result = PQexec(conn, command);
  printf("stan polecenia:              %s\n", PQresStatus(PQresultStatus(result)));
  printf("opis stanu:                  %s\n", PQresultErrorMessage(result));
  printf("liczba zmienionych rekordów: %s\n", PQcmdTuples(result));
	
  if( PQresultStatus(result) == PGRES_TUPLES_OK )
  	printTuples(result);

  PQclear(result);
}

int main(){
  PGresult *result;
  PGconn *conn;
  int nTuples = 0;
  char connection_str[256];

   doSQL(conn, "BEGIN work");
     doSQL(conn, "DECLARE mcursor CURSOR FOR SELECT * FROM lab04.person");
     do {
       result = PQexec(conn, "FETCH 1 IN mcursor");
       if ( PQresultStatus(result) == PGRES_TUPLES_OK) {
          nTuples = PQntuples(result);
          printTuples(result);
          PQclear(result);
       } else nTuples = 0;
     } while (nTuples) ;
     doSQL(conn, "CLOSE mcursor");
     doSQL(conn, "COMMIT work");
  }
  PQfinish(conn);
  return EXIT_SUCCESS;
}
