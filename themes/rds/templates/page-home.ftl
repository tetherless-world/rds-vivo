<#-- $This file is distributed under the terms of the license in /doc/license.txt$  -->

<@widget name="login" include="assets" />

<#-- 
        With release 1.6, the home page no longer uses the "browse by" class group/classes display. 
        If you prefer to use the "browse by" display, replace the import statement below with the
        following include statement:
        
            <#include "browse-classgroups.ftl">
            
        Also ensure that the homePage.geoFocusMaps flag in the runtime.properties file is commented
        out.
-->
<#import "lib-home-page.ftl" as lh>

<#import "rds-home-page.ftl" as rds>

<!DOCTYPE html>
<html lang="en">
    <head>
        <#include "head.ftl">
        <#if geoFocusMapsEnabled >
            <#include "geoFocusMapScripts.ftl">
        </#if>
        <script type="text/javascript" src="${urls.base}/js/homePageUtils.js?version=x"></script>
    </head>
    
    <body class="${bodyClasses!}" onload="${bodyOnload!}">
    <#-- supplies the faculty count to the js function that generates a random row number for the solr query -->
        <@lh.facultyMemberCount  vClassGroups! />
        <#include "identity.ftl">
	<#include "search.ftl" >

        <#include "menu.ftl">

        <section id="intro" role="region">
            <h2>${i18n().intro_title}</h2>
            <p>${i18n().intro_para1}</p>
	    <p><B>&middot;</B>${i18n().intro_para2}</p>
	    <p><B>&middot;</B>${i18n().intro_para3}</p>
	    <p>${i18n().intro_para4} <a href="http://data.rpi.edu/repository/contact">Contact Us</a></p>
        </section> <!-- #intro -->
        
        <@widget name="login" />
        
        <!-- List of research classes: e.g., articles, books, collections, conference papers -->
        <@lh.researchClasses />
                
        <!-- List of four randomly selected faculty members -->
        <@lh.facultyMbrHtml />

        <!-- List of randomly selected datasets -->
        <@rds.selectedDataHtml />

        <#if geoFocusMapsEnabled >
            <!-- Map display of researchers' areas of geographic focus. Must be enabled in runtime.properties -->
            <@lh.geographicFocusHtml />
        </#if>
        
        <!-- Statistical information relating to property groups and their classes; displayed horizontally, not vertically-->
        <#-- <@lh.allClassGroups vClassGroups! /> -->

        <#include "footer.ftl">
        <#-- builds a json object that is used by js to render the academic departments section -->
        <#-- <@lh.listAcademicDepartments /> -->

        <#-- builds a json object that is used by js to render the selected data section -->
        <@rds.listSelectedData />

    <script>       
        var i18nStrings = {
            researcherString: '${i18n().researcher}',
            researchersString: '${i18n().researchers}',
            currentlyNoResearchers: '${i18n().currently_no_researchers}',
            countriesAndRegions: '${i18n().countries_and_regions}',
            countriesString: '${i18n().countries}',
            regionsString: '${i18n().regions}',
            statesString: '${i18n().map_states_string}',
            stateString: '${i18n().map_state_string}',
            statewideLocations: '${i18n().statewide_locations}',
            researchersInString: '${i18n().researchers_in}',
            inString: '${i18n().in}',
            noFacultyFound: '${i18n().no_faculty_found}',
            placeholderImage: '${i18n().placeholder_image}',
            viewAllFaculty: '${i18n().view_all_faculty}',
            viewAllString: '${i18n().view_all}',
            viewAllDepartments: '${i18n().view_all_departments}',
            noDepartmentsFound: '${i18n().no_departments_found}',
            noDatasetsFound: '${i18n().no_datasets_found}',
            viewAllDatasets: '${i18n().view_all_datasets}'
        };
        // set the 'limmit search' text and alignment
        if  ( $('input.search-homepage').css('text-align') == "right" ) {       
             $('input.search-homepage').attr("value","${i18n().limit_search} \u2192");
        }  
    </script>
    </body>
</html>