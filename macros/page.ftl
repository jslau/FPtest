<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>

<#macro indexTextThanks class="normal" smartphone=true>
        <@editor.paragraph text="Thank you for entering the sweepstakes." class="normal" />
</#macro>

<#assign getShowFullName = {"soup"  : "The Soup"
                           ,"kktny" : "Kourtney & Kim Take New York"
                           ,"kktm"  : "Kourtney & Khloe Take Miami"
                           ,"fp"    : "Fashion Police"
                           ,"ch"    : "Chelsea Lately"
                           ,"klamar": "Khloé & Lamar"
                           ,"kuwtk" : "Keeping Up With The Kardashians"
                      ,"openingact" : "Opening Act"
                           ,"jonas" : "Married to Jonas"
                       ,"redcarpet" : "Red Carpet"
                          ,"trends" : "Trends"
                            ,"lymi" : "Love You, Mean It"
                           ,""      : ""
} />

<#function getShowShortName() >
   <#list page.id?split('/') as p>
      <#if p_index == 1>
         <#return p />
         <#break />
      </#if>
   </#list>
</#function>

<#-- Gray Line -->
<#macro grayline>
	<div class="graylines"><img src="/images/spacer.gif" height="1" width="1" border="0"/></div>
</#macro>

<#-- Red Line -->
<#macro redline>
	<div class="redline"><img src="/images/iPhone/Home/bar_red.png" height="1" width="1" border="0"/></div>
</#macro>

<#-- Spacer -->
<#macro spacer>
	<div class="spacer"><img src="/images/spacer.gif" height="1" width="1" border="0"/></div>
</#macro>

<#-- Red Arrow -->
<#macro redArrow>
	<img src="/images/arrw_gif.gif" align="right"></img>
</#macro>

<#-- Menu Text (not used) -->
<#macro menuText url title>
	<a href="${url}" class="normal_text">
		<table border="0" cellpadding="0" cellspacing="1" align="center" class="menu-item">
			<tr>
				<td class="menu-text" width="99%" >${title}</td>
				<td align="right" ><img src="/images/arrw_gif.gif" align="right"></img></td>
			</tr>
		</table>
		<div class="graylines" style="margin: 3px;"><img src="/images/spacer.gif" height="1" width="1" border="0"/></div>
	</a>
</#macro>


<#-- List Articles -->
<#macro listArticle href img imgw imgh alt tit abs cls rating="" dt="" >
	<#assign w = imgw!"120" />
	<#assign h = imgh!"120" />
	<#if display == 'LG'>
	   <#assign padding = 9 />
	<#else>
	   <#assign padding = 3 />
	</#if>
    <div>
      <#-- <a href="${href}" onclick="return Check_Link_Enabled()" > -->
      <a href="${href}" >
	<table border="0" cellpadding="0" cellspacing="0" align="center" class="${cls}">
		<tr>
			<td width="20%" style="padding-left: ${padding}px;">
					<img src="${img}" alt="${alt?html}" width="${imgw}" height="${imgh}" class="img-round"/>
			</td>
			<#if !(rating == "")>
				<td width="10%" class="rating" >${rating}</td>
			</#if>
			<td>
				<table>
					<tr><td class="list-title-text-${display}">${tit?replace('&','&amp;')}</td></tr>
                                <#attempt>
                                   <#assign localdate = p.convertTimezoneShort(dt, 'GMT', 'PST') />
				   <tr><td class="list-date-text">${localdate}</td></tr>
                                <#recover>
                                </#attempt>
				</table>
			</td>
			<td width="10%">
				<#--<img src="/images/more_arrow.png" style="align:right; width:32px; height:32px; "></img>-->
				<div class="goreadstuff"></div>
			</td>
		</tr>
	   </table>
        </a>
        <@p.grayline />
    </div>
</#macro>


