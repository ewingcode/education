package test.com.core.jdbc.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "test")
public class TestVO {

	private Integer id;

	private String name;

	private String address;

	private Integer phone;
	private String des;
	private Date creation;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	public Integer getId() {
		return id;
	}

	@Column(name = "creation")
	public Date getCreation() {
		return creation;
	}

	@Column(name = "address")
	public String getAddress() {
		return address;
	}

	@Column(name = "des")
	public String getDes() {
		return des;
	}

	@Column(name = "name")
	public String getName() {
		return name;
	}

	@Column(name = "phone")
	public Integer getPhone() {
		return phone;
	}

	public void setCreation(Date creation) {
		this.creation = creation;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPhone(Integer phone) {
		this.phone = phone;
	}
}
