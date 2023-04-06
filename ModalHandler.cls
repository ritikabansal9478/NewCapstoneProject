public with sharing class ModalHandler extends Slack.ActionDispatcher{

    public override Slack.ActionHandler invoke(
        Map<String, Object> parameters,
        Slack.RequestContext context
    ) {
        return Slack.ActionHandler.modal(new Handler(context));
    }

    public class Handler implements Slack.ModalHandler {
        Slack.RequestContext context;

        public Handler(Slack.RequestContext context) {
            this.context = context;
        }

        public Slack.ModalView call() {
            Map <String, Object> formData = context.getFormData();
            Slack.ViewReference viewReference = Slack.View.apphome.get();
            viewReference.setParameter('title', 'Form Field Value');
            //viewReference.setParameter('message', (String) formData.get('FormFieldName'));
            Slack.ModalView modalView = new Slack.ModalView.builder()
                .viewReference(viewReference)
                .build();
            return modalView;
        }
    }
}