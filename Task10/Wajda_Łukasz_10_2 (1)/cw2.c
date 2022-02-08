#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <libpq-fe.h>
#include "lab10pq.h"


void deleteRecord(PGconn *conn, char* id) {
  PGresult *result;
  char delete_comand[256];
  strcat(delete_comand, "DELETE FROM lab04.person WHERE id = ");
  strcat(delete_comand, id);
  strcat(delete_comand, ";");
  result = PQexec(conn, delete_comand);
}

void doSQL(PGconn *conn, char *command){
  PGresult *result;
  result = PQexec(conn, command);
	
  switch(PQresultStatus(result)) {
    case PGRES_TUPLES_OK:{
      int r = 0;
      int nrows   = PQntuples(result);
      printf("liczba zwroconych rekordow = %d\n", nrows);
      for(r = 0; r < nrows; r++) {
        printf(" id = %3s | name : %10s, lastname: %10s", PQgetvalue(result, r, 0),PQgetvalue(result,r, 1), PQgetvalue(result, r, 2));
        printf("\n");
      }
    }
  }
  PQclear(result);
} 

int main(){
  PGresult *result;
  PGconn *conn;
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
      fprintf(stderr, "Connection to %s failed, %s", connection_str, PQerrorMessage(conn));
  }
  else {
      printf("Connected OK\n");
      doSQL(conn, "DROP TABLE IF EXISTS lab04.person CASCADE;");
      doSQL(conn, "CREATE TABLE lab04.person ( id INTEGER PRIMARY KEY, fname VARCHAR(60), lname VARCHAR(60) );");
      doSQL(conn, "INSERT INTO lab04.person VALUES (10, 'Jan', 'Wabacki')");
      doSQL(conn, "INSERT INTO lab04.person VALUES (29, 'Jan', 'Babacki')");
      doSQL(conn, "INSERT INTO lab04.person VALUES (31, 'Jan', 'Zabacki')");
      doSQL(conn, "INSERT INTO lab04.person VALUES (66, 'Jan', 'Dabacki')");
      printf("\n\nPo dodaniu rekordow: \n");
      doSQL(conn, "SELECT * FROM lab04.person;");
      doSQL(conn, "UPDATE lab04.person SET fname = 'Marian', lname = 'Kakacki' WHERE id = 10;");
      printf("\n\nPo zmianie rekordu: \n");
      doSQL(conn, "SELECT * FROM lab04.person;");
      deleteRecord(conn, "66");
      printf("\n\nPo usunieciu: \n");
      doSQL(conn, "SELECT * FROM lab04.person;");
  }
  PQfinish(conn);
  return EXIT_SUCCESS;

}
