<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>

   <#global servername = "http://" + page.request.getServerName() />
   <#assign feed = tool.content.getRssFeed(servername + "/xml/photosfeed/photosfeed_pre.ftl") />

<section>
 <name>Photos</name>
 <#assign i = 0 />
 <#list feed.section.item?sort_by('displayorder') as item >

  <#-- Resize image -->
  <#assign imgfull = item.imgurl />
   <item>
    <guid>${item.guid}</guid>
    <title>${item.title?html}</title>
<#--    <displayorder>${item.displayorder}</displayorder> -->
     <imgurl>${item.imgurl}</imgurl>
    <linkurl>${item.linkurl}</linkurl>
   </item>
   <#assign i = i + 1 />
 </#list>
</section>