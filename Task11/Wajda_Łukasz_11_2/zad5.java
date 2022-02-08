import java.sql.*;
public class zad5 {
  public static void main(String[] argv) {
  /*
  System.out.println("Sprawdzenie czy sterownik jest zarejestrowany w menadzerze");
  try {
    Class.forName("org.postgresql.Driver");
  } catch (ClassNotFoundException cnfe) {
    System.out.println("Nie znaleziono sterownika!");
    System.out.println("Wyduk sledzenia bledu i zakonczenie.");
    cnfe.printStackTrace();
    System.exit(1);
  }
  System.out.println("Zarejstrowano sterownik");
  */
  Connection c = null;
  
    try {
        c = DriverManager.getConnection("jdbc:postgresql://pascal.fis.agh.edu.pl:5432/u9wajda", "u9wajda", "9wajda" );
    }
    catch (SQLException e) {
        System.err.println("Nie polaczylo z baza");
        System.exit(1);
    }
    
    String instruction = "";
    instruction += "CREATE OR REPLACE FUNCTION lab04.get_table()\n";
    instruction += "RETURNS TABLE (id int, imie varchar, nazwisko varchar) AS\n";
    instruction += "$$\n";
    instruction += "    SELECT id_uczestnik, imie, nazwisko FROM lab04.uczestnik\n";
    instruction += "$$ \n";
    instruction += "LANGUAGE SQL;\n";


    if (c != null) {
      System.out.println("Polaczenie z baza danych OK ! ");


  try {
        Statement statement = c.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE ); 
        statement.execute(instruction);
    } catch(SQLException e) {
        System.out.println("Nie udalo sie stworzyc funkcji");
    }

    try { 
       //c.setAutoCommit(false) ;
       CallableStatement cst = c.prepareCall( "{ call lab04.get_table() }" );
       cst.execute() ;
       ResultSet rs = cst.executeQuery();
       while (rs.next())  {
            String imie    = rs.getString(2) ;
            String nazwisko    = rs.getString(3) ;
            System.out.print("Pytanie 1 - wynik:  ");
            System.out.println(nazwisko + " " + imie) ;   }
       rs.close(); 
          
       cst.close();    
     }
     catch(SQLException e)  {
	     System.out.println("Blad podczas przetwarzania danych:"+e) ;   }	     
 
 }
  else
    System.out.println("Brak polaczenia z baza");   }
} 

