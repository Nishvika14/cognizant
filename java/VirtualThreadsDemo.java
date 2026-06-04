public class VirtualThreadsDemo {

    public static void main(String[] args)
            throws Exception {

        long start =
                System.currentTimeMillis();

        for(int i=1;i<=100000;i++){

            Thread.startVirtualThread(
                    () -> {
                        System.out.print("");
                    });
        }

        long end =
                System.currentTimeMillis();

        System.out.println(
                "Time = "
                        + (end-start)
                        + " ms");
    }
}