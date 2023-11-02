package com.test.toy.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Random;

import com.test.toy.DBUtil;

public class Dummy {
	public static void main(String[] args) {

		try {
			Connection conn = null;
			PreparedStatement stat = null;

			conn = DBUtil.open();

			String sql = "insert into tblBoard (seq, subject, content, regdate, readcount, id) values (seqBoard.nextVal, ?, '내용', default, default, 'hong')";

			String temp = "최근 국내 과자시장의 트렌드가 변하고 있다. 아이들만을 위한 과자보다 어른들을 타깃으로 한 과자가 더 주목받고 있다. 저출산 시대가 수년째 계속되면서 과자 제조사들은 신제품 개발 과정에서 이런 점을 고려하고 있다. 코로나19 이후 '홈술' 문화의 확대로 안주용 과자를 찾는 수요가 급증하며 '어른용 과자' 신제품 경쟁에 불이 붙었다는 분석이다.3일 업계에 따르면 국내 과자 시장에는 술과 잘 어울리는 안주용 과자 신제품이 쏟아지고 있다. 농심(004370)의 '먹태깡'은 올해 6월 출시돼 인기를 끌고 있는 대표 어른 과자다. 먹태깡은 출시 9주간 누적 424만봉이 팔렸다. 먹태깡의 인기에 농심은 지난달부터 생산량을 기존 대비 50% 늘렸지만 여전히 품귀현상을 빚고 있다. 특히 먹태깡은 맥주와 함께 술안주로 먹는 소비자들이 많다. 대표적인 술안주 중 하나인 먹태의 맛을 간편한 과자로 느낄 수 있어 인기가 계속되고 있다. 실제 SNS 게시물의 상당수는 먹태깡을 맥주와 함께 즐기는 모습을 담고 있다.";
			String[] templist = temp.split(" ");

			Random rnd = new Random();

			stat = conn.prepareStatement(sql);

			for (int i = 0; i < 250; i++) {

				String subject = "";

				for (int j = 0; j < 5; j++) {
					subject += templist[rnd.nextInt(templist.length)] + " ";
				}

				stat.setString(1, subject);
				stat.executeUpdate();
				System.out.println(i);
			}

			stat.close();
			conn.close();
			
		} catch (Exception e) {
			System.out.println("Dummy.main()");
			e.printStackTrace();
		}
	}
}
