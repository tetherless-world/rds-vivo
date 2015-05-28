package edu.cornell.mannlib.vitro.webapp.edit.n3editing.configuration.generators;

import com.hp.hpl.jena.vocabulary.XSD;

//import edu.cornell.mannlib.vitro.webapp.beans.VClass;
import edu.cornell.mannlib.vitro.webapp.controller.VitroRequest;
//import edu.cornell.mannlib.vitro.webapp.dao.VitroVocabulary;

import edu.cornell.mannlib.vitro.webapp.edit.n3editing.VTwo.EditConfigurationUtils;
import edu.cornell.mannlib.vitro.webapp.edit.n3editing.VTwo.EditConfigurationVTwo;
import edu.cornell.mannlib.vitro.webapp.edit.n3editing.VTwo.fields.FieldVTwo;

import edu.cornell.mannlib.vitro.webapp.edit.n3editing.configuration.validators.AntiXssValidation;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @author szednik
 */

//EditConfigurationVTwoGenerator ???

public class NewDatasetFormGenerator extends BaseEditConfigurationGenerator implements EditConfigurationGenerator {

    private Log log = LogFactory.getLog(NewDatasetFormGenerator.class);

    final static String template = "newDatasetForm.ftl";

    final static String RDF = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
    final static String RDFS = "http://www.w3.org/2000/01/rdf-schema#";
    final static String DCAT = "http://www.w3.org/ns/dcat#";
    final static String DCT = "http://purl.org/dc/terms/";
    final static String RDS = "http://purl.org/twc/ns/rds#";

    final static String N3_PREFIX =
            "@prefix dcat: <"+ DCAT +"> . " +
            "@prefix rdf: <"+ RDF +"> . " +
            "@prefix rdfs: <"+ RDFS +"> . " +
            "@prefix dct: <"+ DCT +"> . " +
            "@prefix rds: <"+ RDS +"> . ";

    @Override
    public EditConfigurationVTwo getEditConfiguration(VitroRequest vreq, HttpSession session) {

        EditConfigurationVTwo config = new EditConfigurationVTwo();

        config.setTemplate(template);

        config.setN3Required(list(
                N3_PREFIX + "?newDataset rdf:type dcat:Dataset . \n"
                        + "?newDataset rdfs:label ?label . \n"
                        + "?newDataset dct:title ?label . \n"
        ));

        config.setN3Optional(list(
                N3_PREFIX + "?newDataset dct:description ?description . \n",
                N3_PREFIX + "?newDataset dct:contributor ?contributor . \n",
                N3_PREFIX + "?newDataset rds:leadResearcher ?leadResearcher . \n"
        ));

        // TODO call out to external service to get Handle HERE?
        log.info("requesting handle for new dataset");

        config.addNewResource("newDataset", vreq.getWebappDaoFactory().getDefaultNamespace());

        config.setUrisOnform(list("contributor", "leadResearcher"));
        config.setLiteralsOnForm(list("label", "description"));

        // setUrisAndLiteralsInScope(config); ???

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

        config.addValidator(new AntiXssValidation());

        String formUrl = EditConfigurationUtils.getFormUrlWithoutContext(vreq);
        config.setFormUrl(formUrl);

        config.setEntityToReturnTo(" ?newDataset ");

        prepare(vreq, config);
        return config;
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

    private List<String> getLeadResearcherValidators(VitroRequest vreq) {
        List<String> validators = new ArrayList<String>();
        //validators.add("");
        return validators;
    }

    private List<String> getContributorValidators(VitroRequest vreq) {
        List<String> validators = new ArrayList<String>();
        //validators.add("nonempty");
        return validators;
    }

}
