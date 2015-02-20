<#macro checkwidget >
   <#assign smsg_widget = (page.params.widget!'') />
   <#if smsg_widget == "true" >
       ${page.request.getSession(true).setAttribute("samsungwidget",smsg_widget)}
       <#if false>
               <@editor.paragraph text="widget value stored in session"/>
       </#if>
   </#if>
</#macro>
<#macro retrievewidget >
    <#assign widget=(page.request.getSession(true).getAttribute("samsungwidget")?string!'')> 
    <@editor.paragraph text="Samsung widget" /> 
    <@editor.paragraph text="${widget}" />       
</#macro>