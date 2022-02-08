#include <stdio.h>
#include <string.h>
#include <sql.h>
#include <sqlext.h>

int odbc_select()
{
	SQLHENV     hEnv = NULL;
	SQLHDBC     hDbc = NULL;
	SQLHSTMT    hStmt = NULL;
	WCHAR*      pwszConnStr;
	WCHAR       wszInput[SQL_QUERY_SIZE];
	SQLRETURN	ret;
	//char		tmpbuf[256];
	int row = 0;
	SQLINTEGER  uczestnikID[] = { 1,2 };
	SQLUSMALLINT ParamStatusArray[PARAM_ARRAY_SIZE];
	SQLLEN       ParamsProcessed = 0;

	// Allocate an environment
	if (SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &hEnv) == SQL_ERROR)
	{
		fwprintf(stderr, L"Unable to allocate an environment handle\n");
		exit(-1);
	}

	// Register this as an application that expects 3.x behavior,
	// Allocate a connection
	RETCODE rc = SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION, (SQLPOINTER)SQL_OV_ODBC3, 0);
	if (rc != SQL_SUCCESS)
	{
		HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
	}
	if (rc == SQL_ERROR)
	{
		fprintf(stderr, "Error in SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,	(SQLPOINTER)SQL_OV_ODBC3,0)\n");
		exit(-1);
	}

	rc = SQLAllocHandle(SQL_HANDLE_DBC, hEnv, &hDbc);
	if (rc != SQL_SUCCESS)
	{
		HandleDiagnosticRecord(hEnv, SQL_HANDLE_ENV, rc);
	}
	if (rc == SQL_ERROR)
	{
		fwprintf(stderr, L"Error in SQLSetEnvAttr(hEnv, SQL_ATTR_ODBC_VERSION,	(SQLPOINTER)SQL_OV_ODBC3,0)\n");
		goto Exit;
	}

	pwszConnStr = L"PostgreSQL_DB1Lab01";

	rc = SQLConnect(hDbc, pwszConnStr, SQL_NTS, NULL, 0, NULL, 0);

	fwprintf(stderr, L"Connected!\n");

	rc = SQLAllocHandle(SQL_HANDLE_STMT, hDbc, &hStmt);

	wcscpy_s(wszInput, L"SELECT nazwisko, imie FROM lab04.uczestnik WHERE id_uczestnik = ?;");

	RETCODE     RetCode;
	SQLSMALLINT sNumResults;

	// Execute the query
	// Prepare Statement
	//RetCode = SQLPrepare(hStmt, wszInput, SQL_NTS);

	RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAMSET_SIZE, (SQLPOINTER)PARAM_ARRAY_SIZE, 0);
	RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAM_STATUS_PTR, ParamStatusArray, PARAM_ARRAY_SIZE);
	RetCode = SQLSetStmtAttr(hStmt, SQL_ATTR_PARAMS_PROCESSED_PTR, &ParamsProcessed, 0);

	// Bind array values of parameter 1
	RetCode = SQLBindParameter(hStmt, 1, SQL_PARAM_INPUT, SQL_C_LONG,
		SQL_INTEGER, 0, 0, uczestnikID, 0, NULL);

	RetCode = SQLExecDirect(hStmt, wszInput, SQL_NTS);
	//RetCode = SQLExecute(hStmt);
	//RetCode = SQLExecDirect(hStmt, wszInput, SQL_NTS);


	// Retrieve number of columns
	rc = SQLNumResultCols(hStmt, &sNumResults);
	//wprintf(L"Number of Result Columns %i\n", sNumResults);

	
	switch (RetCode)
	{
	case SQL_SUCCESS_WITH_INFO:
	{
		HandleDiagnosticRecord(hStmt, SQL_HANDLE_STMT, RetCode);
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
					SQLWCHAR buf[512];
					// retrieve column data as a string
					ret = SQLGetData(hStmt, i, SQL_C_WCHAR,	buf, sizeof(buf), &indicator);
					if (SQL_SUCCEEDED(ret)) {
						/* Handle null columns */
						if (indicator == SQL_NULL_DATA) wcscpy_s(buf, L"NULL");
						printf("  Column %u : %ws\n", i, buf);
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
				wprintf(L"%Id %s affected\n", cRowCount, cRowCount == 1 ? L"row" : L"rows");
			}
		}
		break;
	}

	case SQL_ERROR:
	{
		HandleDiagnosticRecord(hStmt, SQL_HANDLE_STMT, RetCode);
		break;
	}

	default:
		fwprintf(stderr, L"Unexpected return code %hd!\n", RetCode);

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

	wprintf(L"\nUFF - pozamiatane\n");

	return 0;
}
int main() {
odb_select();
return 0;
}
