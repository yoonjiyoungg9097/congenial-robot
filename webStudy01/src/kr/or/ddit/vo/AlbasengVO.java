package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.Arrays;

public class AlbasengVO implements Serializable{//직렬화 가능 바이트 배열로 변환가능
	private String code; //PK
	private String name;
	private Integer age;
	private String tel;
	private String address;
	private String grade;
	private String gender;
	private String[] license;
	private String career;
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String[] getLicense() {
		return license;
	}
	public void setLicense(String[] license) {
		this.license = license;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	
	
	
	@Override
	public int hashCode() { 
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) { //코드가 같아야지만 같은 사람으로 취급 equals가 없다면 주소로 비교해준다??
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		AlbasengVO other = (AlbasengVO) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "AlbasangVO [name=" + name + ", age=" + age + ", tel=" + tel + ", address=" + address + ", grade=" + grade
				+ ", gender=" + gender + ", license=" + Arrays.toString(license) + ", career=" + career + "]";
	}
	
	
}
