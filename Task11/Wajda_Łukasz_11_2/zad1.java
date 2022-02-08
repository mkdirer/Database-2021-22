import java.sql.*;

class zad1 {

    public static void main( String[] args ) {

        Connection conn = null;

        try {
            conn = DriverManager.getConnection("jdbc:postgresql://pascal.fis.agh.edu.pl:5432/u9wajda", "u9wajda", "9wajda" );
        }
        catch (SQLException e) {
            System.err.println("Nie polaczylo z baza");
            System.exit(1);
        }

        if( conn != null ) {
            System.out.println("Udalo sie");

            String instruction = "";
            instruction += "SELECT imie, nazwisko, opis \n";
            instruction += "    FROM lab04.uczest_kurs uk \n";
            instruction += "    JOIN lab04.uczestnik uc ON uc.id_uczestnik = uk.id_uczest \n";
            instruction += "    JOIN lab04.kurs_opis ko ON ko.id_kurs = uk.id_kurs \n";
            instruction += "ORDER BY \n";
            instruction += "    uk.id_kurs, \n";
            instruction += "    nazwisko, \n";
            instruction += "    imie; \n";
            try {
                PreparedStatement statement = conn.prepareStatement( instruction, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE );
                ResultSet rs = statement.executeQuery();

                String imie;
                String nazwisko;
                String opis;

                while( rs.next() ) {
                    imie = rs.getString("imie");
                    nazwisko = rs.getString("nazwisko");
                    opis = rs.getString("opis");

                    System.out.println( imie + "  " + nazwisko + "  " + opis);
                }
                rs.close();
                statement.close();
            }
            catch( SQLException e ) {
                System.err.println("Blad podczas przetwarzania" + e);
            }
        }
        else {
            System.err.println("Nie ma polaczenia");
        }
    }
}