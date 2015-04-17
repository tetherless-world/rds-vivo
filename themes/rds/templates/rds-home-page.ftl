<#-- Renders the html for the selected data section on the customized home page. -->
<#-- Works in conjunction with the rdsHomePageUtils.js file, which contains the ajax call. -->
<#macro selectedDataHtml>
<section id="home-selected-data" class="home-sections">
    <h4>${i18n().datasets_capitalized}</h4>
    <div id="selected-data">
    </div>
</section>
</#macro>

<#macro listSelectedData>
<script>
    var selectedData = [
        <#if selectedDataDG?has_content>
            <#list selectedDataDG as resultRow>
                <#assign uri = resultRow["dataset"] />
                <#assign title = resultRow["dataset_title"]/>
                <#assign leadResearcher = resultRow["leadResearcher"] />
                <#assign leadResearcher_name = resultRow["leadResearcher_name"] />
                <#assign localname = uri?substring(uri?last_index_of("/")) />
                <#-- is there a way to set individualURI in the home page? -->
                {
                    "uri": "${uri}",
                    "title": "${title}",
                    "leadResearcher": "${leadResearcher}",
                    "leadResearcher_name": "${leadResearcher_name}"
                }<#if (resultRow_has_next)>,</#if>
            </#list>
        </#if>
    ];
    var urlsBase = "{urls.base}";
</script>
</#macro>