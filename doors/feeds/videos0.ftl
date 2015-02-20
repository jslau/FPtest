<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/", "xsi":"http://www.w3.org/2001/XMLSchema-instance", "xsd":"http://www.w3.org/2001/XMLSchema"}>

<#attempt>
  <#assign pg = page.params.page />
<#recover>
  <#assign pg = '1' />
</#attempt>

<#if (pg == '1')>
  <#assign counter = 0 />
  <#attempt>
      <#assign paramCCUrl = page.params.cc />
      <#if (paramCCUrl == 'GB')>
          <#assign paramUrl = 'GB' />
          <#assign feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed' />
      <#elseif (paramCCUrl == 'FR')>
          <#assign paramUrl = 'FR' />
          <#assign feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=fr_row_intl_video_masterfeed' />
      <#elseif (paramCCUrl == 'IT')>
          <#assign paramUrl = 'IT' />
          <#assign feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=it_row_intl_video_masterfeed' />
      <#elseif (paramCCUrl == 'DE')>
          <#assign paramUrl = 'DE' />
          <#assign feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=de_row_intl_video_masterfeed' />
      <#elseif (paramCCUrl == 'ND')>
          <#assign paramUrl = 'ND' />
          <#assign feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed' />
      <#else>
          <#assign paramUrl = 'ND' />
          <#assign feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed' />
      </#if>
  <#recover>
      <#assign paramUrl = 'ND' />
      <#assign feedVideos = 'http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed' />
  </#attempt>

  <#assign feedLink = feedVideos />
  <#assign feed = tool.content.parseXML(feedLink) />
  <root>
    <#list feed.rss.channel.item  as item>
        <#assign counter = counter + 1 />
        <item>
          <category>Video</category>
          <title>${item.title?html}</title>
          <guid>${counter}</guid>
          <image>${item["eonline:image_thumbnail"]}</image>
          <#assign feedLink = item["eonline:videoFeed"]?replace('http://syndication.eonline.com/syndication/feeds/partners/mobile/iloop/row_intl_website/videos.xml?','') />
          <program>${feedLink?html}</program>
          <param>${paramUrl}</param>
        </item>
    </#list>
  </root>
</#if>

<#--
Germany (de) http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=de_row_intl_video_masterfeed
France (fr) http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=fr_row_intl_video_masterfeed
UK (uk) http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=uk_row_intl_video_masterfeed
IT (it) http://syndication.eonline.com/syndication/feeds/mobile/common/config.xml?appEd=it_row_intl_video_masterfeed
-->