<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>

<#-- news, videos, photos, www, awful, eshows, red carpet, movies -->
   <#assign category = "Marketing Brick" />
   <#assign feed = tool.content.getRssFeed("http://www.eonline.com/static/syndication/feeds/iphone/marketing_bricks/index.xml") />

<section>
 <name>${category}</name>

 <#list feed.rss.channel.image as item >
   <item>
    <guid></guid>
    <title>${item.title?html}</title>
    <link>${item.link}</link>
    <imgurl>${item.url}</imgurl>
   </item>
 </#list>
</section>