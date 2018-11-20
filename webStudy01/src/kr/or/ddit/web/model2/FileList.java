package kr.or.ddit.web.model2;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;

public class FileList {
	//모든파일을 가져오기 위한 메서드
   public List<File> getFileList(String filepath) {
      File folder= new File(filepath);//받아온 경로의 파일객체생성
      
      File[] folderList=folder.listFiles();//그 파일안에 있는 모든 파일을 가져옴 listFiles()의 반환타입은 파일[]임
//      System.out.println(folderList.length);
      List<File> filist=new ArrayList<>();
      if(!folder.getName().equals("webStudy01")) {//웹스터디01위로는 보여주면안되기떄문에 폴더의 이름이 webStudy01이 아닌것 뒤로가기
         //웹스터디01경우 이로직은 안탐 
         //상위폴더 생성해주는곳
         filist.add(folder.getParentFile());//만약 이 조건에 들어오면 경로의 상위폴더를 리스트0번째에 추가
      }
      if (folder.isDirectory()) {//만약 생성해준 파일객체가 폴더면 true아니면 false
         for(File tmp:folderList) {
            filist.add(tmp);
         }//폴더일경우 그 폴더에있는 모든 파일들을 리스트에 담아줌
         
      }
      return filist;//담아준 값을 반환
      }
   
   
   //파일을 삭제해주기 위한 메소드
   public void deleteFile(File file){
	   //해당경로안에 해당파일이 있을땐 그 값(파일)을 담아주고
	   //해당경로안에 해당파일이 없을때 그 파일을 생성해준다
	   boolean result = file.delete(); //파일을 삭제해주는 메소드
	   
	   if(result) {//파일이 정상적으로 되었는지 확인
		   System.out.println("삭제성공!!");
	   }else {
		   System.out.println("삭제실패");
	   }
   }
   
   //파일을 복사해주기 위한 메소드
   public void copyFile(File file){
	   //해당경로안에 해당파일이 있을땐 그 값(파일)을 담아주고
	   //해당경로안에 해당파일이 없을때 그 파일을 생성해준다
	   //복사할 파일을 생성하는 부분 - 선택한 파일의 부모파일의 절대경로를 가져와서 \copy를 붙여주소 파일이름을 붙여준다
	   //만약 login안에 있는 logout.jsp파일을 선택했을때 부모파일인 login의 절대경로를 가져와 \copy를 붙여줘서 copylogout.jsp로 복사된다
	   File copyFile = new File(file.getParentFile().getAbsolutePath()+"\\copy"+file.getName()); 
	   try(//try-with절 close를 하나하나 해주지 않아도 된다
			   FileInputStream fis = new FileInputStream(file);
			   FileOutputStream fos = new FileOutputStream(copyFile);
			   ) {
		
		   int readBuffer = 0;
           byte [] buffer = new byte[512];
           while((readBuffer = fis.read(buffer)) != -1) {//위에서 생성된 파일에 선택한 값을 하나하나 넣어주는 부분
               fos.write(buffer, 0, readBuffer);
           }
	   }catch (Exception e) {
		   e.printStackTrace();
	   }
	}
   
   
   //파일을 이동해주기 위한 메소드
   public void moveFile(File file, String movePath){
	   System.out.println("야야야야야야ㅑ");
	   System.out.println(movePath);
	   File moveFile = new File(movePath+file.getName());
	   System.out.println(moveFile.getAbsolutePath());
	   file.renameTo(moveFile);
   }
}







