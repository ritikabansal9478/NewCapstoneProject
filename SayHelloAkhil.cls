public class SayHelloAkhil extends Slack.SlashCommandDispatcher {

    public override Slack.ActionHandler invoke(Slack.SlashCommandParameters parameters, Slack.RequestContext context) {
        return Slack.ActionHandler.modal(new Handler(parameters, context), 'Say Hello Akhil');
    }
 
    public class Handler implements Slack.ModalHandler {
 
        Slack.SlashCommandParameters parameters;
        Slack.RequestContext context;
 
        public Handler(Slack.SlashCommandParameters parameters, Slack.RequestContext context){
            this.parameters = parameters;
            this.context = context;
        }
 
        public Slack.ModalView call() {
            String name = parameters.getText();
            Slack.ViewReference viewReference = Slack.View.hello_akhil.get();
            viewReference.setParameter('name', name);
            viewReference.setParameter('testparam', 'testing testing 123');
            Slack.ModalView modalView = new Slack.ModalView.builder()
                .viewReference(viewReference)
                .build();
            return modalView;
        }
    }
 }