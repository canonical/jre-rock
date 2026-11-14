import java.util.random.RandomGenerator;

public class RandomDefault {
    public static void main(String[] args) {
        RandomGenerator.getDefault().nextLong();
        RandomGenerator.of("L64X128MixRandom").nextLong();
        System.out.println("ok");
    }
}
