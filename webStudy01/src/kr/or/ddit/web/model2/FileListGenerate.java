package kr.or.ddit.web.model2;

import java.io.File;

public class FileListGenerate {
	
	// url을 매개변수로 받아 거기에 해당하는 폴더를 생성하고
	public File[] getFileList(String url) {
		File folder = new File(url);
		return folder.listFiles();
	}
}
