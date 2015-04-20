
$(document).ready(function(){

    $.extend(this, urlsBase);
    $.extend(this, i18nStrings);

    buildSelectedData();

    function buildSelectedData() {

        var datasetCount = selectedData.length;
        var html = "";

        if( datasetCount == 0 ) {
            html = "<ul style='list-style:none'><p><li style='no-datasets-found'>"
            + i18nStrings.noDatasetsFound + "</li></p></ul>";
        } else {

            html = "<ul>";

            for ( var i = 0; i < datasetCount; i++) {
                html += "<li role='listitem'><a href='" + urlsBase + "/individual?uri="
                + selectedData[i].uri + "'>"
                + selectedData[i].title + "</a>";

                html += "<br />"
                + "<span class='title' style='font-size: 0.825em'>";

                if(selectedData[i].leadResearcher != null) {
                    html += "<b>Lead Researcher:</b> <a href='" + urlsBase + "/individual?uri="
                    + selectedData[i].leadResearcher + "'>"
                    + selectedData[i].leadResearcher_name + "</a>"
                    + "</span>";
                }

                if(selectedData[i].keywords != "") {
                    html += "<span class='title' style='font-size: 0.825em'>"
                    + "<b>Keywords:</b> " + selectedData[i].keywords
                    + "</span>";
                }

                html += "</span>"
                + "</li>";
            }

            html += "<li style='all-datasets-link'><a href='"
            + urlsBase
            + "/data#http://www.w3.org/ns/dcat#Dataset' alt='"
            + i18nStrings.viewAllDatasets + "'>"
            + i18nStrings.viewAllString + "</a></li></ul>";
        }

        $('div#selected-data').html(html);
    }

});