package isia.servicios;

import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

import static java.lang.Thread.sleep;

/**
 * @author galvez
 */
public class ServiciosISIA {

    public static final String NIF_STRING_ASOCIATION = "TRWAGMYFPDXBNJZSQVHLCKE";

    /**
     * Devuelve un NIF completo a partir de un DNI. Es decir, añade la letra del
     * NIF. Procede de la Wikipedia.
     *
     * @param dni dni al que se quiere añadir la letra del NIF
     * @return NIF completo.
     */
    public static void main(String[] args) {

        File sal = new File("sal.jpg");
        try {
            Files.write(sal.toPath(), nubeEtiquetas("https://es.wikipedia.org/wiki/Lenin"));
        } catch (IOException ex) {
            ex.printStackTrace();
        }

    }

    public static char letraDNI(int dni) {
        return NIF_STRING_ASOCIATION.charAt(dni % 23);
    }

    static MotorDeCloudTag embed = new MotorDeCloudTag();

    public static byte[] nubeEtiquetas(String URL) {

        try {
            String[] availableFontFamilyNames = GraphicsEnvironment
                .getLocalGraphicsEnvironment()
                .getAvailableFontFamilyNames();
            System.err.println("!!!!! getAvailableFontFamilyNames = "
                + Arrays.stream(availableFontFamilyNames).collect(Collectors.joining()));
        } catch (Exception ex) {
            Logger.getLogger(ServiciosISIA.class.getName()).log(Level.SEVERE, null, ex);
        }


        byte[] fileContent = new byte[100];
        System.out.println("Retornando...\n");
        try {
            File fi = new File(MotorDeCloudTag.fichero);
            if (fi.exists()) Files.delete(fi.toPath());
            embed.setURL(URL);
            embed.draw();
            int i = 0;
            while (!fi.canRead()) {
                sleep(1000);
                if (++i == 30) throw new Exception("Tiempo agotado.");
                System.out.println("Durmiendo...\n");
            }
            fileContent = Files.readAllBytes(fi.toPath());
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return fileContent;
    }

}
