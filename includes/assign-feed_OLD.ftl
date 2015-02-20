<#attempt>
  <#assign id=(page.params.id)!'' />
   <#if id?starts_with('b') >
    <#assign id=(id?substring(1))!'' />
   </#if>
<#recover>
  <#assign id='' />
</#attempt>


<#if (page.id?starts_with("topstory"))>	
<#--assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/news.xml")/-->
<#--assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=1")/-->
    <#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/detail.xml?id=${id}")/>

<#elseif (page.id?starts_with("franchise"))>
<#--assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=1")/-->
    <#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/detail.xml?id=${id}")/>

<#elseif (page.id?starts_with("marc_malkin"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=2")/>
<#elseif (page.id?starts_with("answer_bitch"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=3")/>
<#elseif (page.id?starts_with("lyons_den"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=5")/>
<#elseif (page.id?starts_with("party_girl"))>			
	<#assign feed=tool.content.getRssFeed("http://www.eonline.com/syndication/feeds/partners/mobile/iloop/news.xml?cat=8")/>
<#elseif (page.id?starts_with("celeb_pics.ftl"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=1")/>
	<#assign feed1=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=2")/>
	<#assign feed2=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=3")/>
	<#assign feed3=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=4")/>
	<#assign feed4=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=5")/>
	<#assign feed5=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=6")/>
	<#assign feed6=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=7")/>
	<#assign feed7=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=8")/>
<#elseif (page.id?starts_with("celeb_pics_photo"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=1")/>
<#elseif (page.id?starts_with("fashion_photo"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=2")/>
<#elseif (page.id?starts_with("pp_la_photo"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=3")/>
<#elseif (page.id?starts_with("pp_ny_photo"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=4")/>
<#elseif (page.id?starts_with("pp_vegas_photo"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=5")/>
<#elseif (page.id?starts_with("pp_miami_photo"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=6")/>
<#elseif (page.id?starts_with("pp_global_photo"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=7")/>
<#elseif (page.id?starts_with("sneak_peeks_photo"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/gallery.xml?cat=8")/>
<#elseif (page.id?starts_with("watch_kristin"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=6")/>
<#elseif (page.id?starts_with("tv_celebs.ftl"))>			
	<#assign feed1=tool.content.getRssFeed("http://www.eonline.com/syndication/feeds/partners/mobile/iloop/wwk.xml")/>
	<#assign feed2=tool.content.getRssFeed("http://www.eonline.com/syndication/feeds/partners/mobile/iloop/awful.xml")/>
<#elseif (page.id?starts_with("awful_truth"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=7")/>
<#elseif (page.id?starts_with("tv_schedule"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/schedule.xml")/>
<#elseif (page.id?starts_with("awards.ftl"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/redcarpet.xml")/>
<#elseif (page.id?starts_with("awards_detail.ftl"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/redcarpet.xml")/>
<#elseif (page.id?starts_with("redcarpet_photo"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/redcarpet_pics.xml")/>
<#elseif (page.id?starts_with("video"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/video/index.xml")/>
<#elseif (page.id?starts_with("movies"))>
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=9")/>
<#elseif (page.id?starts_with("red_carpet"))>			
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=1")/>
<#else>
	<#assign feed=tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?cat=1")/>
</#if>