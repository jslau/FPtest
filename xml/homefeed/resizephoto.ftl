  <#-- Resize image -->
  <#assign imgfull = feed.rss.channel.item[i]["eonline:image_small/eonline:imgurl"] />
  <#assign img74 = imgfull?replace('/74/74', '/74/74') />
  <#assign img120 = imgfull?replace('/74/74', '/120/120') />
  <#assign img148 = imgfull?replace('/74/74', '/148/148') />
  <#assign img240 = imgfull?replace('/74/74', '/240/240') />