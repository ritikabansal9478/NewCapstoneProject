public class SayHelloSam extends Slack.SlashCommandDispatcher {

    public override Slack.ActionHandler invoke(Slack.SlashCommandParameters parameters, Slack.RequestContext context) {
        return Slack.ActionHandler.ack(new Handler(parameters, context));
    }
 
    public class Handler implements Slack.RunnableHandler {
 
        Slack.SlashCommandParameters parameters;
        Slack.RequestContext context;
 
        public Handler(Slack.SlashCommandParameters parameters, Slack.RequestContext context){
            this.parameters = parameters;
            this.context = context;
        }
 
        public void run() {
            String email = parameters.getText();
            Slack.App app = Slack.App.HelloSlackAppSam.get();
            Slack.BotClient client = app.getBotClientForTeam(context.getTeamId());
            Slack.UsersLookupByEmailRequest emailReq = new Slack.UsersLookupByEmailRequest.Builder()
                .email(email)
                .build();
            Slack.UsersLookupByEmailResponse emailRes = client.usersLookupByEmail(emailReq);
            if(!emailRes.isOk()) {
                System.debug('email req failed ' + emailRes.getError());
                return;
            }
            Slack.User userToSendDm = emailRes.getUser();
            
            Slack.ViewReference viewReference = Slack.View.testMessage.get();
            viewReference.setParameter('name', userToSendDm.getName());
            
            Slack.ChatPostMessageRequest req = new Slack.ChatPostMessageRequest.Builder()
                .channel(userToSendDm.getId())
                .viewReference(viewReference)
                .build();
            Slack.ChatPostMessageResponse res = client.chatPostMessage(req);
            if(!res.isOk()) {
                System.debug('failed to send dm ' + res.getError());
            } else {
                System.debug('success!');
            }
        }
    }
}