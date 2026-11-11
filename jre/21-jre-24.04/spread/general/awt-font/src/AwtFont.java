import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

public class AwtFont {
    public static void main(String[] args) {
        BufferedImage img = new BufferedImage(64, 16, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = img.createGraphics();
        g.setFont(new Font(Font.SANS_SERIF, Font.PLAIN, 12));
        g.drawString("hello", 1, 12);
        g.dispose();
        System.out.println("rendered");
    }
}
