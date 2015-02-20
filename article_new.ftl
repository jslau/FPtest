<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=false showfooter=false>

<#attempt>

    <#-- Delimiter separating elements in next article array -->
    <#assign d1 = tool.text.delimiterElement />

    <#-- Initialize next article array -->
    <#assign link  = '' />
    <#assign title = '' />
    <#assign image = '' />
    <#assign dt    = '' />

    <#-- Assign id -->
    <#attempt>
        <#assign id = page.params.id/>
    <#recover>
	<#assign id = ""/>
    </#attempt>

    <#-- Assign Category. news, redcarpet, moviewreviews, wwk, awful, videos, shows -->
    <#attempt>
        <#assign category=page.params.category/>
    <#recover>
        <#assign category="Latest News"/>
    </#attempt>

    <#-- Assign Franchise -->
    <#attempt>
        <#assign franchise=page.params.franchise/>
    <#recover>
        <#assign franchise=""/>
    </#attempt>

    <#-- Fetch show short name and full name, if applicable. [soup, kktm, kktny, ch, fp enews..] -->
    <#attempt>
        <#assign showShortName=page.params.show!""/>
    <#recover>
        <#assign showShortName=""/>
    </#attempt>

    <#assign showFullName  = p.getShowFullName[showShortName] />

    <#-- Assign appropriate feed -->
    <#attempt>
        <#include "/includes/assign-feed.ftl">
    <#recover>
        <@p.error_message/>
    </#attempt>

    <#-- Initialize -->
    <#assign next = 0/>
    <#assign displayNext = true />



    <#include "/includes/container_top.ftl" />

    <#-- <div width="100%" style="background-color:#E6E6E6;"> -->
    <#-- Flat White background -->
    <div width="100%" style="background-color:#EEEBEB;">

        <#-- Finding matching content from article api and display -->
        <#list article.rss.channel.item as item> 
            <@editor.spacer />
            <#if display == 'LG'>

                <#-- Display image for iPad-->
                <table>
                    <tr>
                        <td>						
                            <img src='${item["eonline:image_full/eonline:imgurl"]}' alt='${item["eonline:image_full/eonline:imgtitle"]?html}' style="border:2px; align:center; margin-left:1em;" class='img-round' />	
                        </td>	
                        <td>						
                            <#-- Display title -->
                            <div class="news-heading">
                                ${item.title?replace("&","&amp;")}</div>
                            <#-- Display date in PST -->
                            <#assign localdate = p.convertTimezone(item["eonline:updated"], 'GMT', 'PST') />
                            <div class="news-date">${localdate}</div>
                            <#-- Display author -->
                            <div class="news-author">By ${item.author?replace("&","&amp;")}</div>

                        </td>
                    </tr>
                </table>
            <#else>
                <div align="center">
                    <img src='${item["eonline:image_full/eonline:imgurl"]}' alt='${item["eonline:image_full/eonline:imgtitle"]}' style="border:2px; align:center;" class='img-round' />
                </div>

                <#-- Display Movie Rating. Somehow this is erroring... -->
                <#--
                	<#if category == "Movie Reviews">			
                	    <div class="rating" style="font-size:24px; margin:5px 0px 5px 5px">${item["eonline:movie_grade"]}</div>
                   	</#if>
                -->

               <#-- Display title -->
               <div class="news-heading">${item.title?replace("&","&amp;")}</div>
               <@editor.spacer />

               <#-- Display date in PST -->
               <#assign localdate = p.convertTimezone(item["eonline:updated"], 'GMT', 'PST') />
               <div class="news-date">${localdate}</div>

               <#-- Display author -->
               <div class="news-author">By ${item.author?replace("&","&amp;")}</div>
            </#if>

            <#-- Display description -->
            <div class="news-description">${item.description?replace("&","&amp;")?trim}</div>

            <#-- Share links -->
            <@p.spacer />
            <#assign mylink = item.link />
            <#assign shareTxt = item.title />
            <#-- Assign url -->
            <#attempt>
               <#assign myurl = page.params.url/>
            <#recover>
               <#assign pg    = "article.ftl"/>
	       <#assign myurl = "http://${site.domain}/${pg}?id=${page.params.id}"/>
            </#attempt>

            <@p.shareLinks myurl mylink shareTxt "share"/>
            <@p.spacer />

            <script type="text/javascript">
              $('#fbButton').href      = "/share.ftl?type=FB&amp;t=${shareTxt?url}&amp;u=${mylink}";
              $('#twitterButton').href = "/share.ftl?type=TW&amp;t=${shareTxt?url}&amp;u=${mylink}";
            </script>

            <#-- Display Links to Related Stories -->
            <#attempt>
                <#assign tags = item["eonline:category"]/>
                <@p.spacer />
                <ul id="relatedArticles">
                    <@p.displayRelatedStories tags category "article_list" id showShortName />
                </ul>
            <#recover>
            </#attempt>

        </#list>

     </div>
            
     <#-- Display the next 3 articles in carousel -->
     <@p.fetchNextArticles category id 3 />

   <#-- <div class="related-stories-heading">Next Articles</div> -->
    <section id="latest-news" class="main">

        <#assign a_count = 0 />
        <#list articles as article>
            <#assign link = '' />
            <#assign title = '' />
            <#assign image = '' />
            <#assign dt = '' />
            <#list article?split(d1) as item>
                <#if item_index == 0>
                    <#assign link = item?trim />
                <#elseif item_index == 1>
                    <#assign title = item />
                <#elseif item_index == 2>
                    <#assign image = item />
                <#elseif item_index == 3>
                    <#assign dt = item /> 
                </#if>
            </#list>

            <#if (a_count = 0) && !(link == '') >
               <div class="related-stories-heading">Next Articles</div>
            </#if>

<#--
<@editor.paragraph text="link=${link}" />
<@editor.paragraph text="link length=${link?length}" />
<@editor.paragraph text="title=${title}" />
<@editor.paragraph text="image=${image}" />
<@editor.paragraph text="dt=${dt}" />
-->

            <#if !(link == '') > <#-- display carousel only if array is not empty -->
                <#-- Display only 3 next articles in the carousel -->
                <#if a_count &lt; 3 >
                        <#if article_index == 0>
                             <article class="latestNewsArticle borderLeft">
                        <#else>
                             <article class="latestNewsArticle">
                        </#if>
                        <a href ="${link}" class="arrow"></a>
                        <img src ="${image}" width="74" height="74"/>
                        <h6><em>${title?replace("&","&amp;")}</em></h6>
                        <div class = "timestamp">${dt}</div>    
                    </article>
                </#if>
            </#if>
            <#assign a_count = a_count + 1 />
        </#list>
    </section>

    <#if !(link == '') > <#-- display page nav indicators only if array is not empty -->
        <div class="sectionNavi latest-news">
            <ol class="navList">
                <#assign a_count = 0 />
                <#list articles as article>
                   <#if article_index == 0>
                       <li></li>
                   <#elseif article_index &lt; 3>
                       <li></li>
                   </#if>
                </#list>
           </ol>
        </div>
    </#if>

<#--
                <div class="sectionNavi latest-news">
                    <ol class="navList">
   <li></li><li></li><li></li>
</ol>
</div>
-->
<#include "/includes/container_bottom.ftl" /> 

<#recover>
  <@p.error_message/>
</#attempt>
</@editor.page>