<#-- List Articles for Show. Variation of List Articles, but without URL encoding the "&" in the title. -->
<#macro listArticleShow href img imgw imgh alt tit abs cls rating="" dt="" >
	<#assign w = imgw!"120" />
	<#assign h = imgh!"120" />
	<#if display == 'LG'>
	   <#assign padding = 9 />
	<#else>
	   <#assign padding = 3 />
	</#if>
    <div>
      <#-- <a href="${href}" onclick="return Check_Link_Enabled()" > -->
      <a href="${href}" >
	<table border="0" cellpadding="0" cellspacing="0" align="center" class="${cls}">
		<tr>
			<td width="20%" style="padding-left: 3px;">
					<img src="${img}" alt="${alt?html}" width="${imgw}" height="${imgh}" class="img-round"/>
			</td>
			<#if !(rating == "")>
				<td width="10%" class="rating" >${rating}</td>
			</#if>
			<td>
				<table>
					<tr><td class="list-title-text-${display}">${tit}</td></tr>

                                <#attempt>
                                   <#assign localdate = p.convertTimezoneShort(dt, 'GMT', 'PST') />
				   <tr><td class="list-date-text">${localdate}</td></tr>
                                <#recover>
                                </#attempt>
				</table>
			</td>
			<td width="10%">
				<#--<img src="/images/more_arrow.png" style="align:right; width:32px; height:32px; "></img>-->
				<div class="goreadstuff"></div>
			</td>
		</tr>
	   </table>
        </a>
        <@p.grayline />
    </div>
</#macro>

<#-- List Shows -->
<#macro listShow href img imgw imgh alt tit abs cls showarrow=true>
	<#assign w = imgw!"120" />
	<#assign h = imgh!"120" />
	<#if display == 'LG'>
	   <#assign padding = 9 />
	<#else>
	   <#assign padding = 3 />
	</#if>
           <a href="${href?html}" onclick="return Check_Link_Enabled()" >
		<table border="0" cellpadding="0" cellspacing="0" align="center" class="${cls}">
			<tr>
			<td width="20%" style="padding-left: ${padding}px;">
					<img src="${img}" alt="${alt?html}" width="${imgw}" height="${imgh}" class="img-round"></img>
			</td>

			<td class="list-title-text-${display}">${tit?html}</td>
                        <#if showarrow>
			    <td width="10%">

                                 <!--<img src="images/more_arrow.png" style="align:right; width:32px; height:32px; "></img>-->
								 <div class="goreadstuff"></div>

			    </td>
                        </#if>
			</tr>
		</table>
            </a>
        <@p.grayline />
</#macro>


<#-- List Videos -->
<#macro listVideo href img imgw imgh alt tit abs cls dt="">
  <div style="width:100%;">
    <a href="#" onclick="net.rnmd.sdk.playVideo('${href}');">
      <table width="100%" border="0" cellpadding="0" cellspacing="5" align="center" class="list-gray-SD">
        <tr>
          <td class="tdLeft" style="padding-left: 3px;">
            <img class="video_thumbs" src="${img}" alt="${alt?html}" class="img-round"></img>
            <#--<img class="video_thumbs" src="${img}" alt="${alt?html}" width="${imgw}" height="${imgh}" class="img-round"></img>-->
            <#--<div class="listnail" style="background: url(${img}) center center no-repeat"></div>-->
          </td> 		
          <td class="tdMiddle"> 
              <p class="normal-text">${tit}</p>
              <#attempt>
                <#assign localdate = p.convertTimezoneShort(dt, 'PST', 'PST') />
                <p class="list-date-text">${localdate}</p>
              <#recover>
              </#attempt>
          </td>
          <td class="tdRight">

          <div class="goreadstuff"></div>
          </td>	
        </tr>
      </table>
    </a>
    <@p.grayline />
  </div>
</#macro>



<#-- Convert Timezone -->
<#function convertTimezone(origDate, fromTimezone, toTimezone) >
	<#setting time_zone = 'GMT'>
	<#assign datestring = origDate/>
	<#attempt>
	    <#assign tempDate = datestring?datetime("EEE, dd MMM yyyy hh:mm:ss zzz") />
	    <#setting time_zone = 'PST'>
	    <#assign toDate = tempDate?string("EEE, dd MMM yyyy hh:mm:ss a zzz") />
	<#recover>
	    <#assign toDate = origDate />
	</#attempt>
    <#return toDate >
</#function>

