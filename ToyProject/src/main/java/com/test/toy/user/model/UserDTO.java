package com.test.toy.user.model;

import lombok.Data;

//Lombok

@Data
public class UserDTO {
	// 변수명 동일시하기

	private String id;
	private String pw;
	private String name;
	private String email;
	private String lv;
	private String pic;
	private String intro;
	private String ing;

}
