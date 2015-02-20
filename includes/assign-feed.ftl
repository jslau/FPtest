<#-- Strip the prefix "b" in guid -->
<#attempt>
    <#assign id=(page.params.id)!'' />
    <#if id?starts_with('b') >
       <#assign id=(id?substring(1))!'' />
    </#if>
<#recover>
    <#assign id='' />
</#attempt>

<#attempt>
  <#assign currentLang = .globals.currentCountry />
<#recover>
  <#assign currentLang = 'uk' />
</#attempt>


<#if page.id?contains("article") >
    <#-- news or blog article -->
    <#--<#assign article = tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/iphone/news/detail.xml?id=${id}")/>-->
    <#assign article = tool.content.getRssFeed("http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/common/news/news_detail.jsp?blogID=${id}&ed=${currentLang}")/>
    <#assign feedUrl = f.feeds[category] />
    <#attempt>
      <#if tag!="">
        <#assign feed = tool.content.getRssFeed("${feedUrl}&categories=${tag}")/>
      <#else>
        <#assign feed = tool.content.getRssFeed("${feedUrl}")/>
      </#if>
    <#recover>
    </#attempt>
<#elseif (page.id?contains("photo_list"))>
    <#-- photo gallery -->
    <#assign feedUrl="http://" + page.request.getServerName() + "/xml/photosfeed.ftl" />
    <#assign feed = tool.content.getRssFeed("${feedUrl}")/>
<#elseif (page.id?contains("photo"))>
    <#-- photo  -->
    <#assign feedUrl = f.feeds["gallery"] + "${gid}" />
    <#assign feed = tool.content.getRssFeed("${feedUrl}")/>
<#elseif (page.id?contains("video"))>
    <#attempt>
       <#-- video gallery -->
       <#assign feedUrl = f.feeds[category] />
       <#assign feed = tool.content.getRssFeed("${feedUrl}")/>
    <#recover>
    </#attempt>
</#if>