<#-- Convert Timezone for Home Page-->
<#function convertTimezoneShort(origDate, fromTimezone, toTimezone) >
	<#setting time_zone = 'GMT'>
	<#assign datestring = origDate/>
	<#attempt>
            <#-- Try without using AM, PM -->
	    <#assign tempDate = datestring?datetime("EEE, dd MMM yyyy hh:mm:ss a zzz") />
	    <#setting time_zone = 'PST'>
	    <#assign toDate = tempDate?string.short />
	<#recover>
            <#-- Try using AM, PM for Shows feeds -->
	    <#assign tempDate = datestring?datetime("EEE, dd MMM yyyy hh:mm:ss zzz") />
	    <#setting time_zone = 'PST'>
	    <#assign toDate = tempDate?string.short />
	</#attempt>

    <#return toDate >
</#function>


<#-- Convert date time format (for one of video feeds.. -->
<#function convertDateTimeVideo(origString) >
	<#setting time_zone = 'PDT'>
	<#assign datestring = origString/>
	<#attempt>
	    <#assign tempDate = datestring?datetime("yyyy-MM-dd yyyy hh:mm:ss") />
	    <#setting time_zone = 'PDT'>
	    <#assign toDate = tempDate?string.short />
	<#recover>

	</#attempt>

    <#return toDate >
</#function>

<#-- Get franchise links. -->
<#function getFranchiseLink (franchise, isDetail) >
	<#if isDetail>
		<#assign suffix = "_detail">
	<#else>
		<#assign suffix = "">
	</#if>
	<#switch franchise>
		<#case "Marc Malkin">
			<#assign link = "marc_malkin"+suffix+".ftl" /><#break>
		<#case "Answer B!tch">
			<#assign link = "answer_bitch"+suffix+".ftl" /><#break>
		<#case "Party Girl">
			<#assign link = "party_girl"+suffix+".ftl" /><#break>
		<#case "Lyons Den">
			<#assign link = "lyons_den"+suffix+".ftl" /><#break>
		<#case "Watch w/ Kristin">
			<#assign link = "watch_kristin"+suffix+".ftl" /><#break>
		<#case "The Awful Truth">
			<#assign link = "awful_truth"+suffix+".ftl" /><#break>
		<#case "Red Carpet">
			<#assign link = "awards"+suffix+".ftl" /><#break>
		<#default>
			<#assign link = "" />
	</#switch>
	<#return link>
</#function>


<#macro spacer>
	<div class="spacer"><img src="/images/spacer.gif" height="1" width="1" border="0"/></div>
</#macro>

<#macro error_message index=false feed="">
	<#if (page.request.getServerName()?matches('dev\\..*'))!'false'  == true >
		<@editor.paragraph class="bold-center" text="${.error}"/>
		<@editor.paragraph class="bold-center" text="Feed URL: ${feed}"/>
	<#else>
		<#if index>
			<@editor.paragraph class="bold-center" text="Currently the page is not available!"/>
		<#else>
			${page.response.sendRedirect("/index.ftl")}
		</#if>
	</#if>
</#macro>

<#macro displayArticle txt cls>
	<#assign CR = "&#13;"/>
	<#list txt?split(CR) as paragraph>
		<div class="${cls}">${paragraph?html?replace('&amp;','&')}</div>
		<@editor.spacer count=5 />
		<div class="${cls}">${paragraph?html}</div>
		<@editor.spacer count=5 />
		<div class="normal-text-pad">${paragraph?html?replace('&amp;','&')}</div>
	</#list>
</#macro>


<#macro shareLinks myurl mylink mytxt cls size="40">
<#-- Not used.
	<table align="center">
		<tr class="${cls}">
			<td><a href="http://m.facebook.com/sharer.php?t=${mytxt?url}.&amp;u=${mylink}"><img src="/images/facebook.png" height="${size}" width="${size}" alt="Facebook"></img></a></td>&nbsp;&nbsp;
			<td><a href="http://twitter.com/home?status=${mytxt?url}. ${mylink}"><img src="/images/twitter.png" height="${size}" width="${size}" alt="Twitter"></img></a></td>&nbsp;&nbsp;
			<td><a href="http://www.myspace.com/Modules/PostTo/Pages/?u=${mylink}"><img src="/images/myspace.png" border="0" height="${size}" width="${size}" alt="Share on MySpace"></img></a></td>&nbsp;&nbsp;
			<td><a href="/sendtofriend.ftl?url=${mylink}&amp;returnurl=${myurl}"><img src="/images/sms.png" height="${size}" width="${size}" alt="SMS"></img></a></td>&nbsp;&nbsp;
			<td><a href="mailto:?subject=E! Online Mobile Site Article&amp;body=Hi, Take a look at this article from E! Online ${mylink}"><img src="/images/email.png" height="${size}" width="${size}" alt="Email"></img></a></td>
		</tr>
