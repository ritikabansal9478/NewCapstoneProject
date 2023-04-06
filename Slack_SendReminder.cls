public with sharing class Slack_SendReminder {

    private static Slack_ApiHandler slackApiHandler = new Slack_ApiHandler();

    public static void sendMessageToUser(User u, Slack.ViewReference view) {
        String slackUserId = slackApiHandler.getSlackUserIdFromSFUser(u);

        if(slackUserId != 'user_not_found'){
            slackApiHandler.postMessage(view, slackUserId);
        }
    }

    public static void sendMessageToUsers(List<User> users, Slack.ViewReference view) {
            for (User u : users) {
                sendMessageToUser(u, view);
            }
            update users;
        }
    }