package com.web.article.test;

import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

public abstract class test {

	public static void main(String[] args) throws IOException {
		Document doc = Jsoup.connect("https://www.thehindu.com/archive/").get();
		Element yearele = doc.select("#archiveWebContainer").select("ul.archiveMonthList").get(1);
		Element listele = yearele.select("li > a:contains(Jan)").first();
			Document docs = Jsoup.connect(listele.attr("href")).get();
			Elements monthdata = docs.getElementsByClass("archiveTable").select("tr");
			for(Element eachdate : monthdata)
			{
				Elements eachtd = eachdate.select("td");
				for(Element td:eachtd)
				{
					String tdurl = td.select("a").attr("href").trim();
					if(!tdurl.isEmpty())
					{
						Document tddocs = Jsoup.connect(tdurl).get();
						System.out.println(">>> "+tddocs.select("#section_10").select(".archive-list").select("li").first());
					}
				//	
				}
			}

	}

}
