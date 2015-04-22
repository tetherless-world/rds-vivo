<#import "lib-vivo-properties.ftl" as p>

<li class="individual" role="listitem" role="navigation">
    <h1>
        <a href="${individual.profileUrl}" title="${i18n().view_profile_page_for} ${individual.name}}">${individual.name}</a>
    </h1>
<span class="title"><strong>Dataset</strong></span>

<#if (details[0].description)?has_content >
    <span class="title"><strong>Description:</strong> ${details[0].description}</span>
</#if>

<#if (details[0].leadResearcher)?has_content >
    <span class="title"><strong>Lead Researcher:</strong> <a href="${urls.base}/individual?uri=${details[0].leadResearcher}">${details[0].leadResearcher_name}</a></span>
</#if>

<#if contributors?has_content>
    <span class="title"><strong>Contributors:</strong>
        <#list contributors as resultRow>
            <#if resultRow?has_content>
                <a href="${urls.base}/individual?uri=${resultRow.contributor}">${resultRow.name}</a>
                <#if (resultRow_has_next)>, </#if>
            </#if>
        </#list>
    </span>
</#if>

<#if (details[0].keywords)?has_content >
    <span class="title"><strong>Keywords:</strong> ${details[0].keywords}</span>
</#if>

</li>

