#include <stdio.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>
#include <stdlib.h>

#define SQL_QUERY_SIZE 1024
#define PARAM_ARRAY_SIZE 2

int main()
{
	SQLHENV     hEnv = NULL;
	SQLHDBC     hDbc = NULL;
	SQLHSTMT    hStmt = NULL;
	CHAR*      pwszConnStr;
	CHAR       wszInput[SQL_QUERY_SIZE];
	SQLRETURN	ret;
	//char		tmpbuf[256];
	int row = 0;
	SQLINTEGER  uczestnikID[] = {88};
	SQLUSMALLINT ParamStatusArray[PARAM_ARRAY_SIZE];
	SQLLEN       ParamsProcessed = 0;
	SQLCHAR imie[255];
	SQLCHAR nazwisko[255];
	SQLLEN len_imie=0, len_nazwisko=0;

	// Allocate an environment
	if (SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &hEnv) == SQL_ERROR)
	{
		fprintf(stderr, "Unable to allocate an environment handle\n");
		exit(-1);
	}

	// Register this as an application that expects 3.x behavior,
	// Allocate a connection
	RETCODE rc = SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, (SQLPOINTER)SQL_OV_ODBC3, 0);
	if (rc != SQL_SUCCESS)
	{
		//HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
	}
	if (rc == SQL_ERROR)
	{
		fprintf(stderr, "Error in SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,	(SQLPOINTER)SQL_OV_ODBC3,0)\n");
		exit(-1);
	}

	rc = SQLAllocHandle(SQL_HANDLE_DBC, hEnv, &hDbc);
	if (rc != SQL_SUCCESS)
	{
		//HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
	}
	if (rc == SQL_ERROR)
	{
		fprintf(stderr, "Error in SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,	(SQLPOINTER)SQL_OV_ODBC3,0)\n");
		goto Exit;
	}

	pwszConnStr = "9wajda";

	rc = SQLConnect(hDbc, pwszConnStr, SQL_NTS, NULL, 0, NULL, 0);

	fprintf(stderr, "Connected!\n");

	rc = SQLAllocHandle(SQL_HANDLE_STMT, hDbc, &hStmt);

	strcpy(wszInput, "UPDATE lab04.uczestnik SET imie = ?, nazwisko = ? WHERE id_uczestnik = ?;");

	RETCODE     RetCode;
	SQLSMALLINT sNumResults;

	// Execute the query
	// Prepare Statement
	//RetCode = SQLPrepare(hStmt, wszInput, SQL_NTS);


	// Bind array values of parameter 1
	
	RetCode = SQLBindParameter(hStmt, 1, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_CHAR, 255, 0, imie, 255, &len_imie);
	RetCode = SQLBindParameter(hStmt, 2, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_CHAR, 255, 0, nazwisko, 255, &len_nazwisko);
	RetCode = SQLBindParameter(hStmt, 3, SQL_PARAM_INPUT, SQL_C_LONG,SQL_INTEGER, 0, 0, uczestnikID, 0, NULL);
	strcpy(imie, "Zbigniew"); 
	len_imie=strlen(imie);
  	strcpy(nazwisko, "Pelikan"); 
	len_nazwisko=strlen(nazwisko);

	RetCode = SQLExecDirect(hStmt, wszInput, SQL_NTS);
	//RetCode = SQLExecute(hStmt);
	//RetCode = SQLExecDirect(hStmt, wszInput, SQL_NTS);


	// Retrieve number of columns
	rc = SQLNumResultCols(hStmt, &sNumResults);
	//printf("Number of Result Columns %i\n", sNumResults);

	
	switch (RetCode)
	{
	case SQL_SUCCESS_WITH_INFO:
	{
		//HandleDiagnosticRecord(hStmt, SQL_HANDLE_STMT, RetCode);
	}
	case SQL_SUCCESS:
	{
		rc = SQLNumResultCols(hStmt, &sNumResults);

		if (sNumResults > 0)
		{
			//DisplayResults(hStmt, sNumResults);
			while (SQL_SUCCEEDED(ret = SQLFetch(hStmt))) {
				SQLUSMALLINT i;
				printf("Row %d\n", row++);
				// Loop through the columns */
				for (i = 1; i <= sNumResults; i++) {
					SQLLEN indicator;
					SQLCHAR buf[512];
					// retrieve column data as a string
					ret = SQLGetData(hStmt, i, SQL_C_CHAR,	buf, sizeof(buf), &indicator);
					if (SQL_SUCCEEDED(ret)) {
						/* Handle null columns */
						if (indicator == SQL_NULL_DATA) strcpy(buf, "NUL");
						printf("  Column %u : %s\n", i, buf);
					}
				}
			}
		}
		else
		{
			SQLLEN cRowCount;

			rc = SQLRowCount(hStmt, &cRowCount);
			if (cRowCount >= 0)
			{
				printf("%Id %s affected\n", cRowCount, cRowCount == 1 ? "row" : "rows");
			}
		}
		break;
	}

	case SQL_ERROR:
	{
		//HandleDiagnosticRecord(hStmt, SQL_HANDLE_STMT, RetCode);
		break;
	}

	default:
		fprintf(stderr, "Unexpected return code %hd!\n", RetCode);

	}
	rc = SQLFreeStmt(hStmt, SQL_CLOSE);

Exit:

	if (hStmt)
	{
		SQLFreeHandle(SQL_HANDLE_STMT, hStmt);
	}

	if (hDbc)
	{
		SQLDisconnect(hDbc);
		SQLFreeHandle(SQL_HANDLE_DBC, hDbc);
	}

	if (hEnv)
	{
		SQLFreeHandle(SQL_HANDLE_ENV, hEnv);
	}

	printf("\nUFF - pozamiatane\n");

	return 0;
}
