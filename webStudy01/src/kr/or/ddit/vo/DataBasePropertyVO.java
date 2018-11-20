package kr.or.ddit.vo;

import java.io.Serializable;

public class DataBasePropertyVO implements Serializable{
	private String property_name;
	private String property_value;
	private String description;
	
	public String getProperty_name() {
		return property_name;
	}
	public void setProperty_name(String property_name) {
		this.property_name = property_name;
	}
	public String getProperty_value() {
		return property_value;
	}
	public void setProperty_value(String property_value) {
		this.property_value = property_value;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public int hashCode() {//두 객체가 같은 객체인지 확인하는 Method
		final int prime = 31;
		int result = 1;
		result = prime * result + ((description == null) ? 0 : description.hashCode());
		result = prime * result + ((property_name == null) ? 0 : property_name.hashCode());
		result = prime * result + ((property_value == null) ? 0 : property_value.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {//두 객체의 내용이 같은지 확인하는 Method
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DataBasePropertyVO other = (DataBasePropertyVO) obj;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		if (property_name == null) {
			if (other.property_name != null)
				return false;
		} else if (!property_name.equals(other.property_name))
			return false;
		if (property_value == null) {
			if (other.property_value != null)
				return false;
		} else if (!property_value.equals(other.property_value))
			return false;
		return true;
	}
	
	@Override
	public String toString() {//상태 확인 방법제공
		return "DataBasePropertyVO [property_name=" + property_name + ", property_value=" + property_value
				+ ", description=" + description + "]";
	}
	
	
}