</table>
-->

	<div id="homeShareButton"></div>	
        <style>
	    #homeShareButton{
		background-image:url('/images/iPhone/Details/button_share.png');
		height:32px;
		width:58px;
<#--
		height:32px;
		width:38px;
-->
                margin: 0px auto;
	    }
	</style>
	<script>
	    //$('#homeShareButton').addEventListener('click',this, false);		
	</script>

</#macro>


<#-- Display Franchise Link -->
<#macro displayFranchiseLink category >

            	<#-- Display franchise link, if article belongs to a franchise -->
            	<#if category?starts_with('n_') >
	 	    <#assign isDetail = false />
		    <#assign link = p.getFranchiseLink2(item["eonline:franchise"], isDetail) />
		    <#assign franchiseName = f.franchise[category] />
		    <@editor.spacer />
		    <div class="read-more">
			<a href="article_list.ftl?category=${category}">[Read More ${franchiseName}]</a>
                    </div>
		    <@editor.spacer />
            	</#if>
    
</#macro>

<#-- Fetch Next Articles. Tag names are different depending on the feed.
     Show feeds are differentiated from other article feeds and end with '_news'
-->
<#macro fetchNextArticles category guid numArticles=3 show="">

<#--
     debug:<br/>
     category=${category}<br/>
     guid=${guid}<br/>
     show=${show}<br/>
-->

<#if !(show == "") >
    <#assign isShow = true />
<#else>
    <#assign isShow = false />
</#if>

<#assign str = ''/>
    <#global delE = tool.text.delimiterElement /> <#-- String delimiter separating elements in an article array -->
    <#assign delA = tool.text.delimiterArticle /> <#-- String delimiter separating each article in string array -->
    <#global maxArticlesPerFeed = 60 />

    <#assign feedUrl = f.feeds[category] />

    <#assign newsFeed = tool.content.getRssFeed(feedUrl) />
<#-- debug: feedurl=${feedUrl}<br/>  -->
    <#assign this_index = -1 />
    <#assign next = 0 />   
    <#assign displayNext = false />   

    <#if isShow>
        <#assign newGuid = 'news_' + guid />
    <#else>
        <#assign newGuid = 'b' + guid />
<#-- newGuid=${newGuid}<br/> -->
    </#if>

    <#list newsFeed.rss.channel.item as item> 

        <#if isShow>
            <#assign thisGuid = item["eonline:guid"] />
            <#assign thisTitle = item["eonline:title"] />
            <#assign thisDate = item["eonline:pubDate"] />
        <#else>
            <#assign thisGuid = item.guid />
            <#assign thisTitle = item.title />
            <#assign thisDate = item["eonline:updated"] />
        </#if>

        <#assign thisImg = item["eonline:image_full/eonline:imgurl"] />

        <#if thisGuid == newGuid >
           <#assign this_index = item_index />
           <#assign displayNext = true />  
        </#if>

	<#if displayNext && (item_index &gt; this_index)>

           <#assign localdate = p.convertTimezoneShort(thisDate, 'GMT', 'PST') />

           <#-- Build an array of 3 articles. Each article consists of title, link url and date -->

    <#if isShow>
           <#assign str>
             ${str}article.ftl?category=${category}&amp;id=${thisGuid?replace('news_','b')}&amp;show=${show}${delE}${thisTitle}${delE}${thisImg}${delE}${localdate}${delA} 
           </#assign>
    <#else>
           <#assign str>
             ${str}article.ftl?category=${category}&amp;id=${thisGuid?replace('news_','b')}${delE}${thisTitle}${delE}${thisImg}${delE}${localdate}${delA} 
           </#assign>
    </#if>

	    <#assign next = next+1/>
	    <#if next == numArticles >
		    <#assign displayNext = false/>
	    </#if>
	</#if>

    </#list>

  <#-- Return array of 3 articles in a global variable. Change this to a function later.
       Each article uses delE as delimiter to parse the elements -->

    <#global articles = str?split(delA) />
