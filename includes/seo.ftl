<@editor.code>
<#if (page.request.getServerName()?string?contains('dev.') || page.request.getServerName()?string?contains('qa.'))>
    <title>E! Online - Entertainment News, Celeb Gossip, Hot Photos</title>
<#else>
	<#if (page.id?starts_with("index.ftl"))>
		<title>E! Online - Entertainment News, Celeb Gossip, Hot Photos</title>
		<meta name="description" content="The source for the latest entertainment news, breaking news stories, celebrity gossip and pictures from E! Online Mobile" />
		<meta name="keywords" content="Latest Entertainment News, Entertainment News, Celeb Gossip, Celebrity Gossip"/>
	<#elseif (page.id?starts_with("article.ftl"))>			
		<title>E! Online - Celebrity Blog, Celebrity Gossip News</title>
		<meta name="description" content="The E! Celebrity Blog - The source for entertainment news stories, breaking news stories, celebrity gossip news and pictures" />
		<meta name="keywords" content="Celebrity Blog, Celebrity Gossip News"/>
	<#elseif (page.id?contains("photo.ftl")) || (page.id?contains("photo-archive.ftl"))>
		<title>Celebrity Photos and Breaking News - E! Online</title>
		<meta name="description" content="Celebrity Photos and Breaking News - E! Online" />
		<meta name="keywords" content="Celebrity Photos and Breaking News - E! Online"/>
	<#else>
		<title>E! Online - Entertainment News, Celeb Gossip, Hot Photos</title>
		<meta name="description" content="The source for the latest entertainment news, breaking news stories, celebrity gossip and pictures from E! Online Mobile" />
		<meta name="keywords" content="Latest Entertainment News, Entertainment News, Celeb Gossip, Celebrity Gossip"/>
	</#if>
</#if>
</@editor.code>