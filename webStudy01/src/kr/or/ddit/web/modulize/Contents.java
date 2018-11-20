package kr.or.ddit.web.modulize;

import org.apache.commons.lang3.StringUtils;

public enum Contents {
	
	GUGUDAN("/01/gugudanForm.html"),
	GUGUDANPROCESS("/gugudan.do"),
	LYRICS("/02/musicForm.jsp"),
	CALENDAR("/04/calendar.jsp"),
	IMAGE("/imageForm");
	
	private String url;
	
	//생성자
	Contents(String url){
		this.url = url;
	}
	
	public String getUrl() {
		return this.url;
	}
	
	//쿼리스트링으로 command=값 형식으로 주었기 때문에 command를 통해 값을 가져온다
	public static Contents getContents(String command) { 
		//기본으로 구구단으로 설정해주었다
		Contents contents = GUGUDAN;
		if(StringUtils.isNotBlank(command)) {
			for(Contents tmp:values()) {
				if(command.toUpperCase().equals(tmp.name())) {
					contents = tmp;
					break;
				}
			}
		}
		return contents;
	}
	
}
