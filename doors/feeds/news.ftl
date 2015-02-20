<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/", "xsi":"http://www.w3.org/2001/XMLSchema-instance", "xsd":"http://www.w3.org/2001/XMLSchema"}>
<#assign pg = page.params.page!"1" />
<#assign pageSize = 14 />
<#assign counter = 0 />
    
<#attempt>
    <#assign paramCCUrl = page.params.cc />
    <#if (paramCCUrl == 'GB')>
        <#assign paramUrl = 'GB' />
        <#assign feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk' />
    <#elseif (paramCCUrl == 'FR')>
        <#assign paramUrl = 'FR' />
        <#assign feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=fr' />
    <#elseif (paramCCUrl == 'IT')>
        <#assign paramUrl = 'IT' />
        <#assign feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=it' />
    <#elseif (paramCCUrl == 'DE')>
        <#assign paramUrl = 'DE' />
        <#assign feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=de' />
    <#elseif (paramCCUrl == 'ND')>
        <#assign paramUrl = 'ND' />
        <#assign feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk' />
    <#else>
        <#assign paramUrl = 'ND' />
        <#assign feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk' />
    </#if>
<#recover>
    <#assign paramUrl = 'ND' />
    <#assign feedNews = 'http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/news.xml?ed=uk' />
</#attempt>

<#assign feedLink = feedNews + '&page=' + pg + '&pageSize=' + pageSize />
<#assign feed = tool.content.parseXML(feedLink) />

<root>
  <#list feed.rss.channel.item  as item>
      <#--
      <#assign stringTitle = item.title />
      <#if (stringTitle?length > 35) >
         <#assign trimedTitle = stringTitle?string?substring(0, 36) + '...' />
      <#else>
         <#assign trimedTitle = stringTitle />
      </#if>
      -->
      <item>
        <title>${item.title?html}</title>
        <#--<title>${trimedTitle?html}</title>-->
        <guid>${item.guid}</guid>
        <#assign resizeLink  = item["eonline:resizerlink"]?replace("$width","280")?replace("$height","280") />
        <image>${resizeLink}</image>
        <param>${paramUrl}</param>
      </item>
    <#assign counter=counter+1/>
    <#if counter == pageSize>
      <#break>
    </#if>    
  </#list>
</root>