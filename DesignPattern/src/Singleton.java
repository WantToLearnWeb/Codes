/**
 * Created by halcyonSure on 2020/1/6.
 */

// 方式一：枚举
public enum Singleton {
    Instance("hello, world");

    private String test;

    Singleton(String test) {
        this.test = test;
    }

    public String test() {
        return test + getClass().getName() + "@" + Integer.toHexString(hashCode());
    }
}

// 方式二：懒汉模式
class Singleton2 {
    private static volatile Singleton2 instance;

    private Singleton2() {}

    public static Singleton2 getInstance() {
        if (instance == null) {
            synchronized (Singleton2.class) {
                if (instance == null) {
                    instance = new Singleton2();
                }
            }
        }
        return instance;
    }
}

// 方式三：饿汉模式
class Singleton3 {
    private static Singleton3 instance = new Singleton3();

    private Singleton3() {}

    public static Singleton3 getInstance() {
        return instance;
    }
}

class Test {
    public static void main(String[] args) {
        System.out.println(Singleton.Instance.test());
        System.out.println(Singleton.Instance.test());
        System.out.println(Singleton2.getInstance().toString());
        System.out.println(Singleton2.getInstance().toString());
        System.out.println(Singleton3.getInstance().toString());
        System.out.println(Singleton3.getInstance().toString());
    }
}
