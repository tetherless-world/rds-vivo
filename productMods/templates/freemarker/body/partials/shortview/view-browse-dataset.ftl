<#import "lib-properties.ftl" as p>

<li class="individual" role="listitem" role="navigation">
    <h1>
        <a href="${individual.profileUrl}" title="${i18n().view_profile_page_for} ${individual.name}}">${individual.name}</a>
    </h1>
    <span class="display-title">Dataset</span>
    <p class="snippet">${individual.snippet}</p>
</li>

