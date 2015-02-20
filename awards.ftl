<#ftl ns_prefixes={"eonline":"http://www.eonline.com/static/xml/xmlns/"}>
<@editor.page title="${site.name}" showheader=true showfooter=true>
<#attempt>
<#include "/includes/assign-feed.ftl">
<#include "/includes/article-main.ftl">
<#recover>
${page.response.sendRedirect("/index.ftl")}
</#attempt>
</@editor.page>