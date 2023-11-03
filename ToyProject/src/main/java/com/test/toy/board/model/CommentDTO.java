package com.test.toy.board.model;

import lombok.Data;

@Data
public class CommentDTO {
	private String seq;
	private String content;
	private String regdate;
	private String id;
	private String bseq;

	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBseq() {
		return bseq;
	}

	public void setBseq(String bseq) {
		this.bseq = bseq;
	}
}
