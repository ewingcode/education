package test.com.core.jdbc.vo;

import java.lang.reflect.Field;

public class B {
	C c;
	public B() {

		System.out.println("B");
		c = new C(this);
	}
	public void println(){
		c.getValue();
	}

	class C {
		public Object o;
		public C(Object o) {
			this.o=o;
			System.out.println("c");
		}
		public Object getValue(){
			try {
				Field filed = o.getClass().getDeclaredField("a");
				Object y = (Object)filed.get(o); 
				System.out.println("value:"+y);
			} catch ( Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			return null;
		}
	}
}
