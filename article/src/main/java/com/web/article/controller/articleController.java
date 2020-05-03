package com.web.article.controller;

import org.json.JSONArray;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
@Controller
public class articleController {
	@RequestMapping({"/scrapweb/{query}"})
	@ResponseBody
	public String webscrap(HttpServletRequest request,@PathVariable("query") String querystring) throws IOException
	{
		JSONObject jsonobj = new JSONObject();
		Document doc = Jsoup.connect("https://www.thehindu.com/search/?q="+querystring+"&order=DESC&sort=publishdate&pd=yesterday&ct=text").get();
		 Elements mainstory = doc.getElementsByClass("story-card");
		 JSONArray jsonarr = new JSONArray();
		 for (Element element : mainstory) {
			 Elements storyele  = element.select("div.story-card-news");
			 JSONObject singlearticle = new JSONObject();
			 singlearticle.put("date",storyele.select("span.dateline").text());
			 singlearticle.put("link", storyele.select("a").attr("href").toString());
			 singlearticle.put("article", storyele.select("a").text());
			 jsonarr.put(singlearticle);
		 }
		 jsonobj.put("data", jsonarr);
		 return jsonobj.toString();
	}
	@RequestMapping({"getarticles/{month}"})
	@ResponseBody
	public String getarticle(@PathVariable("month") String month) throws IOException
	{
		JSONObject jsonobj = new JSONObject();
		 JSONArray jsonarr = new JSONArray();
		Document doc = Jsoup.connect("https://www.thehindu.com/archive/").get();
		Element yearele = doc.select("#archiveWebContainer").select("ul.archiveMonthList").get(11);
		Element listele = yearele.select("li > a:contains("+month+")").first();
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
						Elements achele = tddocs.select("#section_10").select(".archive-list").select("li").select("a");
						for(Element ach:achele)
						{
							 JSONObject singlearticle = new JSONObject();
							 singlearticle.put("link",ach.attr("href"));
							 singlearticle.put("article", ach.text());
							 jsonarr.put(singlearticle);
						}
					}
				//	
				}
			}
			  jsonobj.put("data", jsonarr);
			 return jsonobj.toString();
	}
	@RequestMapping({"/articles"})
	public String articles(HttpServletRequest request)
	{
		return "articlebyyear";
	}
	@RequestMapping({"/filter"})
	public String filter(HttpServletRequest request)
	{
		return "filter";
	}
}
