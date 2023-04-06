public class sendSurvey extends Slack.SlashCommandDispatcher {

    public override Slack.ActionHandler invoke(Slack.SlashCommandParameters parameters, Slack.RequestContext context) {
        return Slack.ActionHandler.modal(new Handler(parameters, context), 'Send Survey');
    }
 
    public class Handler implements Slack.ModalHandler {
 
        Slack.SlashCommandParameters parameters;
        Slack.RequestContext context;
 
        public Handler(Slack.SlashCommandParameters parameters, Slack.RequestContext context){
            this.parameters = parameters;
            this.context = context;
        }
 
        public Slack.ModalView call() {
            List<On_Deck_Survey_Result__c> queryUserSurvey = [SELECT User__c, Id, CreatedDate, Focus_this_week__c, Planned_Cert_Date__c, Supporting_prior_project__c, Focus_Next_Week__c, Blockers__c
                                                                FROM On_Deck_Survey_Result__c
                                                                WHERE User__c = :UserInfo.getUserID() AND CreatedDate  = LAST_N_DAYS:10
                                                                ORDER BY CreatedDate DESC];

                                

            System.debug(queryUserSurvey);

            On_Deck_Survey_Result__c  latestSingleResult = new On_Deck_Survey_Result__c(); 
            String titleNameInClass;

            if(queryUserSurvey.isEmpty()){
                latestSingleResult = new On_Deck_Survey_Result__c();  
                titleNameInClass = 'New Bench Survey';
                System.debug('this is single result when list is EMPTY ' + latestSingleResult);
            }
            else{
                latestSingleResult = queryUserSurvey[0];
                titleNameInClass = 'Update Bench Survey';
                System.debug('when the list is not empty ' + latestSingleResult);
            }
            Slack.ViewReference viewRef = Slack.View.hello.get();
            viewRef.setParameter('titleName', titleNameInClass);
            viewRef.setParameter('queryUserSurvey', (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(latestSingleResult)));
            viewRef.setParameter('question_two', latestSingleResult.Supporting_prior_project__c);
            viewRef.setParameter('question_three', latestSingleResult.Focus_this_week__c);
            viewRef.setParameter('questionFive', latestSingleResult.Focus_Next_Week__c);
            viewRef.setParameter('questionSix', latestSingleResult.Blockers__c);
            
            Slack.ModalView modalView = new Slack.ModalView.builder()
                .viewReference(viewRef)
                .build();
            return modalView;
        }
    }
 }
