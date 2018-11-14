package kr.or.ddit.web.useragent;

public enum SystemType {
	DESKTOP(new String[] {"windows nt", "linux"}, "데스크탑"), 
	MOBILE(new String[] {"android", "iphone"}, "모바일"),
	OTHER(new String[] {}, "기타등등");
	
	private String[] keywords;
	private String SystemName;

	private SystemType(String[] keywords, String systemName) {
		this.keywords = keywords;
		this.SystemName = systemName;
	}
	
	public String getSystemName() {
		return SystemName;
	}
	
	public boolean matches(String userAgent){
		userAgent = userAgent.toLowerCase();
		boolean result = false;
		for(String word:keywords) {//String[]이기 때문에
			result = userAgent.contains(word);
			if(result) break;
		}
		return result;
	}
	
	public static SystemType getSystemType(String userAgent){
		SystemType result = OTHER;
		for(SystemType tmp:values()) {
			if(tmp.matches(userAgent)) {
				result=tmp;
				break;
			}
		}
		return result;
	}
	
	
}