<#--
  Debug:<br/>
  <#assign a1 = articles[0]?replace('&','&amp;') />
  <#assign b1 = a1 />

  String before SPLIT= ${str}<br/>

  ${articles?size}<br/>
  a1====${a1}<br/>
  b1====${b1}<br/>
-->

</#macro>


<#-- Fecth 3 articles using tags -->
<#macro fetchArticles tags='' numArticles=3 >
<#assign str = ''/>
    <#global delE = tool.text.delimiterElement /> <#-- String delimiter separating elements in an article array -->
    <#assign delA = tool.text.delimiterArticle /> <#-- String delimiter separating each article in string array -->
    <#global maxArticlesPerFeed = 60 />
    <#assign category = 'Latest News' />

    <#-- Fetch news using tags -->
    <#assign newsFeed=tool.content.parseXML("http://syndication.eonline.com/syndication/feeds/iphone/news/index.xml?categories=${tags}")/>
    <#assign displayNext = true />  
    
    <#assign this_index = -1 />
    <#assign next = 0 />   
 
    <#list newsFeed.rss.channel.item as item> 

	<#if displayNext>

           <#assign localdate = p.convertTimezoneShort(item["eonline:updated"], 'GMT', 'PST') />

           <#-- Build an array of 3 articles. Each article consists of title, link url and date -->
           <#assign str>
             ${str}/article.ftl?category=${category}&amp;id=${item.guid}${delE}${item.title?html}${delE}${item["eonline:image_full/eonline:imgurl"]}${delE}${localdate}${delA} 
           </#assign>

	    <#assign next = next+1/>
	    <#if next == numArticles >
		    <#assign displayNext = false />
	    </#if>
	</#if>

    </#list>

  <#-- Return array of 3 articles in a global variable. Change this to a function later.
       Each article uses delE as delimiter to parse the elements -->

    <#global articles = str?split(delA) />

</#macro>

<#-- Display next 3 articles -->
<#macro displayNextArticles category guid numArticles=3 >

    <#global maxArticlesPerFeed = 60 />

    <#assign feedUrl = f.feeds[category] />
    <#assign newsFeed = tool.content.getRssFeed(feedUrl) />

    <#assign this_index = -1 />
    <#assign next = 0 />   
    <#assign displayNext = false />   
    <#assign newGuid = 'b' + guid />

   <div class="nextarticle-bg">
    <#list newsFeed.rss.channel.item as item> 

        <#if item.guid == newGuid >
           <#assign this_index = item_index />
           <#assign displayNext = true />  
		<#if (item_index &lt; maxArticlesPerFeed)>
		    <div class="related-stories-heading">Next Articles</div>
		</#if>  
        </#if>

	<#if displayNext && (item_index &gt; this_index)>

			
			<div class="nextarticle">
		    <a href="article.ftl?category=${category}&amp;id=${item.guid}">
	                <table border="0" cellpadding="0" cellspacing="0" text-align="left" style="table-layout:fixed; width:100%;">
		           <tr>
			      <td style="width:2em;" >
                                 <img src="/images/iPhone/Details/arrow_left.png" style="width:10px; height:17px; vertical-align:text-bottom;" /></td>
			      <td style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" >
                                 ${item.title?html}</td>
		           </tr>
	                </table>
                    </a>
                </div>
	
	    <#assign next = next+1/>
	    <#if next == numArticles >
		    <#assign displayNext = false/>
	    </#if>
	</#if>

    </#list>
  </div>

</#macro>

