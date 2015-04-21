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
            <#if resultRow["dataset"]?has_content>
                <#assign uri = resultRow["dataset"] />
                <#assign title = resultRow["dataset_title"] />

                <#if resultRow["leadResearcher"]?has_content>
                    <#assign leadResearcher = resultRow["leadResearcher"] />
                    <#assign leadResearcher_name = resultRow["leadResearcher_name"] />
                <#else>
                    <#assign leadResearcher = "" />
                    <#assign leadResearcher_name = "" />
                </#if>

                <#if resultRow["keywords"]?has_content>
                    <#assign keywords = resultRow["keywords"] />
                <#else>
                    <#assign keywords = "" />
                </#if>

                <#assign localname = uri?substring(uri?last_index_of("/")) />
                {
                    "uri": "${uri}",
                    "title": "${title}",
                    "leadResearcher": "${leadResearcher}",
                    "leadResearcher_name": "${leadResearcher_name}",
                    "keywords": "${keywords}"
                }<#if (resultRow_has_next)>,</#if>
            </#if>
            </#list>
        </#if>
    ];
    var urlsBase = "${urls.base}";
</script>
</#macro>