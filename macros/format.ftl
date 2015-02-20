<#function unescape(text)>
   <#return text?replace('&amp;','&')?replace('&#233;','è')?replace('&#34;','\"')?replace('&#160;',' ')?replace('&#169;','©') />
</#function>