<#macro displayRelatedStories tags="" category="" non_detail_page="" orig_guid="" show="" relStoriesImg="/images/international/GB/Related_Stories.png">
<#attempt>

  <#attempt>
      <#assign currentLang = .globals.currentCountry />
  <#recover>
        <#assign currentLang = 'uk' />
  </#attempt>

  <#assign feedUrl = f.feeds["Latest News"] />
  <#assign countOfRelStories = 0 />
  <#assign mainLoopCounter = 0 />
  <#if (tags?trim?length > 1)>
    <#assign tags = 'top_stories' />
    <#list tags?split(",") as x>
      <#if (countOfRelStories > 3)>
          <#break>
      </#if>
      <#assign currentCategory = x?trim />
      <#if (currentCategory?length > 0) && (!currentCategory?contains('top_stories'))>
      
          <#assign relatedFeedUrl = feedUrl + '?category=' + currentCategory + '&ed=' + currentLang />
          <#assign relatedFeed = tool.content.getRssFeed(relatedFeedUrl) />

          <#if (relatedFeed?size > 0)>
          
            <#assign testArt = 0 />
            <#assign counterList = 0 />
            <#assign articlePos = 0 />
            <#list relatedFeed.rss.channel.item as item > 
               <#assign counterList = counterList + 1 />  
               <#break>       
            </#list>
          
            <#if (counterList > 0)>
              <#if (mainLoopCounter == 0)> 
                  <div class="related-stories-heading"><img style="height:28px;" src="${relStoriesImg}" ></img></div>
              </#if>
              <#assign mainLoopCounter = mainLoopCounter + 1 />
              
               <#assign counter = 0 />
               <#assign current_pos = 0 />
                <#list relatedFeed.rss.channel.item as item >
                     <#assign current_pos = current_pos + 1 />
                     <#if (counter == 3) || (countOfRelStories == 3)>
                        <#break>
                     </#if>
                     
                     <#assign thisGuid = item.guid?replace('b','') />
                     <#if (thisGuid == orig_guid)>
                     <#else>
                         <#assign countOfRelStories = countOfRelStories + 1 />
                         <#assign counter = counter + 1 />
                         <#assign linkUrl =  "article.ftl?id=${item.guid}"/>                        
                         <li><a href="${linkUrl}${.globals.ipTestB}">${item.title?trim}</a></li>
                     </#if>  
                </#list>
            </#if>
          </#if>
        </#if>

    </#list>
  </#if>
  
<#recover>
	${.error}
</#attempt>
</#macro>

<#-- ############################################################### -->

