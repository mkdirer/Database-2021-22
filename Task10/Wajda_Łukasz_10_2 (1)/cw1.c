#include <stdlib.h>
#include <libpq-fe.h>
#include <stdio.h>
#include <string.h>
#include "lab10pq.h"
 
// for ntohl/htonl
#include <netinet/in.h>
#include <arpa/inet.h>
 
int main(){
  PGresult *result;
  PGconn *conn;
  const char *paramValues[2];
  int         paramLengths[2];
  int         paramFormats[2];
  u_int32_t    firstID;
  u_int32_t    lastID;
  char connection_str[256];

  strcpy(connection_str, "host=");
  strcat(connection_str, dbhost);
  strcat(connection_str, " port=");
  strcat(connection_str, dbport);
  strcat(connection_str, " dbname=");
  strcat(connection_str, dbname);
  strcat(connection_str, " user=");
  strcat(connection_str, dbuser);
  strcat(connection_str, " password=");
  strcat(connection_str, dbpassword);

  
  conn = PQconnectdb(connection_str);
  if (PQstatus(conn) == CONNECTION_BAD) {
    fprintf(stderr, "Connection to %s failed, %s", connection_str,PQerrorMessage(conn));
  } else {
    printf("Connected OK\n");

    int a,b;
    printf("Podaj id od którego wypisać studentów\n a = ");
    scanf("%d", &a);
    printf("Podaj id na którym skończyć wypisywanie studentów\n b = ");
    scanf("%d", &b);
 
    // Convert integer value "10" to network byte order
    firstID = htonl((u_int32_t) a);
    lastID = htonl((u_int32_t) b);
 
    // Set up parameter arrays for PQexecParams 
    paramValues[0] = (char *) &firstID;
    paramLengths[0] = sizeof(firstID);
    paramFormats[0] = 1;        // binary 

    paramValues[1] = (char *) &lastID;
    paramLengths[1] = sizeof(lastID);
    paramFormats[1] = 1;        // binary 
 
    result = PQexecParams(conn, "SELECT * FROM lab4.uczestnik U WHERE U.id_uczestnik >= $1::int4 AND U.id_uczestnik <= $2::int4",
                       2,       // one param 
                       NULL,    // let the backend deduce param type 
                       paramValues,
                       paramLengths,
                       paramFormats,
                       0);      // ask for binary results 
 
    if (PQresultStatus(result) != PGRES_TUPLES_OK)
    {
        fprintf(stderr, "SELECT failed: %s", PQerrorMessage(conn));
        PQclear(result);
    } else {
      int n = 0, r = 0;
      int nrows   = PQntuples(result);
      int nfields = PQnfields(result);
      printf("liczba zwróconych rekordów = %d\n", nrows);
      printf("liczba zwróconych kolumn   = %d\n", nfields);
      for(r = 0; r < nrows; r++) {
        for(n = 0; n < nfields; n++)
           printf(" %s = %s", PQfname(result, n),PQgetvalue(result,r,n));
        printf("\n");
      }
    }
    PQfinish(conn);
    return EXIT_SUCCESS;
 }
}

