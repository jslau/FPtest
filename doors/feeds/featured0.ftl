<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<#assign src=page.params.xml/>
<#assign feed=tool.content.parseXML(src)/>
<v_iphone>${feed.rss.channel.item["eonline:iphone_videourl"]}</v_iphone>
<v_and_lq>${feed.rss.channel.item["eonline:android_lq_videourl"]}</v_and_lq>
<v_and_mq>${feed.rss.channel.item["eonline:android_mq_videourl"]}</v_and_mq>
<v_and_hq>${feed.rss.channel.item["eonline:android_hq_videourl"]}</v_and_hq>