public with sharing class Slack_ApiHandler {
    

    private Slack.BotClient getBotClient() {
        String teamId = 'T01PY724468';
        Slack.App app = Slack.App.HelloSlackApp.get();
        return app.getBotClientForTeam(teamId);
    }

    public Slack.User getUserByEmail(String email) {
        Slack.UsersLookupByEmailRequest req = new Slack.UsersLookupByEmailRequest.Builder()
            .email(email)
            .build();
        Slack.UsersLookupByEmailResponse res = getBotClient().usersLookupByEmail(req);
        System.debug(res);

        if (!res.isOk()) {
            throw new Slack_ApiErrors.UserLookupByEmailException(res.getError());
        }
        return res.getUser();
    }

    public void postMessage(Slack.ViewReference view, String channelId) {
        Slack.ChatPostMessageRequest req = new Slack.ChatPostMessageRequest.Builder()
            .channel(channelId)
            .viewReference(view)
            .build();
        Slack.ChatPostMessageResponse res = getBotClient().chatPostMessage(req);

        if (!res.isOk()) {
            System.debug(res.getError());
        }
    }

    public String getSlackUserIdFromSFUser(User u) {
            if (!String.isEmpty(u.Slack_User_Id__c)) {
            return u.Slack_User_Id__c;
        }   

        try{
            Slack.User slackUser = getUserByEmail(u.Email);
    
            u.Slack_User_Id__c = slackUser.getId();
            return u.Slack_User_Id__c;
        } catch (Exception e){
            return 'user_not_found';
        }
    }

    /*********************************************************************************** */
     //method to invite users to channel
    @future(callout=true)
    public static void inviteUsersToChannel(String channelId, List<String> userSlackIdsToInvite) {
        Slack.App app = Slack.App.HelloSlackApp.get();
        Slack.BotClient client = app.getBotClientForTeam('T01PY724468');
        System.debug('I am in slackapi handler in inviting user');
        System.debug('inviting user ID: ' + userSlackIdsToInvite);
        System.debug('CHANNEL ID: ' + channelId);
        Slack.ConversationsInviteRequest req = new Slack.ConversationsInviteRequest.Builder()
            .channel(channelId)
            .users(userSlackIdsToInvite)
            .build();
    Slack.ConversationsInviteResponse res = client.conversationsInvite(req);
    if(!res.isOk()) {
        System.debug(res.getError());
    }
    }
 
 
     //method to remove user from channel
    @future(callout=true)
    public static void removeUsersFromChannel(String channelId, List<String> usersSlackIdToRemove) {
        Slack.App app = Slack.App.HelloSlackApp.get();
        Slack.BotClient client = app.getBotClientForTeam('T01PY724468');
        for(String slackId : usersSlackIdToRemove) {
            removeSingleUserFromChannel(channelId, slackId);
        }
    }
 
    private static void removeSingleUserFromChannel(String channelId, String singleUserSlackId) {
        Slack.App app = Slack.App.HelloSlackApp.get();
        Slack.BotClient client = app.getBotClientForTeam('T01PY724468');
        System.debug('I am in slackapi handler in removerUserForChannel');
        Slack.ConversationsKickRequest req = new Slack.ConversationsKickRequest.Builder()
            .channel(channelId)
            .user(singleUserSlackId)
            .build();
        Slack.ConversationsKickResponse res = client.conversationsKick(req);
        System.debug(res);
        if(!res.isOk()) {
            System.debug(res.getError()); 
        }
    }
}