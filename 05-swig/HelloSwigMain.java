
public class HelloSwigMain {
    static {
        System.loadLibrary("hello_swig");
    }

    public static void main(String argv[]) {
        String greeting = hello_swig.greet_swig("JNI User".getBytes());
        System.out.println(greeting);
    }
}