public with sharing class Slack_ApiErrors {
    public abstract class SlackApiException extends Exception{}
    
    public class UserLookupByEmailException extends SlackApiException {}
    public class ChatPostException extends SlackApiException{}
    public class ChatUpdateException extends SlackApiException{}
}