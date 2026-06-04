class MyThread extends Thread {

    public void run() {

        for (int i = 1; i <= 5; i++) {

            System.out.println(
                    getName()
                            + " : Message "
                            + i);

            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

public class ThreadCreation {

    public static void main(String[] args) {

        MyThread t1 = new MyThread();
        MyThread t2 = new MyThread();

        t1.start();
        t2.start();
    }
}