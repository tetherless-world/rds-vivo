package edu.cornell.mannlib.vitro.webapp.edit.n3editing.configuration.generators;

import com.hp.hpl.jena.vocabulary.XSD;
import edu.cornell.mannlib.vitro.webapp.controller.VitroRequest;
import edu.cornell.mannlib.vitro.webapp.edit.n3editing.VTwo.EditConfigurationVTwo;
import edu.cornell.mannlib.vitro.webapp.edit.n3editing.VTwo.fields.FieldVTwo;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @author szednik
 */

public class NewDatasetFormGenerator extends BaseEditConfigurationGenerator implements EditConfigurationGenerator {

    private Log log = LogFactory.getLog(NewDatasetFormGenerator.class);

    private String template = "newDatasetForm.ftl";

    //final static String dcat = "http://www.w3.org/ns/dcat#";
    //final static String dct = "http://purl.org/dc/terms/";

    private String N3_PREFIX = "@prefix dcat: <http://www.w3.org/ns/dcat#> . \n"
            + "@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> . \n"
            + "@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> . \n"
            + "@prefix dct: <http://purl.org/dc/terms/> . \n";

    @Override
    public EditConfigurationVTwo getEditConfiguration(VitroRequest vreq, HttpSession session) throws Exception {

        EditConfigurationVTwo config = new EditConfigurationVTwo();

        config.setTemplate(template);

        config.setN3Required(list(
                N3_PREFIX + "?newDataset rdf:type dcat:Dataset . \n"
                        + "?newDataset rdfs:label ?label . \n"
                        + "?newDataset dct:title ?label . \n"
        ));

        config.setN3Optional(list(
                N3_PREFIX + "?newDataset dct:description ?description . \n",
                N3_PREFIX + "?newDataset dct:contributor ?contributor . \n"
        ));

        // TODO call out to external service to get Handle HERE?

        config.addNewResource("newDataset", vreq.getWebappDaoFactory().getDefaultNamespace());

        config.setUrisOnform(list("contributor"));
        config.setLiteralsOnForm(list("label", "description"));

        config.addField(new FieldVTwo().
                setName("label").
                setRangeDatatypeUri(XSD.xstring.getURI()).
                setValidators(getLabelValidators(vreq)));

        config.addField(new FieldVTwo().
                setName("description").
                setRangeDatatypeUri(XSD.xstring.getURI()).
                setValidators(getDescriptionValidators(vreq)));

        config.addField(new FieldVTwo()
                .setName("leadResearcher")
                .setValidators(getLeadResearcherValidators(vreq)));

        config.addField(new FieldVTwo()
                .setName("contributor")
                .setValidators(getContributorValidators(vreq)));

        config.setEntityToReturnTo(" ?newDataset ");

        prepare(vreq, config);
        return config;
    }

    private List<String> getLeadResearcherValidators(VitroRequest vreq) {
        List<String> validators = new ArrayList<String>();
        //validators.add("");
        return validators;
    }

    private List<String> getLabelValidators(VitroRequest vreq) {
        List<String> validators = new ArrayList<String>();
        validators.add("nonempty");
        return validators;
    }

    private List<String> getDescriptionValidators(VitroRequest vreq) {
        List<String> validators = new ArrayList<String>();
        //validators.add("nonempty");
        return validators;
    }

    private List<String> getContributorValidators(VitroRequest vreq) {
        List<String> validators = new ArrayList<String>();
        //validators.add("nonempty");
        return validators;
    }

}
