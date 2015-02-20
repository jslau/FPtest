                <#assign feedUrl = "http://" + page.request.getServerName() + "/xml/homefeed_" + display + ".ftl" />
                <#assign feed = tool.content.getRssFeed(feedUrl) />

                <div class="ad1"><center>
                    <#attempt>
                       <#list feed.sections.section as section >
                          <#if section.name == "Marketing Brick">
                            <#list section.item as item >
                	      <a href="${item.link?replace('&','&amp;')}">
                	         <img src="${item.imgurl}" /></a>
                            </#list>
                          </#if>
                       </#list>
                    <#recover>
                       ERROR displaying marketing brick
                    </#attempt> 
                </center></div>	
