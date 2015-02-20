<@editor.page title="${site.name}" showheader=false showfooter=false >
     <#attempt>
           ${tool.util.getCookie().add("TestCookie", "testEol", 30)}
    <#recover>
    </#attempt>
    <#attempt>
        <#assign testIpClientCountry = page.params.ipCC />
        <#if ((testIpClientCountry?trim?length < 7) || !testIpClientCountry?contains('.'))>
            <#assign testFunction = "" />
        <#else>
            <#assign testFunction = "?ipCC=" +  testIpClientCountry />
        </#if>
    <#recover>
        <#assign testFunction = "" />
    </#attempt>
    ${page.response.sendRedirect('/index.ftl${testFunction}')}
</@editor.page>