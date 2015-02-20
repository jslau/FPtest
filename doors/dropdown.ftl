<#assign thisUrl=page.request.getServerName()/>
<#if (!page.id?contains("index"))>
  <#--<li><a href="http://${thisUrl}${.globals.ipTestA}" class="doorsDropdownLink">${translation.translations.home[.globals.fixTransl]}</a></li>-->
  <li><a href="http://${thisUrl}${.globals.ipTestA}" class="doorsDropdownLink">${translation.translations.news[.globals.fixTransl]}</a></li>
  <li><a href="http://${thisUrl}?at=2${.globals.ipTestB}" class="doorsDropdownLink">${translation.translations.photos[.globals.fixTransl]}</a></li>
  <li><a href="http://${thisUrl}?at=3${.globals.ipTestB}" class="doorsDropdownLink">${translation.translations.videos[.globals.fixTransl]}</a></li>
<#else>
  <li><a href="#" id="newsMenu" class="doorsDropdownLink">${translation.translations.news[.globals.fixTransl]}</a></li>
  <li><a href="#" id="photosMenu" class="doorsDropdownLink">${translation.translations.photos[.globals.fixTransl]}</a></li>
  <li><a href="#" id="videosMenu" class="doorsDropdownLink">${translation.translations.videos[.globals.fixTransl]}</a></li>
</#if>
<li><a href="http://facebook.com/eonline" class="doorsDropdownLink">Facebook</a></li>
<li><a href="https://mobile.twitter.com/eonline" class="doorsDropdownLink">Twitter</a></li>
<li><a href="http://${thisUrl}/info.ftl${.globals.ipTestA}" class="doorsDropdownLink">${translation.translations.e_info[.globals.fixTransl]}</a></li>
