package kr.or.ddit.web.calculate;

@FunctionalInterface
interface RealOperator{
	public int operate(int left, int right);
}//외부의 다른 패키지에서는 사용불가능