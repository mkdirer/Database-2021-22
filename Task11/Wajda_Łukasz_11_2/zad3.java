import java.sql.*;
public class zad3 {
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
  System.out.println("Zarejstrowano sterownik - OK, kolejny krok nawiazanie polaczenia z baza danych.");
  */
  Connection c = null;
  
  try {
    // Wymagane parametry polaczenia z baza danych:
    // Pierwszy - URL do bazy danych:
    //        jdbc:dialekt SQL:serwer(adres + port)/baza w naszym przypadku:
    //        jdbc:postgres://pascal.fis.agh.edu.pl:5432/baza
    // Drugi i trzeci parametr: uzytkownik bazy i haslo do bazy 
    c = DriverManager.getConnection("jdbc:postgresql://pascal.fis.agh.edu.pl:5432/u9wajda",
                                    "u9wajda", "9wajda");
  } catch (SQLException se) {
    System.out.println("Brak polaczenia z baza danych, wydruk logu sledzenia i koniec.");
    se.printStackTrace();
    System.exit(1);
  }
if (c != null) {
    System.out.println("Polaczenie z baza danych OK ! ");
    try { 
      //  Wstawianie rekordow do bazy danych
      //  Wykorzystanie metody executeUpdate()                                             
       PreparedStatement pst = c.prepareStatement( "UPDATE lab04.uczestnik SET email = ? WHERE id_uczestnik = ?" );
       pst.setString(1, "new@email.pl") ;
       pst.setInt(2, 2);
       int rows ;
       rows = pst.executeUpdate();

        System.out.println("Uczestnik id=2 po zmianie na new@email.pl");

       pst = c.prepareStatement("SELECT id_uczestnik, email FROM lab04.uczestnik WHERE id_uczestnik = 2", ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

        ResultSet rs ;
        rs = pst.executeQuery();
        while (rs.next())  {
            String id    = rs.getString("id_uczestnik") ;
            String email    = rs.getString("email") ;
            System.out.println(id + " " + email) ;   }
       rs.close();

       pst.close();    
     }
     catch(SQLException e)  {
	     System.out.println("Blad podczas przetwarzania danych:"+e) ;   }	     
 
 }
  else
    System.out.println("Brak polaczenia z baza, dalsza czesc aplikacji nie jest wykonywana.");   }
} 
