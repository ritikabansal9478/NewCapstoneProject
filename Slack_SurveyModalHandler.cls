public with Sharing class Slack_SurveyModalHandler extends Slack.ActionDispatcher  {

    public override Slack.ActionHandler invoke(Map<String, Object> parameters, Slack.RequestContext context) {
        return Slack.ActionHandler.modal(new Handler(parameters, context));
    }

    public class Handler implements Slack.ModalHandler {
        Map<String, Object> parameters;
        Slack.RequestContext context;

        public Handler(Map<String, Object> parameters, Slack.RequestContext context) {
            this.parameters = parameters;
            this.context = context;
        }

        public Slack.ModalView call() {
            //String name = '';
            Slack.ViewReference viewReference = Slack.View.hello.get();
            viewReference.setParameter('titleName', 'New Bench Survey');
            //Slack.viewReference viewRef = Slack.View.apphome.get();
            //viewRef.setParameter('bodyText', name);
            //viewRef.setParameter('headerText', name);
            //viewReference.setParameter('name', name);
            Slack.ModalView modalView = new Slack.ModalView.builder()
                .viewReference(viewReference)
                .build();
            return modalView;
        }
    }
}