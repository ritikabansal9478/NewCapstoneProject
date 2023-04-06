public class submitForm extends Slack.ActionDispatcher {

    public override Slack.ActionHandler invoke(Map<String, Object> parameters, Slack.RequestContext context) {
        return Slack.ActionHandler.ack(new Handler(parameters, context));
    }

    public class Handler implements Slack.RunnableHandler {
        Slack.RequestContext context;
        Map<String, Object> parameters;

        public Handler(Map<String, Object> parameters, Slack.RequestContext context) {
            this.context = context;
            this.parameters = parameters;
        }

        public void run () {
            
            Slack.ViewReference viewReference = Slack.View.hello.get();

            On_Deck_Survey_Result__c odRecord = new On_Deck_Survey_Result__c();
            odRecord.User__c = UserInfo.getUserId();
            odRecord.Supporting_prior_project__c = (String) context.getFormData().get('question_two');
            odRecord.Blockers__c = (String) context.getFormData().get('question_six');
            odRecord.Focus_Next_Week__c = (String) context.getFormData().get('question_five');
            odRecord.Focus_this_week__c = (String) context.getFormData().get('question_three');
            odRecord.Planned_Cert_Date__c = (String) context.getFormData().get('question_four');

            System.debug(context.getFormData().get('question_two'));
            System.debug(context.getFormData().get('question_three'));
            System.debug(context.getFormData().get('question_four'));
            System.debug(context.getFormData().get('question_five'));
            System.debug(context.getFormData().get('question_six'));
            
            //System.debug(context.getFormData());


            insert odRecord;

            System.debug('This code is runninggggggggg');
            //viewReference.setParameter('title', 'Apex Modal!');
            //viewReference.setParameter('message', context.getAppId() + ' ' + parameters.getText());

            Slack.ModalView modalView = new Slack.ModalView.builder()
                .viewReference(viewReference)
                .build();

            return; //modalView;

        }
    }

}