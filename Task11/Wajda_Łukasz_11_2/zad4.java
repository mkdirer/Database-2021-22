import java.sql.*;
import java.util.Scanner;

class zad4 {

    public static void main( String[] args ) {

        Connection conn = null;

        try {
            conn = DriverManager.getConnection("jdbc:postgresql://pascal.fis.agh.edu.pl:5432/u9wajda", "u9wajda", "9wajda" );
        }
        catch (SQLException e) {
            System.err.println("Nie polaczylo z baza");
            System.exit(1);
        }

        String instruction = "";
        instruction += "CREATE OR REPLACE FUNCTION lab04.f1_osoba ( id int )\n";
        instruction += "RETURNS TABLE (nazwisko varchar, imie varchar, id int) AS\n";
        instruction += "$$\n";
        instruction += "    SELECT nazwisko, imie, id FROM lab04.uczestnik WHERE id_uczestnik = id \n";
        instruction += "$$ \n";
        instruction += "LANGUAGE SQL;\n";

        if( conn != null ) {
            System.out.println("Dalo rade");

            try {
                Statement statement = conn.createStatement( ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE ); 
                statement.execute(instruction);
            } catch(SQLException e) {
                System.out.println("Nie udalo sie stworzyc funkcji");
            }

            try {                                                                                                       
               CallableStatement cst = conn.prepareCall( "{call lab04.f1_osoba(?)}" );
               cst.setInt(1,1);

               ResultSet rs ;
               rs = cst.executeQuery();
               while (rs.next())  {
                    String nazwisko    = rs.getString(1) ;
                    System.out.print("Pytanie 1 - wynik:  ");
                    System.out.println(nazwisko) ;   }
               rs.close();      
         
               cst.close();    
             }
             catch(SQLException e)  {
                 System.out.println("Blad podczas przetwarzania danych:"+e) ;   }        
        }
        else {
            System.err.println("Nie ma polaczenia");
        }
    }
}