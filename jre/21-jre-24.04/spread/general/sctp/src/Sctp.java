import com.sun.nio.sctp.SctpChannel;
import java.net.SocketException;

public class Sctp {
    public static void main(String[] args) throws Exception {
        try {
            SctpChannel.open().close();
            System.out.println("opened");
        } catch (SocketException e) {
            // the native library loaded, but the kernel has no sctp support
            System.out.println("loaded: " + e.getMessage());
        }
    }
}