<#macro displayNextStoriesInt tags="top_stories" category="" non_detail_page="" orig_guid="" show="" lang="ND">
<#attempt>

  <#attempt>
      <#assign currentLang = .globals.currentCountry />
  <#recover>
        <#assign currentLang = 'uk' />
  </#attempt>


  <#assign feedUrl = f.feeds["Latest News"] />
  
  <#assign relatedFeedUrl = feedUrl + '?category=top_stories' + '&ed=' + currentLang />
  <#assign relatedFeed = tool.content.getRssFeed(relatedFeedUrl) />

  <#if (relatedFeed?size > 0)>

    <#assign testArt = 0 />
    <#assign counterList = 0 />
    <#assign articlePos = 0 />
    <#list relatedFeed.rss.channel.item as item > 
       <#assign counterList = counterList + 1 />    
       <#assign thisGuid = item.guid?replace('b','') />
       <#if (thisGuid == orig_guid)>
           <#assign testArt = 1 />
           <#assign articlePos = counterList />
       </#if>
    </#list>
  
    <#if ((testArt == 1) && (articlePos < counterList))>
    
      <#if lang == 0><#-- GB -->
        <#assign nextStoriesImg = '/images/international/GB/Next_Stories.png' />
      <#elseif lang == 1><#-- FR -->
        <#assign nextStoriesImg = '/images/international/French/Next_Stories.png' />
      <#elseif lang == 2><#-- IT -->
        <#assign nextStoriesImg = '/images/international/Italian/Next_Stories.png' />
      <#elseif lang == 3><#-- DE -->
        <#assign nextStoriesImg = '/images/international/German/Next_Stories.png' />
      <#else><#-- GB -->
        <#assign nextStoriesImg = '/images/international/GB/Next_Stories.png' />
      </#if>     
      <div class="related-stories-heading"><img style="height:28px;" src="${nextStoriesImg}"/></div>

      <div class="touchslider" style="width:100%;">
        <div class="dividerDiv">
        <div class="touchslider-viewport" style="margin:0 auto 0 auto;overflow:hidden;">
          <div>
      
             <#assign counter = 0 />
             <#assign counterNav = 0 />
              <#list relatedFeed.rss.channel.item as item >        
                   <#assign thisGuid = item.guid?replace('b','') />
                   <#if (thisGuid == orig_guid)>
                      <#assign counter = 1 />
                   <#elseif (counter > 0 && counter < 5)>
                      <#assign counterNav = counterNav + 1 />
                      <#assign counter = counter + 1 />
                       <#assign linkUrl =  "article.ftl?id=${item.guid?trim}"/> 
                       <div class="touchslider-item">
                        <div class="div_wrap">
                            <table style="width:100%;height:180px;">
                              <tr>
                                  <#--<#assign thumbImg = item["eonline:thumbnail_image/eonline:imgurl"] />-->
                                  <#assign thumbImg = item["eonline:resizerlink"]?replace('resize/$width/$height','resize/200/200') />
                                  <td style="width:25%;"><a class="carousel-links" href="article.ftl?id=${item.guid?trim}${.globals.ipTestB}"><img class="img_carousel" alt="" src="${thumbImg}"></a></td>
                                  <td style="width:75%;">
                                    <a class="carousel-links" href="article.ftl?id=${item.guid?trim}${.globals.ipTestB}"><p class="title_carosel">${item.title?trim}</p></a>
                                    <a class="carousel-links" href="article.ftl?id=${item.guid?trim}${.globals.ipTestB}"><p class="author_carousel">${item.author?trim}</p></a>
                                    <#--<a href="article.ftl?id=${item.guid}" class="arrow"></a>-->
                                  </td>
                              </tr>
                            </table>
                        </div>
                       </div>
                   <#else>
                   </#if>
                   <#if (counter == 4)>
                      <#break>
                   </#if>
              </#list>
        
             </div>
        </div>
        </div>

        <div class="nav-carousel">
          <table style="width:100%;">
            <tr>
              <td style="width:20%;"><span class="touchslider-prev"></span></td>
              <td style="width:60%;">
                  <#if (counterNav == 1)>
                      <span class="touchslider-nav-item touchslider-nav-item-current"></span>
                  <#elseif (counterNav == 2)>
                      <span class="touchslider-nav-item touchslider-nav-item-current"></span>
                      <span class="touchslider-nav-item"></span>
                  <#elseif (counterNav == 3)>
                      <span class="touchslider-nav-item touchslider-nav-item-current"></span>
                      <span class="touchslider-nav-item"></span>
                      <span class="touchslider-nav-item"></span>
                  <#else>
                  </#if>
              </td>
              <td style="width:20%;"><span class="touchslider-next"></span></td>
            </tr>
          </table>
        </div>
      </div>

      <script>
        jQuery(function($) {
            $(".touchslider").touchSlider({/*options*/});
        });
      </script>
  </#if>
  </#if>
  
<#recover>
	${.error}
</#attempt>
</#macro>



<#macro displayNextStoriesInt_old tags="" category="" non_detail_page="" orig_guid="" show="">

<#attempt>
  <#if !(show =="") >
      <#-- use the latest news feed to find related news using tags. The original shows feeds do not contain tags. -->
      <#assign feedUrl = f.feeds["Latest News"] />
  <#else>
      <#assign feedUrl = f.feeds[category] />
  </#if>
  <#assign newsFeed = tool.content.getRssFeed(feedUrl) />
  <#assign displayed = 0 />
  <#if tags?size &gt; 0>
    <#--<div class="related-stories-heading"><img style="height:28px;" src="/images/Related_Stories.png" ></img></div>-->
  </#if>
  <#assign prev_guid = "" />
  <#assign first_guid = "" />

