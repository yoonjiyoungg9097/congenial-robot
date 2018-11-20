package kr.or.ddit.web.model2;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.List;

public class FileList {
	public List<File> getFileList(String fileNmae) {
		File folder= new File(fileNmae);
		
		File[] folderList=folder.listFiles();
		System.out.println(folderList.length);
		List<File> filist=new ArrayList<>();
		if(!folder.getName().equals("webStudy01")) {
			filist.add(folder.getParentFile());
		}
		if (folder.isDirectory()) {
			for(File tmp:folderList) {
				filist.add(tmp);
			}
			
		}
		
		return filist;
		}
}
