class EndPoints {
  EndPoints._internal();

  /// BASE
  static const String baseUrl =
      'https://app.digifly-eg.com/api/';
  /// HANY

  static const String allSeasonalCampaigns = 'campaign/seasonal';
  static const String allNonSeasonalCampaigns = 'campaign/non-seasonal';
  static const String getAllCandidates = 'Voters';
  static const String getUserVotes = 'my_vote';
   static const String getEmergenyCampaigns = 'campaign/emergency';
  static const String joinCampaign = 'campaign/user-join';
  static const String getAllCampaigns = 'campaign/all-campaigns';
  static const String campaignSuggestion = 'campaign/user-suggestion';
  static const String campaignComplaign = 'campaign/user-complaint';
  static const String leaveCampaign = 'campaign/user-leave';
  static const String editProfile = 'user-edit';
  static const String homeCalender = 'home-calender';

  /// YOUSEF
  static const String loginApi =
      'https://app.digifly-eg.com/api/login';
  static const String registerApi =
      'https://app.digifly-eg.com/api/register';
  static const String resendOtpCodeApi =
      'https://app.digifly-eg.com/api/resend-code';
  static const String submitOtpCodeAPi =
      'https://app.digifly-eg.com/api/submit-code';
  static const String resetPasswordApi =
      'https://app.digifly-eg.com/api/reset-change-password';
  static const String changePasswordAfterLoginApi =
      'https://app.digifly-eg.com/api/change-password';
  static const String sendOtpCode =
      'https://app.digifly-eg.com/api/new-send-code';
  static const String submitOtpCode =
      'https://app.digifly-eg.com/api/new-submit-code';
  static const String deleteAccount =
      'https://app.digifly-eg.com/api/user-delete';
  static const String sendResetPasswordOtpCode =
      'https://app.digifly-eg.com/api/reset-password';
  static const String SubmitResetPasswordOtpCode =
      'https://app.digifly-eg.com/api/submit-code';
  static const String changePasswordFromReset =
      'https://app.digifly-eg.com/api/reset-change-password';
  static const String VolunteerTrainingProgram =
      'https://app.digifly-eg.com/api/volunteer-opportunities/program';
  static const String oneDayActivity =
      'https://app.digifly-eg.com/api/volunteer-opportunities/activity';
  static const String remoteTasks =
      'https://app.digifly-eg.com/api/volunteer-opportunities/tasks';
  static const String suggestionsVolunteers =
      'https://app.digifly-eg.com/api/volunteer-opportunities/user-suggestion';
  static const String userJoinVolunteer =
      'https://app.digifly-eg.com/api/volunteer-opportunities/user-join';
  static const String userLeftVolunteer =
      'https://app.digifly-eg.com/api/volunteer-opportunities-leave';
  static const String cityApi =
      'https://app.digifly-eg.com/api/cities';
  static const String changePasswordAfterLogin =
      'https://app.digifly-eg.com/api/change-password';
  static const String userJoinedVolunteerOpportunities =
      'https://app.digifly-eg.com/api/all-user-volunteer-opportunities';
  static const String appSettings =
      'https://app.digifly-eg.com/api/app-settings';
  static const String userJoinedCampaigns =
      'https://app.digifly-eg.com/api/all-user-campaigns';
  static const String notificationList =
      'https://app.digifly-eg.com/api/user-notifications';
  static const String currentCampaignsAndOpportunities =
      'https://app.digifly-eg.com/api/user-current-campaigns-opportunities';
  static const String campaignCheckIn =
      'https://app.digifly-eg.com/api/campaign-check-in';
  static const String campaignCheckOut =
      'https://app.digifly-eg.com/api/campaign-check-out';
  static const String campaignCheckGallery =
      'https://app.digifly-eg.com/api/campaign-check-gallery';
}