<#list tags as tag >

  <#assign relatedFeedUrl = feedUrl + '&categories=' + tag?replace(' ','_') />

  <#assign relatedFeed = tool.content.getRssFeed(relatedFeedUrl) />


  <#if relatedFeed?size &gt; 0>

     <#assign item_selected = false />
      <#list relatedFeed.rss.channel.item as item >

       <#assign thisGuid = item.guid?replace('b','') />

       <#if !(thisGuid == orig_guid) 
         && !(thisGuid == prev_guid) 
         && !(thisGuid == first_guid)!item_selected >
         <#assign item_selected = true />
         <#assign prev_guid = thisGuid />
         <#if first_guid == "">
           <#assign first_guid = thisGuid />
         </#if>
         <#if !(show =="") >
           <#assign linkUrl =  "article.ftl?category=${category}&amp;id=${item.guid}&amp;show=${show}"/>
         <#else >
           <#assign linkUrl =  "article.ftl?category=${category}&amp;id=${item.guid}"/>
         </#if>
	        
            <#--<li><a href="${linkUrl}">${item.title?html}</a></li>-->
            
            <div class="touchslider-item">
              <div class="div_wrap">
                  <table style="width:100%;height:180px;">
                    <tr>
                        <#assign thumbImg = item["eonline:image_full/eonline:imgurl"] />
                        <td style="width:25%;"><a class="carousel-links" href="article.ftl?id=${item.guid}"><img class="img_carousel" alt="" src="${thumbImg}"></a></td>
                        <td style="width:75%;">
                          <a class="carousel-links" href="article.ftl?id=${item.guid}"><p class="title_carosel">${item.title?html}</p></a>
                          <a class="carousel-links" href="article.ftl?id=${item.guid}"><p class="author_carousel">${item.author?html}</p></a>
                          <#--<a href="article.ftl?id=${item.guid}" class="arrow"></a>-->
                        </td>
                    </tr>
                  </table>
              </div>
            </div>
			
          <#break />
       </#if>

     </#list>
  </#if>
</#list>

<#recover>
	${.error}
</#attempt>
</#macro>

<#-- ############################################################### -->


<#macro displayRelatedStories_old tags="" category="" non_detail_page="" orig_guid="" show="">

<#attempt>
  <#assign feedUrl = f.feeds[category] />
  <#assign newsFeed = tool.content.getRssFeed(feedUrl) />
  <#assign displayed = 0 />
  <#-- tag size = ${tags?size}<br/> -->
  <#if tags?size &gt; 0>
    <div class="related-stories-heading">Related Stories</div>
  </#if>
  <#assign prev_guid = "" />
  <#assign first_guid = "" />

<#list tags as tag >

  <#-- debug: ${tag_index} ${tag}<br/> -->

  <#assign relatedFeedUrl = feedUrl + '&categories=' + tag?replace(' ','_') />
  <#assign relatedFeed = tool.content.getRssFeed(relatedFeedUrl) />


  <#if relatedFeed?size &gt; 0>
     <#-- Debug: Exists for ${tag}<br/> -->
     <#assign item_selected = false />
      <#list relatedFeed.rss.channel.item as item >
<#-- debug
item.guid=${item.guid}<br/>
orig_guid=${orig_guid}<br/>
prev_guid=${prev_guid}<br/>
first_guid=${first_guid}<br/>
-->
       <#if !(item.guid == orig_guid) 
         && !(item.guid == prev_guid) 
         && !(item.guid == first_guid)!item_selected >
         <#assign item_selected = true />
         <#assign prev_guid = item.guid />
         <#if first_guid == "">
           <#assign first_guid = item.guid />
         </#if>
	        <div class="nextarticle">
		    <a href="article.ftl?category=${category}&amp;id=${item.guid}">
	                <table border="0" cellpadding="0" cellspacing="0" text-align="left" style="table-layout:fixed; width:100%;">
		           <tr>
			      <td style="width:2em;" >
                                 <img src="/images/iPhone/Details/arrow_relatedArticles.png" style="width:10px; height:17px; vertical-align:text-bottom;" /></td>
			      <td style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap;" >
                                 ${item.title?html}</td>
		           </tr>
	                </table>
                    </a>
                </div>
          <#break />
       </#if>
     </#list>
  </#if>
</#list>

<#recover>
	${.error}
</#attempt>
</#macro>

<#-- Return playable video link -->
<#function videoPlayLink (contentUrl)>

<#if ua?contains('BlackBerry')>
   <#return "rtsp://eo.rtsp.rnmd.net:554/adservice/${guid}.3g2?siteId=${videoSiteId}&amp;userId=${userId}"/>
<#else>
   <#return "http://ads.rnmd.net/playVideo?siteId=${videoSiteId}&amp;userId=${userId}&amp;content=${contentUrl}"/>
</#if>

</#function>