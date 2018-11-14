package kr.or.ddit.web.calculate;

public enum Operator {
	
	
	ADD("+", new RealOperator() {
		@Override
		public int operate(int left, int right) {
			return left + right;
		}
	}),
	MINUS("-", (left, right)->{return left-right;}),
	MULTIPLY("*", (a, b)->{return a*b;}),//파라미터명은 중요하지 않다
	DIVIDE("/", (c,d)->{return c/d;});	//각각 value를 가짐 각각 Operator타입
	
	
	private String sign;
	private RealOperator realOperator;
	Operator(String sign, RealOperator realOperator){
		this.sign = sign;
		this.realOperator = realOperator;
	}
	public String getSign(){
		return this.sign;
	}
	public int operate(int left, int right) {
		return realOperator.operate(left, right);
	}
}
