<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<#-- news, videos, photos, www, awful, eshows, red carpet, movies -->
   <#assign category = "More" />
<section>
<name>${category}</name>
<listurl>
<#-- ${servername}/article_list.ftl?category=${category}
--></listurl>
<item>
<title>Red Carpet</title>
<linkurl>${servername}/article_list.ftl?category=Red Carpet</linkurl>
     <imgurl>
      <#if display == "SD">    ${servername}/images/120_LFRC_Smartphone_Thumbnails.jpg
      <#elseif display == "HD">${servername}/images/240_LFRC_Smartphone_Thumbnails.jpg
      <#elseif display == "LG">${servername}/images/148_LFRC_Smartphone_Thumbnails.jpg
      <#else>                  ${servername}/images/148_LFRC_Smartphone_Thumbnails.jpg
      </#if>
    </imgurl>
</item>

<item>
<title>Movie Reviews</title>
<linkurl>${servername}/article_list.ftl?category=Movie Reviews</linkurl>
     <imgurl>
      <#if display == "SD">    ${servername}/images/120_Movie_Apps_Icons.jpg
      <#elseif display == "HD">${servername}/images/240_Movie_Apps_Icons.jpg
      <#elseif display == "LG">${servername}/images/148_Movie_Apps_Icons.jpg
      <#else>                  ${servername}/images/148_Movie_Apps_Icons.jpg
      </#if>
    </imgurl>
</item>
<#if !(device == 'Android Tablet') >
<item>
<title>E! Applications</title>
<linkurl>${servername}/apps_list.ftl?category=Apps</linkurl>
     <imgurl>
      <#if display == "SD">    ${servername}/images/120_Apps_Icons.jpg
      <#elseif display == "HD">${servername}/images/240_Apps_Icons.jpg
      <#elseif display == "LG">${servername}/images/148_Apps_Icons.jpg
      <#else>                  ${servername}/images/148_Apps_Icons.jpg
      </#if>
    </imgurl>
</item>
</#if>
<item>
<title>TV Schedule</title>
<linkurl>${servername}/tv_schedule.ftl?category=TV Schedule</linkurl>
     <imgurl>
      <#if display == "SD">    ${servername}/images/120_Schedule_Smartphone_Thumbnails.jpg
      <#elseif display == "HD">${servername}/images/240_Schedule_Smartphone_Thumbnails.jpg
      <#elseif display == "LG">${servername}/images/148_Schedule_Smartphone_Thumbnails.jpg
      <#else>                  ${servername}/images/148_Schedule_Smartphone_Thumbnails.jpg
      </#if>
    </imgurl>
</item>
</section>